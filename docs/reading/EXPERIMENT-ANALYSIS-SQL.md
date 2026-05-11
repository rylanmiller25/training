# Experiment Analysis SQL — Panel

**Exercise:** Set 3 from `docs/modules/EXPERIMENTATION.md`  
**Schema:** Panel data model (`docs/projects/experimentation_platform/DATA-MODEL.md`)  
**Status:** In progress

---

## Key tables for this exercise

| Table | What it holds |
|---|---|
| `assignments` | Which user was assigned to which variant in which run |
| `variants` | The variant definitions — key, label, weight |
| `events` | Outcome events fired by the customer's product |
| `experiments` | Experiment config — outcome metric, outcome window |
| `experiment_runs` | When each run started and stopped |

Assume a single run throughout. Filter on `run_id = '<your_run_id>'` wherever needed.

---

## 1. Assignment counts by variant

**What this does:** Counts how many users were assigned to each variant. Used to check whether the actual split matches the intended split (e.g. 50/50).

**Tables needed:** `assignments`, `variants`

**Columns to use:** `assignments.variant_id`, `variants.key`, `variants.weight`

```sql
SELECT assignments.variant_id, variants.id, key, weight, COUNT(*) AS count_assigned_users
FROM assignments
LEFT JOIN variants
    ON assignments.variant_id = variants.id
WHERE assignments.run_id = '<your_run_id>'
GROUP BY variant_id, key, weight
```

---

## 2. Chi-square SRM test

**What this does:** Tests whether the observed assignment split is statistically different from the expected split. If it is, the experiment has a Sample Ratio Mismatch and results are untrustworthy.

**How chi-square works here:** For each variant, you calculate `(observed - expected)^2 / expected` and sum across all variants. A result above ~3.84 (for 1 degree of freedom, α = 0.05) indicates SRM.

**Tables needed:** Build on query 1 — you need observed counts and expected counts (total users × variant weight).

```sql
WITH variant_counts AS (
    SELECT assignments.variant_id, variants.id, key, weight, COUNT(*) AS count_assigned_users
    FROM assignments
    LEFT JOIN variants
        ON assignments.variant_id = variants.id
    WHERE assignments.run_id = '<your_run_id>'
    GROUP BY variant_id, key, weight
),
chi_components AS (
    SELECT
        key,
        count_assigned_users AS observed,
        SUM(count_assigned_users) OVER () * weight AS expected,
        (count_assigned_users - SUM(count_assigned_users) OVER () * weight)^2
            / (SUM(count_assigned_users) OVER () * weight) AS chi_contribution
    FROM variant_counts
)
SELECT
    key,
    observed,
    expected,
    chi_contribution,
    SUM(chi_contribution) OVER () AS chi_square_statistic
FROM chi_components
```

---

## 3. Average treatment effect (ATE) with standard error

**What this does:** Computes the difference in conversion rate between treatment and control, and how uncertain that estimate is.

**What you're computing:**
- Conversion rate per variant = users who converted / users assigned
- ATE = treatment conversion rate − control conversion rate
- Standard error = measure of uncertainty around that difference

**A user "converted" if:** they fired the experiment's outcome event within the outcome window after their assignment.

**Tables and what each contributes:**

| Table | Join condition | Columns in scope from it |
|---|---|---|
| `assignments` | Starting table | `user_id`, `variant_id`, `assigned_at`, `run_id`, `experiment_id` |
| `variants` | `assignments.variant_id = variants.id` | `key` |
| `experiments` | `assignments.experiment_id = experiments.id` | `outcome_metric`, `outcome_window_seconds` |
| `events` | `assignments.user_id = events.user_id` | `event_name`, `occurred_at` |

**Two required filters on events** (both must be true for an event to count as a conversion):
- `events.event_name = experiments.outcome_metric`
- `events.occurred_at <= assignments.assigned_at + (experiments.outcome_window_seconds * interval '1 second')`

**Use a LEFT JOIN to events** so non-converters still appear as rows with NULL event columns.

**Counting:**
- Total users: `COUNT(DISTINCT assignments.user_id)`
- Converters: `COUNT(events.user_id)` — NULL rows from LEFT JOIN are skipped automatically
- Conversion rate: `COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id)`
- Standard error: `SQRT(p * (1 - p) / n)` where p = conversion rate, n = total users

**GROUP BY:** `variants.key`

```sql
WITH variant_stats AS (
    SELECT
        variants.key,
        COUNT(DISTINCT assignments.user_id) AS user_count,
        COUNT(events.user_id) AS converter_count,
        COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id) AS conversion_rate,
        SQRT(
            (COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            * (1 - COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            / COUNT(DISTINCT assignments.user_id)
        ) AS standard_error
    FROM assignments
    LEFT JOIN variants ON assignments.variant_id = variants.id
    LEFT JOIN experiments ON assignments.experiment_id = experiments.id
    LEFT JOIN events
        ON assignments.user_id = events.user_id
        AND events.event_name = experiments.outcome_metric
        AND events.occurred_at <= assignments.assigned_at + (experiments.outcome_window_seconds * interval '1 second')
    WHERE assignments.run_id = '<your_run_id>'
    GROUP BY variants.key
)
SELECT * FROM variant_stats
```

---

## 4. 95% confidence interval on the ATE

**What this does:** Puts bounds on the ATE estimate. The 95% CI is: ATE ± 1.96 × standard error of the difference.

**What's in scope:** No new table joins. Build on query 3 using a CTE — query 3 already gives you `key`, `conversion_rate`, and `standard_error`.

**What you're computing:**
- ATE = `treatment.conversion_rate − control.conversion_rate`
- SE of the difference = `SQRT(control.standard_error^2 + treatment.standard_error^2)`
- Lower bound = `ATE − 1.96 × SE`
- Upper bound = `ATE + 1.96 × SE`

**Getting treatment and control on the same row:** Query 3 returns two rows (one per variant). Split into two CTEs and cross join to get them side by side:

```sql
WITH variant_stats AS (
    SELECT
        variants.key,
        COUNT(DISTINCT assignments.user_id) AS user_count,
        COUNT(events.user_id) AS converter_count,
        COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id) AS conversion_rate,
        SQRT(
            (COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            * (1 - COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            / COUNT(DISTINCT assignments.user_id)
        ) AS standard_error
    FROM assignments
    LEFT JOIN variants ON assignments.variant_id = variants.id
    LEFT JOIN experiments ON assignments.experiment_id = experiments.id
    LEFT JOIN events
        ON assignments.user_id = events.user_id
        AND events.event_name = experiments.outcome_metric
        AND events.occurred_at <= assignments.assigned_at + (experiments.outcome_window_seconds * interval '1 second')
    WHERE assignments.run_id = '<your_run_id>'
    GROUP BY variants.key
),
control AS (SELECT * FROM variant_stats WHERE key = 'control'),
treatment AS (SELECT * FROM variant_stats WHERE key = 'treatment')
SELECT
    treatment.conversion_rate - control.conversion_rate AS ate,
    SQRT(control.standard_error^2 + treatment.standard_error^2) AS se_difference,
    (treatment.conversion_rate - control.conversion_rate) - 1.96 * SQRT(control.standard_error^2 + treatment.standard_error^2) AS lower_bound,
    (treatment.conversion_rate - control.conversion_rate) + 1.96 * SQRT(control.standard_error^2 + treatment.standard_error^2) AS upper_bound
FROM control, treatment
```

---

## 5. Subgroup ATE for two pre-specified segments

**What this does:** Runs the same ATE calculation as query 3, but separately within each subgroup.

**Tables and what each contributes:**

| Table | Join condition | Columns in scope from it |
|---|---|---|
| `assignments` | Starting table | `user_id`, `variant_id`, `assigned_at`, `run_id`, `experiment_id` |
| `variants` | `assignments.variant_id = variants.id` | `key` |
| `experiments` | `assignments.experiment_id = experiments.id` | `outcome_metric`, `outcome_window_seconds` |
| `events` | `assignments.user_id = events.user_id` | `event_name`, `occurred_at` |
| `users` | `assignments.user_id = users.id` | `attributes` (JSONB) |

**Reading a JSONB field:** `users.attributes->>'founderType'` returns the value as text — e.g. `'technical'` or `'non_technical'`.

**Additional WHERE filter:** `users.attributes->>'founderType' IN ('technical', 'non_technical')`

**GROUP BY:** `users.attributes->>'founderType'`, `variants.key` — both, to get one row per subgroup × variant combination.

Everything else (joins, counting, conversion rate, standard error) is identical to query 3.

```sql
WITH variant_stats AS (
    SELECT
        variants.key, users.attributes->>'founderType' AS subgroup,
        COUNT(DISTINCT assignments.user_id) AS user_count,
        COUNT(events.user_id) AS converter_count,
        COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id) AS conversion_rate,
        SQRT(
            (COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            * (1 - COUNT(events.user_id)::float / COUNT(DISTINCT assignments.user_id))
            / COUNT(DISTINCT assignments.user_id)
        ) AS standard_error
    FROM assignments
    LEFT JOIN variants ON assignments.variant_id = variants.id
    LEFT JOIN experiments ON assignments.experiment_id = experiments.id
    LEFT JOIN users ON assignments.user_id = users.id
    LEFT JOIN events
        ON assignments.user_id = events.user_id
        AND events.event_name = experiments.outcome_metric
        AND events.occurred_at <= assignments.assigned_at + (experiments.outcome_window_seconds * interval '1 second')
    WHERE assignments.run_id = '<your_run_id>' AND users.attributes->>'founderType' IN ('technical', 'non_technical')
    GROUP BY users.attributes->>'founderType', variants.key
)
SELECT * FROM variant_stats
-- Write a query that returns:
-- subgroup value, variant key, total user count, converter count, conversion rate
-- for each combination of subgroup × variant
```

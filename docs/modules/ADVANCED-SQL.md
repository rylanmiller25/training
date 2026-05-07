# Module: Advanced SQL and Analytics Engineering

**Phase:** 2  
**Slug:** `advanced-sql`  
**Status:** not started  

---

## What it is / how to think about it

The Phase 1 SQL module teaches you to write correct queries. This module teaches you to write queries that are fast, maintainable, and designed for analytics — the kind of SQL that runs your experiment results dashboard, powers your WTP curves, and doesn't fall over when your data is 10× larger than you expected.

**Mental model:** Think of two distinct SQL skill sets. *Transactional SQL* is what backend engineers write — short, precise queries that insert and fetch individual records quickly. *Analytical SQL* is what data teams write — longer queries that aggregate millions of rows, compute cohorts, build funnels, and calculate retention curves. This module focuses on the second kind, which is what an experimentation platform needs most.

---

## Prerequisites
- `sql` (Phase 1) — this module builds directly on CTEs, window functions, and JOINs

---

## Best resources

**Primary:**
1. [Mode SQL Tutorial — Advanced](https://mode.com/sql-tutorial/intro-to-advanced-sql/) — the advanced section covers window functions, pivoting, and performance; run queries in-browser
2. [Use The Index, Luke](https://use-the-index-luke.com/) — the definitive resource on how database indexes actually work; read chapters 1–3 at minimum
3. [dbt documentation — Getting Started](https://docs.getdbt.com/docs/introduction) — the standard tool for analytics engineering; read the overview and "How dbt works" sections

**Supporting:**
- [Serious SQL — Data with Danny](https://www.datawithdanny.com/) — real analytics problems including health and marketing datasets; paid but thorough
- [PostgreSQL docs — Window Functions](https://www.postgresql.org/docs/current/tutorial-window.html) — authoritative reference
- [pganalyze blog](https://pganalyze.com/blog) — practical query optimization for Postgres

**YouTube:**
- [EXPLAIN ANALYZE — Hussein Nasser](https://www.youtube.com/watch?v=9_apAJ9D4FY) (25 min — how to read a query plan)
- [dbt in 100 seconds — Fireship](https://www.youtube.com/watch?v=5rNquRnNb4E) (2 min)
- [Cohort analysis in SQL — Kahan Data Solutions](https://www.youtube.com/watch?v=TJHHxzJnKpM) (20 min)

---

## Core concepts to cover

### Query optimization and EXPLAIN ANALYZE

Before you can optimize a query, you need to read the query plan the database generates.

```sql
EXPLAIN ANALYZE
SELECT u.id, COUNT(e.id) as event_count
FROM users u
LEFT JOIN events e ON u.id = e.user_id
WHERE u.created_at > '2024-01-01'
GROUP BY u.id;
```

What to look for in the output:
- **Seq Scan vs Index Scan:** sequential scan reads every row; index scan jumps to matching rows. Seq scan on a large table is usually a problem.
- **Rows:** the estimated vs. actual row count. Large discrepancies mean stale statistics — run `ANALYZE tablename`.
- **Cost:** arbitrary units; useful for comparing two versions of the same query, not as an absolute measure.
- **Hash Join vs Nested Loop vs Merge Join:** the join algorithm chosen. Nested loop is fast when one side is small; hash join is better for large tables.

The skill: run EXPLAIN ANALYZE, identify the slowest node (look for high actual time and high row count), and fix it — usually by adding an index on the column being filtered or joined.

### Indexing — what actually happens

An index is a separate data structure (typically a B-tree) that maps column values to row locations. Without an index, Postgres scans every row. With an index, it looks up the location in O(log n) time.

```sql
-- Index on a single column (most common)
CREATE INDEX idx_events_user_id ON events(user_id);

-- Composite index (order matters — leftmost columns are used first)
CREATE INDEX idx_events_user_created ON events(user_id, created_at);

-- Partial index (only index rows matching a condition — smaller, faster)
CREATE INDEX idx_events_active ON events(user_id) WHERE status = 'active';

-- Index on expression
CREATE INDEX idx_users_lower_email ON users(LOWER(email));
```

When NOT to index: indexes slow down writes (INSERT, UPDATE, DELETE). Don't add indexes speculatively — add them when you have a slow query to fix.

### Advanced window functions

Building on Phase 1 basics — more patterns that come up constantly in analytics:

```sql
-- NTILE: divide rows into N equal buckets (useful for percentile segmentation)
SELECT user_id, revenue,
  NTILE(4) OVER (ORDER BY revenue) as revenue_quartile
FROM user_revenue;

-- PERCENT_RANK: where does this row fall in the distribution (0 to 1)?
SELECT user_id, revenue,
  PERCENT_RANK() OVER (ORDER BY revenue) as percentile
FROM user_revenue;

-- FIRST_VALUE / LAST_VALUE: reference first or last value in the window
SELECT date, revenue,
  FIRST_VALUE(revenue) OVER (PARTITION BY user_id ORDER BY date) as first_revenue
FROM user_revenue;

-- Window frames: control exactly which rows the window includes
-- ROWS BETWEEN 6 PRECEDING AND CURRENT ROW = 7-day rolling window
SELECT date, revenue,
  AVG(revenue) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as rolling_7day_avg
FROM daily_revenue;

-- Running total that resets per group
SELECT user_id, date, amount,
  SUM(amount) OVER (PARTITION BY user_id ORDER BY date) as cumulative_spend
FROM payments;
```

### Cohort analysis

Cohort analysis groups users by when they joined and tracks their behavior over time. The standard pattern: "Of users who signed up in January, what % were still active 30 days later? 60 days? 90 days?"

```sql
-- Step 1: assign each user to their signup cohort (month)
WITH user_cohorts AS (
  SELECT 
    id as user_id,
    DATE_TRUNC('month', created_at) as cohort_month
  FROM users
),
-- Step 2: for each user-activity pair, compute days since signup
user_activity AS (
  SELECT
    e.user_id,
    uc.cohort_month,
    DATE_TRUNC('month', e.occurred_at) as activity_month,
    EXTRACT(MONTH FROM AGE(
      DATE_TRUNC('month', e.occurred_at), 
      uc.cohort_month
    )) as months_since_signup
  FROM events e
  JOIN user_cohorts uc ON e.user_id = uc.user_id
),
-- Step 3: count cohort size and active users per period
cohort_counts AS (
  SELECT
    cohort_month,
    months_since_signup,
    COUNT(DISTINCT user_id) as active_users
  FROM user_activity
  GROUP BY 1, 2
)
-- Step 4: compute retention rate (divide by cohort size at month 0)
SELECT
  cohort_month,
  months_since_signup,
  active_users,
  FIRST_VALUE(active_users) OVER (
    PARTITION BY cohort_month 
    ORDER BY months_since_signup
  ) as cohort_size,
  ROUND(100.0 * active_users / 
    FIRST_VALUE(active_users) OVER (
      PARTITION BY cohort_month 
      ORDER BY months_since_signup
    ), 1) as retention_pct
FROM cohort_counts
ORDER BY cohort_month, months_since_signup;
```

### Funnel analysis

A funnel tracks users through a sequence of steps and measures drop-off at each step.

```sql
WITH funnel AS (
  SELECT
    user_id,
    MAX(CASE WHEN event_type = 'signup' THEN 1 ELSE 0 END) as did_signup,
    MAX(CASE WHEN event_type = 'onboarding_complete' THEN 1 ELSE 0 END) as did_onboard,
    MAX(CASE WHEN event_type = 'first_experiment' THEN 1 ELSE 0 END) as did_experiment,
    MAX(CASE WHEN event_type = 'paid_conversion' THEN 1 ELSE 0 END) as did_convert
  FROM events
  GROUP BY user_id
)
SELECT
  COUNT(*) as signups,
  SUM(did_onboard) as onboarded,
  SUM(did_experiment) as ran_experiment,
  SUM(did_convert) as converted,
  ROUND(100.0 * SUM(did_onboard) / COUNT(*), 1) as signup_to_onboard_pct,
  ROUND(100.0 * SUM(did_experiment) / NULLIF(SUM(did_onboard), 0), 1) as onboard_to_experiment_pct,
  ROUND(100.0 * SUM(did_convert) / NULLIF(SUM(did_experiment), 0), 1) as experiment_to_convert_pct
FROM funnel;
```

### Experiment analysis queries

The SQL backbone of A/B test results — computing treatment effects directly in SQL.

```sql
-- Average Treatment Effect (ATE) with confidence interval approximation
WITH experiment_results AS (
  SELECT
    a.variant_id,
    COUNT(DISTINCT a.user_id) as users,
    SUM(o.value) as total_outcome,
    AVG(o.value) as mean_outcome,
    STDDEV(o.value) as stddev_outcome
  FROM assignments a
  LEFT JOIN outcomes o ON a.user_id = o.user_id 
    AND o.experiment_id = a.experiment_id
  WHERE a.experiment_id = 'exp_001'
  GROUP BY a.variant_id
)
SELECT
  variant_id,
  users,
  ROUND(mean_outcome::numeric, 4) as mean_outcome,
  -- Standard error of the mean
  ROUND((stddev_outcome / SQRT(users))::numeric, 4) as standard_error,
  -- 95% CI bounds (approximation using 1.96)
  ROUND((mean_outcome - 1.96 * stddev_outcome / SQRT(users))::numeric, 4) as ci_lower,
  ROUND((mean_outcome + 1.96 * stddev_outcome / SQRT(users))::numeric, 4) as ci_upper
FROM experiment_results;

-- Subgroup treatment effect (HTE query skeleton)
SELECT
  a.variant_id,
  u.plan_tier,           -- the subgroup dimension
  COUNT(DISTINCT a.user_id) as users,
  AVG(o.value) as mean_outcome,
  STDDEV(o.value) as stddev_outcome
FROM assignments a
JOIN users u ON a.user_id = u.id
LEFT JOIN outcomes o ON a.user_id = o.user_id
WHERE a.experiment_id = 'exp_001'
GROUP BY a.variant_id, u.plan_tier
ORDER BY u.plan_tier, a.variant_id;
```

### JSON/JSONB for flexible event schemas

Experiment event tracking often uses flexible JSON schemas — you don't know every attribute you'll want to capture upfront. Postgres JSONB handles this efficiently.

```sql
-- Store flexible event properties
CREATE TABLE events (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  event_type TEXT NOT NULL,
  properties JSONB,              -- flexible key-value store
  occurred_at TIMESTAMP NOT NULL
);

-- Query into nested JSON
SELECT 
  user_id,
  properties->>'plan_tier' as plan_tier,
  (properties->>'revenue')::numeric as revenue
FROM events
WHERE event_type = 'conversion'
  AND properties->>'plan_tier' = 'pro';

-- Index a JSONB field for performance
CREATE INDEX idx_events_plan_tier ON events((properties->>'plan_tier'));

-- Aggregate over a JSONB field
SELECT
  properties->>'acquisition_channel' as channel,
  COUNT(*) as conversions,
  AVG((properties->>'ltv')::numeric) as avg_ltv
FROM events
WHERE event_type = 'conversion'
GROUP BY properties->>'acquisition_channel';
```

### Recursive CTEs

For hierarchical data (org charts, category trees, referral chains):

```sql
-- Trace the referral chain for a given user
WITH RECURSIVE referral_chain AS (
  -- Base case: the starting user
  SELECT id, email, referred_by_id, 0 as depth
  FROM users
  WHERE id = 12345
  
  UNION ALL
  
  -- Recursive case: find who referred this user
  SELECT u.id, u.email, u.referred_by_id, rc.depth + 1
  FROM users u
  JOIN referral_chain rc ON u.id = rc.referred_by_id
  WHERE rc.depth < 10  -- prevent infinite loops
)
SELECT * FROM referral_chain ORDER BY depth;
```

### dbt — analytics engineering

dbt (data build tool) transforms raw data in your warehouse into analysis-ready tables using SQL + version control. It's the standard tool for analytics teams.

Core concepts:
- **Models:** SQL SELECT statements that dbt materializes as tables or views
- **Sources:** raw tables you're reading from (defined in YAML)
- **Tests:** assertions about your data (not null, unique, referential integrity)
- **Documentation:** auto-generated from inline comments
- **Lineage:** dbt generates a dependency graph of all your models

Why it matters: instead of running queries manually or in one-off scripts, dbt makes your analytics SQL version-controlled, tested, and documented. For the experimentation platform, dbt would transform raw event data into clean experiment results tables.

---

## Exercises

**Set 1 — EXPLAIN ANALYZE (45 min):**
Install Postgres locally (or use Supabase free tier). Create a `users` table with 100,000 rows and an `events` table with 1,000,000 rows (use `generate_series` to populate).

Run a query joining these tables without an index. Run EXPLAIN ANALYZE and note the cost and scan type. Add an index. Run EXPLAIN ANALYZE again. Document the difference.
Save findings to `docs/reading/QUERY-OPTIMIZATION-EXERCISE.md`.

**Set 2 — Cohort retention analysis (45 min):**
Using the Mode in-browser editor (or your local Postgres), write a cohort retention query against their sample data. Output should be a matrix: cohort month as rows, months since signup as columns, retention % as values.
Save the query and results interpretation to `docs/reading/COHORT-ANALYSIS-EXERCISE.md`.

**Set 3 — Experiment SQL for the platform (45 min):**
Design the SQL queries that will power the experimentation platform's results dashboard. Write queries for:
1. Compute ATE with standard error for a given experiment
2. Compute subgroup means by a categorical user attribute (e.g., plan tier)
3. Count experiment participants by variant and flag any imbalance (variant sizes differ by more than 5%)
4. Identify users who were assigned to multiple variants (an experiment integrity check)

Save to `docs/reading/EXPERIMENT-SQL-QUERIES.md`.

**Set 4 — dbt setup (60 min):**
Follow the dbt Core getting started guide. Set up a dbt project connected to a local Postgres database. Write one model that transforms raw `events` data into a clean `experiment_assignments` table. Run `dbt run` and `dbt test`.
Save notes and the model SQL to `docs/reading/DBT-EXERCISE.md`.

---

## Checks — you understand this when you can:
- [ ] Read an EXPLAIN ANALYZE output and identify why a query is slow
- [ ] Add the right index to fix a slow JOIN or filter
- [ ] Write a cohort retention query from scratch
- [ ] Write a funnel analysis query for a multi-step user flow
- [ ] Write SQL to compute the ATE and standard error for an A/B test
- [ ] Query into a JSONB field and create an index on a JSONB property
- [ ] Explain what dbt is and what problem it solves in an analytics workflow

---

## Artifacts to commit
- [ ] `docs/reading/QUERY-OPTIMIZATION-EXERCISE.md`
- [ ] `docs/reading/COHORT-ANALYSIS-EXERCISE.md`
- [ ] `docs/reading/EXPERIMENT-SQL-QUERIES.md`
- [ ] `docs/reading/DBT-EXERCISE.md`
- [ ] Glossary entries: EXPLAIN ANALYZE, B-tree index, composite index, partial index, cohort analysis, funnel analysis, JSONB, dbt, model (dbt), analytics engineering
- [ ] Log entry in `docs/LOG.md`

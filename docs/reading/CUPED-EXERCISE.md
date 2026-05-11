# CUPED Implementation Exercise — Panel

**Exercise:** Set 4 from `docs/modules/EXPERIMENTATION.md`  
**Status:** Complete

---

## 1. Pre-experiment covariates

For a conversion rate experiment (free → paid upgrade), the covariate needs to predict whether a user will convert — independent of which variant they're assigned to. Panel collects the following automatically with no extra customer instrumentation:

**From the `events` table (pre-assignment history):**
- Login count before assignment
- Session count before assignment
- Key feature actions before assignment (experiments viewed, results checked, etc.)
- Pricing page views before assignment

**From the `users` table:**
- Days since first seen (`experiment_start - users.first_seen_at`)
- Plan tier at time of assignment

**From auto-detected attributes:**
- Acquisition channel (organic, paid, referral)
- Device type, country

All of these are used together as inputs to a regression rather than selecting one. Using multiple covariates captures more variance than any single covariate — the variance reduction is the R² of the full regression rather than ρ² of a single variable. This is equivalent to the Frisch-Waugh-Lovell theorem: the CUPED-adjusted ATE is the same as the coefficient on the treatment indicator in a single OLS regression of Y on treatment + all covariates.

**Eligibility:** CUPED is only applied to users with sufficient pre-experiment history. Users with no event history before assignment (new signups, first-touch onboarding experiments) fall back to unadjusted analysis automatically.

---

## 2. Pseudocode for CUPED-adjusted metric

```
function compute_cuped_adjusted_outcomes(run_id):

    experiment_start = get_run_start_time(run_id)

    // Step 1: collect outcome and covariates for each assigned user
    for each user in assignments where run_id = run_id:

        Y[user] = 1 if user converted within outcome window, else 0

        X[user] = {
            login_count:        count of login events before experiment_start,
            session_count:      count of session events before experiment_start,
            feature_actions:    count of key product actions before experiment_start,
            pricing_page_views: count of pricing page events before experiment_start,
            days_since_signup:  experiment_start - users.first_seen_at
        }

    // Step 2: check sufficient history — fall back if not enough
    if users_with_history < MIN_HISTORY_THRESHOLD:
        return Y  // unadjusted

    // Step 3: regress Y on X to learn how covariates predict conversion
    β = OLS_fit(Y, X)

    // Step 4: compute predicted values and their mean
    Y_hat[user] = dot_product(β, X[user])
    mean_Y_hat  = mean(Y_hat across all users)

    // Step 5: subtract de-meaned prediction from actual outcome
    Y_cuped[user] = Y[user] - (Y_hat[user] - mean_Y_hat)

    return Y_cuped

// ATE computation uses Y_cuped in place of Y
ate = mean(Y_cuped for treatment users) - mean(Y_cuped for control users)
```

The subtraction uses `Y_hat - mean_Y_hat` rather than raw `Y_hat` to preserve the mean of Y — keeping the ATE estimate unbiased.

---

## 3. Variance reduction at ρ = 0.5

Variance reduction = ρ²

At a correlation of 0.5 between covariate and outcome:

**ρ² = 0.5² = 0.25 → 25% variance reduction**

The intuition: correlation measures the linear relationship between covariate and outcome, but variance reduction depends on how much of the *variance* in Y is explained by X — which is R² (or ρ² for a single covariate), not ρ. A correlation of 0.5 explains 25% of the variance, not 50%.

With multiple covariates, variance reduction = R² of the full regression, which will typically exceed any single covariate's ρ².

---

## 4. Impact on required sample size

Sample size scales linearly with variance. A 25% reduction in variance means 25% fewer users are needed to achieve the same statistical power.

From the power analysis exercise: 903 users per variant required at 80% power, α = 0.05, 5pp MDE.

**With CUPED at ρ = 0.5:**
- Adjusted sample size: 903 × (1 − 0.25) = 903 × 0.75 = **~677 users per variant**
- At 7.5 users per variant per day: 677 ÷ 7.5 = **~90 days**
- Compared to 120 days unadjusted — **CUPED saves approximately one month**

For Panel's target customer (15 daily signups, constrained timeline), this is a meaningful improvement. It's also why the pre-experiment simulation should reflect CUPED-adjusted estimates when sufficient user history exists — giving customers a more accurate and more optimistic time-to-result than a naive power calculation would show.

---

## Panel implementation notes

- CUPED runs server-side at results computation time — customers never configure it
- Covariates are pulled automatically from `events` and `users` tables using `assigned_at` as the cutoff
- Eligibility check runs before applying CUPED — users below the history threshold are excluded from adjustment
- Results surface whether CUPED was applied and the estimated variance reduction via the `cuped_applied` and `cuped_variance_reduction_pct` fields on the `results` table

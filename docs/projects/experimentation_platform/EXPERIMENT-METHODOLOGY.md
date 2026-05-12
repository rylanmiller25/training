# Panel — Experiment Methodology

**Status:** Draft  
**Last updated:** 2026-05-11

Every statistical decision in the platform traces back to this document. If a choice isn't documented here, it isn't a defensible default.

---

## Design principles

- **Opinionated defaults, visible controls.** Panel makes statistically defensible choices by default. Customers can override any setting before launch — but they never have to. Complexity lives in the engine.
- **Pre-specification is enforced, not encouraged.** Subgroups and metrics are locked at experiment creation. No post-hoc additions after the experiment starts.
- **Honest uncertainty.** Results are accompanied by explicit reliability signals. Uncertain results get hedged language. Reliable results get direct language. The platform never overstates confidence.
- **Graceful fallback.** When optimal methods can't apply (insufficient data, no pre-experiment history), Panel falls back to simpler methods automatically and transparently.

---

## 1. Randomization and assignment

**Method:** Hash-based deterministic assignment.

```
variant = hash(user_id + experiment_id + run_id) mod 100
```

The same user always receives the same variant within a run. Different experiments independently randomize the same users. No central coordination required at assignment time.

**Randomization unit:** User-level. Every experiment on Panel randomizes at the user level. Session-level or request-level randomization is not supported — these violate SUTVA and produce inflated false positive rates for the experiment types Panel is designed for.

**Traffic allocation:** Variant weights are declared at experiment creation and must sum to 1.0. Weights are locked once the experiment launches.

---

## 2. Sample size and power

**Defaults:**
- Statistical power: 80%
- Significance level (α): 0.05
- Both are customer-adjustable at experiment setup

**Pre-experiment simulation:** Before launching, Panel runs a power analysis given the customer's expected daily users, baseline conversion rate, and minimum detectable effect. Output is in plain English — estimated days to a reliable result, which subgroup comparisons are well-powered, and a recommendation (run as designed / wait / redesign).

When sufficient user history exists, the simulation accounts for expected CUPED variance reduction, producing a more accurate (and typically more optimistic) time-to-result estimate than a naive power calculation.

**Required sample size formula (two-proportion z-test):**

```
n = (z_α/2 + z_β)² × (p1(1-p1) + p2(1-p2)) / (p1 - p2)²
```

Where p1 = baseline rate, p2 = baseline + MDE, z_α/2 = 1.96, z_β = 0.842.

**HTE subgroup power:** Subgroup analysis requires each subgroup to be independently powered. Required sample size for a subgroup scales inversely with its share of total traffic. Panel surfaces explicit reliability flags per subgroup — a subgroup is marked unreliable if it cannot reach 80% power at the declared MDE given current traffic.

---

## 3. SRM detection

**What it is:** A Sample Ratio Mismatch occurs when the observed assignment split differs significantly from the intended split. SRM indicates a problem in the experiment pipeline — logging gaps, redirect issues, bot traffic — and makes results untrustworthy regardless of what they show.

**Method:** Chi-square test on observed vs expected assignment counts.

```
χ² = Σ (observed - expected)² / expected
```

Where expected = total assigned × variant weight.

**Threshold:** χ² > 3.84 (α = 0.05, 1 degree of freedom for a two-variant experiment).

**Response:** If SRM is detected, Panel flags the result as unreliable, surfaces a plain-English explanation, and blocks the interpretation layer from generating a recommendation. The customer must investigate and resolve the root cause before results can be trusted. SRM monitoring runs continuously during the experiment — customers are alerted immediately if the ratio drifts.

---

## 4. ATE computation

**Primary method:** Two-proportion z-test for binary conversion metrics.

- Conversion rate per variant = converters / assigned users
- ATE = treatment conversion rate − control conversion rate
- Standard error = `SQRT(p_t(1-p_t)/n_t + p_c(1-p_c)/n_c)`
- 95% CI = ATE ± 1.96 × SE

**Ratio metrics (delta method):** For metrics where both numerator and denominator are random (revenue per user, clicks per session), the delta method is applied to propagate variance correctly through the ratio. Standard variance formulas produce incorrect confidence intervals for ratio metrics.

**Highly skewed metrics:** Bootstrap confidence intervals are used when the metric distribution is highly skewed or lacks a clean analytic formula. Slower but makes no distributional assumptions.

**Results computation:** On demand. Computed when the customer requests them and written to the `results` table with a `computed_at` timestamp. The UI shows when results were last computed and allows the customer to trigger a refresh. Results are never auto-computed on a schedule.

---

## 5. CUPED variance reduction

**What it does:** Reduces metric variance by partialling out the component explained by pre-experiment user behavior, allowing the same statistical power to be achieved with fewer users or in less time.

**Theoretical basis:** Equivalent to including pre-experiment covariates directly in the OLS regression of outcome on treatment (Frisch-Waugh-Lovell). The CUPED-adjusted ATE is the same as the coefficient on the treatment indicator in a regression of Y on treatment + all covariates.

**Covariates used (collected automatically from Panel's data):**
- Login count before assignment
- Session count before assignment
- Key feature action count before assignment
- Pricing page view count before assignment
- Days since first seen
- Plan tier at assignment time
- Acquisition channel (auto-detected)

**Implementation:**
1. Collect pre-experiment covariates for each assigned user
2. Fit OLS regression of outcome Y on covariates X
3. Compute predicted values Ŷ and their mean
4. Adjust: `Y_cuped = Y - (Ŷ - mean(Ŷ))`
5. Compute ATE and SE on Y_cuped

**Eligibility:** Applied only to users with sufficient pre-experiment history. Users below the history threshold are excluded from adjustment. If too few users have history, Panel falls back to unadjusted analysis and notes this in the result.

**Variance reduction:** Equals R² of the covariate regression. At a single-covariate correlation of ρ = 0.5, variance reduction = ρ² = 25%, reducing required sample size by 25%.

**Result fields:** `cuped_applied` (boolean) and `cuped_variance_reduction_pct` (float) are stored on every result row so customers can see whether adjustment was applied and by how much.

---

## 6. Multiple comparisons

**Pre-specification is enforced:** Subgroups are declared at experiment creation and locked before any data is collected. No subgroups can be added after the experiment starts. This eliminates data-dredging as a source of false positives for the primary analysis.

**Bonferroni correction:** Applied across all pre-specified subgroups and across all metrics being tested simultaneously. Adjusted threshold = α / number of tests.

**Post-hoc exploration:** Customers can slice results by dimensions not pre-specified, but these results are clearly labeled as exploratory. Exploratory results include a disclaimer that they require a follow-up confirmatory experiment before being acted on. They do not trigger the AI interpretation layer's recommendation language.

This mirrors Statsig's approach: rigorous primary analysis on pre-specified tests, exploratory access to additional cuts with appropriate labeling.

---

## 7. HTE analysis

**Default method — interaction terms:**
For 1–3 pre-specified binary or categorical subgroups, Panel estimates heterogeneous treatment effects using a regression with treatment × subgroup interaction terms:

```
outcome ~ treatment + subgroup + treatment × subgroup
```

The interaction coefficient gives the differential treatment effect for that subgroup. This approach uses the full dataset and borrows statistical strength across groups, partially mitigating the power constraints of small subgroups. It is interpretable, computationally cheap, and statistically defensible for a small number of pre-specified groups.

**Future method — causal forests:**
For richer covariate sets (4+ subgroup dimensions), causal forests (EconML / CausalML) will be used to estimate individual-level treatment effect heterogeneity and produce uplift scores. This is a planned capability, not part of the initial build.

**Subgroup reliability flags:** Every subgroup result carries an explicit reliability flag. Subgroups that are underpowered at the declared MDE are marked unreliable. The AI interpretation layer uses calibrated language — direct language for reliable subgroups, hedged language for unreliable ones.

---

## 8. Guardrail metrics

Guardrail metrics are monitored continuously throughout the experiment. If any guardrail crosses its threshold, the experiment stops automatically regardless of the primary metric's status.

**Defaults (customer-adjustable at setup, locked once running):**

| Guardrail | Default threshold | What it guards against |
|---|---|---|
| Churn rate | Treatment exceeds control by > 2pp | Treatment that improves conversion but causes cancellations |
| Engagement rate | Treatment drops > 15% below control | Treatment that keeps users subscribed but disengages them |
| Revenue per user | Treatment drops > 10% below control | Treatment that improves a non-revenue metric while depressing revenue |

Thresholds are stored in the `config` jsonb column on the `experiments` table alongside other statistical config. Visible to customers before launch with plain-English explanations.

---

## 9. Stopping rules

**Fixed-horizon (default):** The experiment runs until the pre-specified sample size is reached. Results are analyzed once. Customers are warned not to peek at p-values before the sample size is reached — repeated peeking at α = 0.05 produces an effective false positive rate of ~18% with five peeks.

**Guardrail-triggered stop:** Automatic. If any guardrail metric crosses its threshold, the experiment stops immediately. Pre-specified before launch.

**Sequential testing (opt-in):** For customers who need to monitor results continuously, Panel supports always-valid inference methods (SPRT or e-values) that control false positive rates at any stopping point. Slightly lower power than fixed-horizon at the same sample size. Surfaced as an advanced setting at experiment setup.

---

## 10. Statistical decisions — default vs. configurable

| Decision | Default | Customer-configurable |
|---|---|---|
| Significance level (α) | 0.05 | Yes, at setup |
| Target power | 80% | Yes, at setup |
| Guardrail thresholds | See section 8 | Yes, at setup |
| Stopping rule | Fixed-horizon | Yes — sequential testing opt-in |
| CUPED | Applied automatically when eligible | No — always on when data supports it |
| SRM detection | Always on | No |
| Multiple comparisons correction | Bonferroni across pre-specified tests | No |
| Post-hoc exploration | Available, labeled exploratory | No |

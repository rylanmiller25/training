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

## 10. Untestable outcome detection

The natural language parsing layer evaluates the customer's stated outcome before creating an experiment. If the outcome is not testable with Panel's infrastructure, the platform returns a clear explanation rather than configuring an experiment that will produce meaningless results.

**Conditions that make an outcome untestable:**

| Condition | Example | Response |
|---|---|---|
| Not expressible as a trackable event | "Does our brand feel more premium?" | Flag as untestable — brand perception can't be measured from user behavior. Suggest a proxy event or a survey tool instead. |
| Outcome window too long to be practical | "Does this affect 3-year LTV?" | Flag as infeasible — surface estimated experiment duration and recommend a shorter-window proxy metric. |
| SUTVA violation | Marketplace matching, referral programs, social features | Flag that standard randomization breaks down. Recommend a switchback or geo experiment design instead. |
| Outcome event too rare to be powered | Event occurs < 1 in 1,000 users | Pre-experiment simulation returns `reliable: false` with an explanation that no realistic traffic level will reach significance. Recommend a higher-frequency proxy. |
| Treatment cannot be randomized | Company-wide price change, uniform policy | Flag that individual-level randomization is not possible. Recommend synthetic control or difference-in-differences instead. |

**Where this runs:** The `POST /experiments/parse` endpoint evaluates testability as part of intent parsing. If an outcome is untestable, the response sets `clarificationNeeded: true` with a specific explanation rather than returning a parsed experiment config. No experiment is created until the customer resolves the issue.

---

## 11. Experiment-type-aware guardrail selection

The three default guardrail metrics (churn rate, engagement rate, revenue per user) are calibrated for a mature product experiment where users are already paying customers with behavioral history. They do not universally apply.

Panel infers appropriate guardrails from the experiment type declared at setup and suppresses defaults that are not meaningful in context.

**Guardrail applicability by experiment type:**

| Experiment type | Churn rate | Engagement rate | Revenue per user | Alternative guardrails |
|---|---|---|---|---|
| Pricing sensitivity | ✓ | ✓ | ✓ | — |
| Top-of-funnel / signup flow | ✗ Not yet customers | ✗ Day-1 users only | ✗ No payment yet | Signup completion rate, time to first action |
| Onboarding flow | ✗ | Conditional | ✗ | Feature adoption rate, time to value |
| Cancellation flow | ✗ Churn is primary metric | ✓ | ✓ | Reactivation rate |
| Positioning / messaging | ✗ | ✓ | Conditional | Click-through rate, demo request rate |
| Retention intervention | ✓ | ✓ | ✓ | — |

**Rules:**
- If churn rate is the primary metric, it is removed from guardrails automatically.
- If the experiment targets pre-conversion users (no payment history), revenue per user and churn rate are suppressed.
- If the experiment window is shorter than 30 days and the outcome is top-of-funnel, engagement rate is replaced with a session-based proxy.
- Customers can add custom guardrail metrics at setup — any event Panel tracks can serve as a guardrail with a customer-specified threshold.

**Where this runs:** Guardrail selection happens at experiment creation (`POST /experiments`). The platform proposes a guardrail set based on experiment type and surfaces it on the confirmation screen with plain-English explanations. Customers approve or adjust before launch.

---

## 12. Minimum experiment duration

**Hard minimum:** 7 days, regardless of when statistical significance is reached.

**Dynamic minimum:** `max(7 days, simulation-estimated days to minimum sample size)`

The 7-day floor exists because novelty and primacy effects typically take 5–7 days to wash out. A customer with high traffic might reach significance in 2 days — but that result reflects novelty, not a stable treatment effect. The simulation-based component catches the opposite case: low-traffic customers who need far longer than 7 days to accumulate enough users.

**Enforcement:** Panel surfaces the minimum run time on the pre-launch confirmation screen and does not allow the experiment to be stopped early for significance before the minimum is reached. Guardrail-triggered stops are exempt — a guardrail crossing is grounds for immediate stop regardless of duration.

---

## 13. Overlapping experiments

Panel follows a simplified version of Microsoft's layer-based experiment infrastructure.

**The principle:** Experiments in independent layers can run simultaneously without contamination, as long as they don't interact. Experiments that touch the same product surface or share an outcome metric may interact and should not overlap.

**Panel's MVP implementation:**
- Each experiment runs in its own namespace, independently randomizing users via hash
- When a customer launches a new experiment, Panel checks whether any currently running experiments share overlapping user populations AND overlapping outcome metrics
- If overlap is detected, Panel flags it on the launch screen: "This experiment may interact with [Experiment X] — consider sequencing them or making them mutually exclusive"
- The customer can proceed or pause the conflicting experiment

**Full layer infrastructure** (post-MVP): Explicit experiment layers where experiments in the same layer are mutually exclusive. A user can be in at most one experiment per layer, and in one experiment per each independent layer simultaneously. This is how Microsoft and Google handle high-volume overlapping experimentation.

---

## 14. CUPED covariate imputation

There is no hard exclusion threshold for pre-experiment history. Instead, Panel uses mean imputation for missing covariates.

**Why no threshold is needed:** If a user has no pre-experiment history, their covariates are set to the covariate mean. This means their predicted value `Ŷ = mean(Ŷ)`, and their CUPED adjustment is exactly zero — `Y_cuped = Y - (mean(Ŷ) - mean(Ŷ)) = Y`. Users with no history automatically receive no adjustment without any special handling logic. Even partial history contributes some variance reduction.

**Reporting:** Panel reports `cuped_applied: true` when more than 50% of assigned users had real (non-imputed) covariate data. Below that threshold, `cuped_applied: false` and the result is treated as unadjusted for reporting purposes, even though partial adjustment occurred.

---

## 15. SRM resolution and billing

**When SRM is detected:** Data collected during the SRM period is discarded. A new run is created. The customer is notified with a plain-English explanation of what SRM means and what likely caused it.

**Root cause diagnosis:** Panel distinguishes two SRM types:
- **Assignment-side SRM:** Panel's own assignment logs show the wrong split. Indicates a Panel infrastructure issue or hashing bug. Panel is responsible.
- **Event-side SRM:** Panel's assignment logs show the correct split, but the customer's event pipeline shows imbalance. Indicates a customer SDK issue — a logging bug, redirect problem, or client-side filtering on one variant only.

Panel surfaces the diagnosis to the customer with specific guidance on where to investigate.

**Subscription credit policy:**
Panel uses a subscription pricing model (free, pro, enterprise tiers) — there is no per-experiment or per-run billing. SRM policy is therefore about service quality and trust, not charge disputes:
- SRM detected and root cause is Panel-side (assignment logs show wrong split) → Panel provides priority support, root cause report, and a subscription credit proportional to the affected period
- SRM detected and root cause is customer-side (assignment logs correct, event pipeline imbalanced) → Panel provides diagnosis and guidance; no credit issued
- SRM detected within 48 hours of launch → treated as a setup error regardless of fault; Panel provides a free diagnostic session to help resolve it

---

## 16. Statistical decisions — default vs. configurable

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

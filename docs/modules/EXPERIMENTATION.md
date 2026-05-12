# Module: Experimentation + A/B Testing

**Phase:** 1  
**Slug:** `experimentation`  
**Status:** Started 

---

## What it is / how to think about it

Experimentation is how you make causal claims about the real world from data. Without it, you have correlations and stories. With it, you have evidence. This module covers the full lifecycle of a controlled experiment: choosing the right metrics, designing a trustworthy randomization scheme, evaluating results correctly, and knowing when to trust what you see.

**Mental model:** An experiment is a controlled causal claim. You're saying: "If I change X, Y changes — and I know this because I held everything else constant." Every design decision you make either strengthens or weakens that claim. Most mistakes in industry experimentation come from cutting corners on the design, not the analysis.

This module is foundational to everything in the experimentation platform. Every feature — HTE analysis, pre-experiment trust assessment, the AI interpretation layer — rests on getting this right.

---

## Prerequisites
- `sql` — experiment analysis queries require SQL fluency

---

## Best resources

**Primary:**
1. *Trustworthy Online Controlled Experiments* (Kohavi, Tang, Xu) — the canonical industry reference; read Chapters 1–4 before exercises, return for Chapters 5–9 during advanced topics
2. [Evan Miller — How Not to Run an A/B Test](https://www.evanmiller.org/how-not-to-run-an-ab-test.html) — the clearest explanation of peeking and stopping rules
3. [Microsoft Experimentation Platform blog](https://www.microsoft.com/en-us/research/group/experimentation-platform-exp/) — Ronny Kohavi's team; production-scale lessons

**Supporting:**
- [Netflix Tech Blog — Interleaving in Online Experiments](https://netflixtechblog.com/interleaving-in-online-experiments-at-netflix-a04ee392ec55) — one of the best walkthroughs of a sophisticated design
- [Statsig Blog — SRM Detection](https://www.statsig.com/blog/sample-ratio-mismatch) — practical SRM explanation
- [Spotify Confidence — Variance Reduction (CUPED)](https://confidence.spotify.com/docs/experiments/stats/variance-reduction) — good applied CUPED walkthrough

---

## Core concepts

### Metrics

**Primary metric:** The one number your experiment is designed to move. Should be: measurable, sensitive to changes within your experiment window, and directly tied to business value. If your primary metric doesn't move, the experiment fails, regardless of what else happened.

**Guardrail metrics:** Metrics you must not break, even if your primary metric improves. Common guardrails: latency, crash rate, unsubscribe rate, revenue per existing customer. A pricing experiment that improves conversion but increases churn is failing its guardrails.

**Metric hierarchy:** Most platforms have three layers — North Star (the long-term outcome), primary experiment metric (the sensitive proxy), and guardrails (the floors). Good metric hierarchy design ensures that moving the experiment metric actually moves the North Star in the long run. Proxy metrics that dissociate from the North Star are dangerous.

**Sensitivity and directionality:** A metric is sensitive if small meaningful changes produce detectable signals. Directionality means you know which direction is "better." Session duration is a bad metric for many products (longer = more engaged, or longer = frustrated?). User-initiated actions are usually better — they have clear directionality.

**Counter-metrics:** Metrics that measure potential harm. Every primary metric should have a counter-metric. "Increase clicks" counter: "don't increase clickbait at the expense of quality." "Reduce friction" counter: "don't remove friction that protects important decisions."

---

### Designing a trustworthy experiment

**Randomization unit:** The unit of assignment to variants. Three common choices:
- **User-level:** Each user always sees the same variant. Appropriate for most product experiments. Required whenever the experiment affects user state or behavior over time.
- **Session-level:** Each session may see a different variant. Only appropriate when sessions are independent. Often causes contamination.
- **Page/request-level:** Every request flips independently. Almost always wrong for product experiments — creates incoherent experiences and violates the stable unit treatment value assumption (SUTVA).

The randomization unit must be at or above the unit of analysis. If you randomize by user but analyze by session, you have inflated false positive rates.

**Sample size and power:**
- **Statistical power (1 - β):** The probability of detecting a real effect. Industry standard: 80% power.
- **Significance level (α):** The false positive rate you'll accept. Industry standard: 5% (α = 0.05).
- Required sample size scales with: (1) the variance of your metric, (2) the minimum detectable effect (MDE) you care about, (3) your power and significance targets.
- Formula intuition: small effects require large samples; high-variance metrics require large samples.
- **Pre-experiment power analysis is not optional.** Running without it is how you get underpowered experiments that tell you nothing.

**Pre-experiment checks:**
- **A/A test:** Run an experiment where both variants receive identical treatment. The null hypothesis is true; any "significant" result is a false positive. If your A/A test produces too many false positives, your randomization or analysis pipeline is broken.
- **Historical metric variance:** Measure the baseline variance of your primary metric before committing to a sample size. Often higher than expected.
- **Pre-period imbalance check:** Verify treatment and control groups look similar on pre-experiment metrics. Significant pre-period differences signal randomization failure.

---

### Traffic splitting

**Hash-based assignment:** Deterministic assignment using a hash of the user identifier + experiment ID. `hash(user_id + experiment_id) mod 100 < traffic_percentage` assigns to treatment. This ensures: (1) the same user always gets the same variant, (2) different experiments independently randomize the same users, (3) no central coordination needed.

**Bucketing strategies:** Divide the hash space into buckets. Buckets can be reserved, released gradually, or reassigned. Enables ramp-up without re-randomizing users who've already been assigned.

**Overlapping experiments:** Most production systems run dozens of simultaneous experiments. Correct handling: ensure independence (different layers for experiments that might interact; same layer only for mutually exclusive experiments). The Microsoft/Google approach: separate namespaces/layers for orthogonal experiments, with exclusion groups for experiments that must not overlap.

**Sample Ratio Mismatch (SRM):** When the observed treatment/control split differs significantly from the intended split. A chi-square test on the assignment counts detects it. SRM is a red flag — it means something in the experiment pipeline is wrong (bots, redirect issues, logging gaps). If there's an SRM, the results are untrustworthy regardless of what they show. Fix the root cause before analyzing.

---

### Experiment launch

**Pre-launch checklist:**
- Assignment logging verified (every assigned user logged with timestamp)
- Event tracking verified (metric events firing correctly before launch)
- Holdback or control group confirmed
- SRM monitoring enabled
- Guardrail alerts configured

**Ramp-up strategies:** Don't expose 100% of traffic immediately. Start at 5–10%, verify SRM and guardrail behavior, then ramp. Staged ramp limits blast radius if the treatment has unexpected effects. Ramp-up also helps catch implementation bugs before they affect the full user base.

**Monitoring and alerts:**
- **Guardrail alerts:** Alert immediately if guardrail metrics move outside safe bounds.
- **SRM monitoring:** Alert if the assignment ratio drifts from the target.
- **Novelty effect monitoring:** Many metrics spike at launch due to user curiosity, not real value. Watch for decay over the first week.

**Stopping rules:** Pre-specify when you will stop. Three valid stopping rules:
1. **Fixed-horizon:** Run until you hit your pre-specified sample size. Analyze once. Never peek before then and call it done.
2. **Sequential testing (always-valid inference):** Uses methods that allow peeking; controls false positive rate continuously. Discussed in Advanced Designs.
3. **Guardrail-triggered stop:** Stop immediately if a guardrail metric hits its alert threshold. Pre-specify this before launch.

The single most common mistake in industry experimentation: peeking at p-values repeatedly and stopping when significant. This inflates false positive rates dramatically (with 5 peeks at α=0.05, real false positive rate is ~18%).

---

### Experiment evaluation

**T-test and Z-test:** The workhorse for comparing means. T-test for small samples; Z-test for large (n > 30, in practice). Both assume independence of observations and approximately normal distribution of the test statistic (central limit theorem saves you for large n).

**Bootstrap:** Non-parametric alternative. Resample with replacement from your data, compute the statistic each time, use the distribution of resampled statistics as your confidence interval. Slower than analytic methods but makes no distributional assumptions. Use when your metric is a ratio (clicks/sessions), highly skewed, or doesn't have a clean analytic formula.

**Confidence intervals:** The 95% CI gives you a range that would contain the true effect in 95% of repeated experiments — not the probability the true effect is in this specific interval (a common misstatement). In practice, report the CI alongside the p-value; it conveys effect size and uncertainty, not just significance.

**Delta method:** For ratio metrics (conversion rate = conversions / sessions), you can't just compute variance of the ratio directly — it requires the delta method to propagate variance through the ratio. Most industry tools handle this automatically; you should understand when it applies.

**Multiple comparisons:** Testing many hypotheses simultaneously inflates false positive rates. If you test 20 independent hypotheses at α=0.05, you expect 1 false positive by chance. Corrections:
- **Bonferroni:** Divide α by number of tests. Conservative; preferred when tests are independent.
- **Benjamini-Hochberg (FDR):** Controls false discovery rate rather than family-wise error rate. Less conservative; appropriate for exploratory subgroup analysis.
- **Pre-specification:** The cleanest solution — declare which tests you'll run before the experiment. Pre-specified tests don't require correction.

For the experimentation platform: pre-specification of subgroups is a core design feature precisely because it avoids multiple comparisons corrections on post-hoc slicing.

---

### Improving experiment sensitivity

Higher sensitivity means you can detect smaller effects with fewer users, or detect the same effects faster.

**CUPED (Controlled-experiment Using Pre-Experiment Data):** Uses pre-experiment observations of your metric to reduce variance. If your metric for a user is correlated with their pre-experiment behavior (it almost always is), you can subtract the pre-experiment component. The variance reduction is proportional to the correlation squared — typical reductions of 20–50%.

Mechanically: `Y_cuped = Y - θ * (X - E[X])` where X is the pre-experiment covariate and θ is estimated via regression. The result has the same expectation as Y but lower variance.

This is the highest-leverage single improvement for most experiment platforms. Netflix, Spotify, Booking.com all use it. You should understand it well enough to explain it and implement it.

**Stratified sampling:** Divide the population into strata (e.g., by plan tier, acquisition channel, country) and ensure balanced representation across strata. Reduces variance from between-stratum differences. Most useful when strata have very different metric distributions.

**Variance reduction techniques — when to apply each:**
| Technique | When to use | Tradeoff |
|---|---|---|
| CUPED | Pre-experiment data available; metric is correlated with history | Requires pre-period data; slightly more complex |
| Stratification | Known high-variance groupings exist | Requires knowing the groupings upfront |
| Longer experiment | Metric is highly variable day-to-day | Slower time to results |
| Smaller MDE | You don't actually need to detect tiny effects | Narrows what you can learn |

---

### Advanced experiment designs

**Sequential testing (always-valid inference):** Statistical methods that allow you to peek at results continuously without inflating false positive rates. Uses sequential probability ratio tests (SPRT) or e-values rather than fixed-horizon p-values. Key property: the false positive rate is controlled at any stopping point. Trade-off: slightly lower power than fixed-horizon tests at the same sample size. Statsig, Optimizely, and most modern platforms support this.

**Switchback experiments (time-based):** Used when user-level randomization isn't possible — typically two-sided marketplaces (Uber, DoorDash) where treatment of one user affects others (SUTVA violation). Instead of randomizing users, randomize time slots: the entire population sees treatment for some time periods and control for others. Analysis requires time-series methods, not standard t-tests. Complex but necessary for marketplace products.

**Geo experiments:** Randomize at the geographic unit (DMA, city, country) rather than the user level. Used when: (1) the treatment is a marketing spend or price change that can't be assigned per-user, (2) there are strong network effects within geos. Requires synthetic control methods or difference-in-differences for analysis. Minimum detectable effects are large due to small unit counts.

**Long-run effects and novelty / primacy effects:**
- **Novelty effect:** Users explore new features initially, inflating short-run metrics. The "true" effect is lower.
- **Primacy effect:** Users familiar with the old design prefer it initially; the new design looks worse but users will adapt.
- Both mean: don't trust short experiments for features that change user habits. Two mitigations: run longer experiments, or use a "learning period" holdout that you analyze separately after the novelty wears off.

---

## Exercises

**Set 1 — Metric design (30 min):**
Design the metric hierarchy for the experimentation platform itself:
- What is the North Star metric?
- What is the primary metric for a typical experiment a user would run?
- What are 3 guardrail metrics?
- For each guardrail, write the specific threshold that would trigger a stop.

Save to `docs/reading/EXPERIMENT-METRIC-DESIGN.md`.

**Set 2 — Power analysis (30 min):**
Pick a pricing experiment for the platform (e.g., $49 vs $99 plan):
- Define the primary metric and estimate its baseline value and variance
- Specify your MDE: what's the smallest effect worth detecting?
- Calculate the required sample size at 80% power, α=0.05
- Estimate how many days the experiment will run given your expected signup rate
- Which subgroup comparisons are well-powered? Which aren't?

Use any calculator (Evan Miller's is fine). Save your working to `docs/reading/POWER-ANALYSIS-EXERCISE.md`.

**Set 3 — SRM detection + evaluation SQL (45 min):**
Write SQL for the following, using a schema of your own design (or the platform's data model):
- Assignment counts by variant (to check for SRM)
- The chi-square SRM test
- Average treatment effect with standard error
- 95% confidence interval on the ATE
- Subgroup ATE for two pre-specified segments

Save to `docs/reading/EXPERIMENT-ANALYSIS-SQL.md`.

**Set 4 — CUPED implementation (30 min):**
Describe how you would implement CUPED for the experimentation platform:
- What pre-experiment covariate would you use for a conversion rate experiment?
- Write the pseudocode for computing the CUPED-adjusted metric
- Estimate the variance reduction you'd expect given a correlation of 0.5
- What does this mean for required sample size?

Save to `docs/reading/CUPED-EXERCISE.md`.

**Set 5 — Advanced design selection (20 min):**
For each of the following scenarios, choose the right experiment design and explain why standard A/B doesn't work:
1. A two-sided marketplace (sellers and buyers) testing a new matching algorithm
2. A TV ad campaign testing whether a new creative drives app installs
3. A pricing change that affects all users simultaneously

Save to `docs/reading/ADVANCED-DESIGN-SELECTION.md`.

---

## Checks — you understand this when you can:
- [X] Explain the difference between a primary metric, guardrail metric, and counter-metric — and give examples for the experimentation platform
- [X] Explain what randomization unit means and what goes wrong if you pick the wrong one
- [X] Calculate (roughly) the required sample size for a given MDE, variance, and power target
- [X] Explain what SRM is, how to detect it, and what it means for results validity
- [X] Explain peeking / optional stopping and why it inflates false positive rates
- [X] Explain the delta method and when it's needed
- [X] Explain the multiple comparisons problem and two ways to address it
- [X] Explain CUPED in plain English and estimate its benefit given a correlation value
- [X] Explain when you'd use sequential testing, a switchback experiment, or a geo experiment

---

## Artifacts to commit
- [X] `docs/reading/EXPERIMENT-METRIC-DESIGN.md`
- [X] `docs/reading/POWER-ANALYSIS-EXERCISE.md`
- [X] `docs/reading/EXPERIMENT-ANALYSIS-SQL.md`
- [X] `docs/reading/CUPED-EXERCISE.md`
- [X] `docs/reading/ADVANCED-DESIGN-SELECTION.md`
- [X] Glossary entries: ATE, MDE, statistical power, Type I error, Type II error, guardrail metric, randomization unit, SUTVA, SRM, CUPED, sequential testing, switchback experiment, delta method, multiple comparisons, Bonferroni correction
- [X] Log entry in `docs/LOG.md`

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/EXPERIMENT-METHODOLOGY.md`. This is the statistical specification for the platform — it defines how the platform computes ATEs, handles multiple comparisons, applies CUPED, and detects SRM. Every statistical decision you make when building the platform should trace back to this document.

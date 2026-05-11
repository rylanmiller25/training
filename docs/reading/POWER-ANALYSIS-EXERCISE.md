# Power Analysis Exercise — Panel Pricing Experiment

**Exercise:** Set 2 from `docs/modules/EXPERIMENTATION.md`  
**Status:** Complete

---

## Experiment setup

A pricing experiment testing $49 vs $99 plan for Panel's customers. This is the canonical Panel experiment type — two variants, one primary metric, pre-specified subgroups.

**Variants:**
- Control: $49 plan
- Treatment: $99 plan

---

## Primary metric

**Conversion rate** — share of free users who upgrade to paid within the experiment's outcome window.

All fields in `attributes` are optional. Panel auto-detects device type, country, acquisition channel, and browser from request headers — no customer input required for those dimensions.

---

## Inputs

| Input | Value | Notes |
|---|---|---|
| Baseline conversion rate | 20% | Estimated share of free users who currently upgrade |
| Minimum detectable effect (MDE) | 5 percentage points | Smallest difference worth acting on — treatment converting at 15% vs control at 20% |
| Expected daily signups | 15 | Realistic for an early-stage startup |
| Traffic split | 50/50 | Equal allocation to control and treatment |
| Statistical power | 80% | Industry standard — 80% chance of detecting a real effect |
| Significance level (α) | 0.05 | 5% false positive rate |

---

## Sample size calculation

Using a two-proportion z-test:

- p1 (control) = 0.20, p2 (treatment) = 0.15
- z_α/2 = 1.96 (two-tailed, α = 0.05)
- z_β = 0.842 (80% power)

**Required per variant: ~903 users**  
**Total required: ~1,806 users**

At 15 signups/day split 50/50 → 7.5 users per variant per day:

**903 ÷ 7.5 = ~120 days (4 months)**

---

## What this means

4 months is a long time for an early-stage startup. This is exactly the kind of finding Panel's pre-experiment simulation should surface before a customer launches — not after they've wasted months collecting underpowered data.

The three levers available:

| Lever | Change | Revised sample size per variant | Revised timeline |
|---|---|---|---|
| Increase MDE to 10pp | Only care about detecting a larger effect | ~196 | ~26 days |
| Increase traffic to 50 signups/day | More users enter the experiment | ~903 | ~36 days |
| Apply CUPED (~30% variance reduction) | Pre-experiment history reduces noise | ~632 | ~84 days |

**The MDE is the most powerful lever.** The question a founder should ask before launching: "Do I actually need to detect a 5pp difference, or would a 10pp difference be enough to make the pricing call?" That single question cuts the experiment from 4 months to 26 days.

---

## Subgroup analysis (HTE)

Testing whether the pricing effect differs by founder type requires each subgroup to be independently powered. With technical founders making up 60% of users and non-technical founders 40%:

| Subgroup | Share of traffic | Users per variant available | Required per variant | Powered? |
|---|---|---|---|---|
| Technical founders | 60% | ~542 | ~903 | No |
| Non-technical founders | 40% | ~361 | ~903 | No |

To get 903 users per variant *within* each subgroup, the total required per variant grows significantly:

- Binding constraint: non-technical founders at 40% of traffic
- Required total per variant: 903 ÷ 0.40 = **~2,258**
- At 7.5 users/variant/day: **~301 days — over a year**

Neither subgroup is well-powered at 15 daily signups. Panel's pre-experiment simulation should say: "Your overall result will be reliable in ~4 months. Subgroup comparisons will not be reliable at your current traffic level."

**Partial mitigation — interaction terms:**
Rather than analyzing each subgroup in isolation, Panel can run a regression with a treatment × subgroup interaction term. This uses the full dataset and borrows statistical strength across subgroups, partially offsetting the power problem. This is Panel's default HTE approach when the number of pre-specified subgroups is small (1–3). Causal forests are reserved for richer covariate sets where interaction terms become unwieldy.

---

## Panel simulation output — what this should look like

When a customer with 15 daily signups runs this simulation, Panel should return:

> "Your overall result will be reliable in about 4 months. If you only need to detect a 10-point difference in conversion, you'll have a result in about 26 days. Subgroup analysis by founder type is not well-powered at your current traffic level — consider running the overall test first and revisiting subgroup analysis once you have more users."

Plain English, honest about uncertainty, actionable. No power curves. No formulas.

# Advanced Design Selection Exercise — Panel

**Exercise:** Set 5 from `docs/modules/EXPERIMENTATION.md`  
**Status:** Complete

---

## Scenario 1: Two-sided marketplace testing a new matching algorithm

**Why standard A/B doesn't work:**
SUTVA (Stable Unit Treatment Value Assumption) is violated. In a two-sided marketplace, users are not independent — treating one side affects the other. If you assign some sellers to the new matching algorithm and others to the old, buyers interact with both groups. A buyer might see results from the new algorithm in one session and the old in another. The control group is contaminated by the treatment, making the comparison meaningless.

**Right design: Switchback experiment**
Randomize by time slot rather than by user. The entire marketplace runs the new matching algorithm during some time periods (e.g. alternating hours or days) and the old algorithm during others. Because all users see the same condition at any given moment, there's no cross-contamination.

**Analysis:** Standard t-tests don't apply — the observations are time series, not independent user-level outcomes. Time-series methods that account for autocorrelation and carryover effects between periods are required.

**Tradeoff:** Switchbacks require careful period design. If periods are too short, carryover effects from the previous period bleed into the next. If periods are too long, the experiment takes longer to reach sufficient power.

---

## Scenario 2: TV ad campaign testing whether a new creative drives app installs

**Why standard A/B doesn't work:**
You cannot control which individual users see a TV ad. Television is a broadcast medium — you buy airtime in a market and everyone in that market is exposed. There's no mechanism to assign one person to see the new creative and another to see the old one at the individual level.

**Right design: Geo experiment**
Randomize at the geographic unit (DMA, city, or country). Some markets receive the new creative, others serve as control markets. App install rates are compared across treated and untreated geos.

**Analysis:** Synthetic control or difference-in-differences. With a small number of geographic units (you might only have 20–30 DMAs), standard statistical tests are underpowered. Synthetic control constructs a weighted combination of control markets that best approximates the treated market's pre-experiment trend, then measures the divergence after treatment.

**Tradeoff:** Minimum detectable effects are large because the unit count is small (geos, not users). Geo experiments require long run times and are best suited for large, sustained effects.

---

## Scenario 3: A pricing change that affects all users simultaneously

**Why standard A/B doesn't work:**
A company-wide price change cannot be randomized at the user level — you can't charge one customer $49 and another $99 for the same product at the same time without creating fairness problems and legal risk. The treatment is applied to the entire user base at once, so there's no concurrent control group.

**Right design: Synthetic control or difference-in-differences**
- **Difference-in-differences:** Compare outcome trends before and after the price change. If you have a comparison group (e.g. a different product line or geography that didn't change price), you can estimate what would have happened without the change and attribute the divergence to the treatment.
- **Synthetic control:** Construct a weighted combination of untreated units (markets, cohorts, or comparable companies) that tracks the treated unit's pre-change trend as closely as possible, then measure the post-change gap.

**Tradeoff:** Both methods depend heavily on the parallel trends assumption — that the treated and control units would have followed the same trajectory without the intervention. Violations of this assumption produce biased estimates. Neither method offers the clean causal identification of a randomized experiment.

---

## Summary

| Scenario | Design | Key reason standard A/B fails |
|---|---|---|
| Two-sided marketplace — matching algorithm | Switchback (time-based randomization) | SUTVA violation — users are not independent |
| TV ad campaign — new creative | Geo experiment | Can't randomize at individual level; treatment is broadcast |
| Company-wide price change | Synthetic control / diff-in-diff | No concurrent control group; simultaneous treatment |

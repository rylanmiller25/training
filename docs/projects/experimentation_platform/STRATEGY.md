# Experimentation Platform — Strategy

## What it is

A startup-focused experimentation platform that goes beyond average treatment effects. Most A/B testing tools tell you "variant B converted 3% better overall." This platform tells you *which types of users* are more likely to have good outcomes under a given treatment — and lets you predict that probability before you've even finished running the experiment.

The core insight: the interesting signal in most experiments is not the average effect, it's the heterogeneity. A pricing change might hurt power users but convert casual ones. A new onboarding flow might work for technical founders and backfire for non-technical ones. Standard A/B tools hide this. This platform surfaces it.

---

## Target market

Early-stage and growth-stage startups running experiments at the intersection of product and market:
- Pricing experiments (does $49 vs $99 affect conversion and churn differently by user type?)
- Go-to-market experiments (does this positioning message work for SMB vs enterprise?)
- Onboarding experiments (which user profiles respond to which flows?)
- Retention experiments (which intervention prevents churn for which cohort?)

The platform is not primarily for UX A/B testing (button color, copy tweaks) — that space is crowded. It's for experiments where the *market signal* matters as much as the product signal.

---

## What existing tools do (and don't do)

| Tool | ATE reporting | Segment breakdowns | CATE / causal forests | Uplift modeling | Market experiments |
|---|---|---|---|---|---|
| Optimizely | ✓ | Post-hoc, descriptive | ✗ | ✗ | ✗ |
| Statsig | ✓ | Some | ✗ | ✗ | ✗ |
| LaunchDarkly | ✓ | Limited | ✗ | ✗ | ✗ |
| GrowthBook | ✓ | Post-hoc | ✗ | ✗ | ✗ |
| **This platform** | ✓ | Predictive | ✓ | ✓ | ✓ |

Closest academic analogues: Microsoft EconML, Uber CausalML. Neither is productized for startups.

---

## Core features

### 1. Standard experiment infrastructure
- Variant assignment (random, stratified)
- Event tracking SDK (TypeScript-first)
- Real-time result dashboard
- Statistical significance, confidence intervals, p-values

### 2. Heterogeneous Treatment Effect (HTE) analysis
- Causal forests (via `grf` / EconML) to estimate CATE — the treatment effect conditional on user attributes
- Automatic feature importance: which user attributes drive the biggest difference in outcomes?
- Segment ranking: "Users with attribute X are 3× more likely to have the good outcome under treatment B"

### 3. Uplift modeling
- For each user type in your database, predict the *probability of the good outcome* under each treatment
- Score your existing user base: "Here are the 200 users most likely to convert if you offer them the $49 plan"
- Good outcome and bad outcome are configurable per experiment (conversion, retention, LTV, etc.)

### 4. Simulate before you run
Before launching an experiment, input:
- Expected sample size and arrival rate
- User attribute distribution
- Target effect size
- Outcome of interest

The platform runs a power analysis calibrated for causal forest methods (not just t-tests), tells you:
- Whether your sample is large enough to detect heterogeneous effects (not just average effects)
- Estimated time to sufficient power
- Which user segments are likely to have detectable signal vs. which will be underpowered
- Recommendation: proceed / wait / redesign

This prevents startups from running experiments they can't learn from. It also builds trust — if the platform told you "you need 2,000 more users before this will be reliable" and you listened, and the results were clean, you trust the platform.

### 5. Market experiment templates
Pre-built experiment types for common market-level decisions:
- Price sensitivity test (willingness to pay by segment)
- Positioning message test (which narrative lands with which ICP)
- Channel attribution experiment (does the acquisition channel predict outcome quality?)
- Feature pricing test (add-on vs. bundled, tiered vs. flat)

---

## Simulation partnership idea

The simulate-before-you-run feature is valuable even without real user data — especially for pre-launch startups or teams designing experiments for a new user cohort they haven't seen before. Two partnership angles:

**Expected Parrot** (survey/LLM-simulated respondents): Partner to let teams simulate experiment outcomes against synthetic user populations before they have real traffic. A startup could describe their target user (e.g., "B2B SaaS founder, 5–50 person company, paying $50–$200/month for tools"), generate a simulated cohort, run a price sensitivity simulation, and see predicted uplift curves — all before writing a line of experiment code.

**Other potential partners:**
- Survey platforms (Wynter, Positly) for recruiting real respondents for pre-launch validation experiments
- CDP platforms (Segment, RudderStack) for pulling user attribute distributions into power analysis

The simulation layer is a top-of-funnel hook: startups use it before they have an experiment running, get value, then adopt the platform for live experiments.

---

## Key risks and mitigations

| Risk | Mitigation |
|---|---|
| Small startups lack sample size for causal forests | Bayesian fallback for small N; simulation layer sets expectations upfront |
| ML output hard to interpret | Heavy UX investment in plain-language summaries ("users like Sarah are 2× more likely to convert") |
| Incumbents add HTE as a feature | Be market-experiment-native from day one; UX depth they won't prioritize |
| Data privacy / user tracking friction | Offer first-party SDK + server-side tracking; no third-party cookies required |

---

## Build phases (aligned to training curriculum)

This platform will be built incrementally as the curriculum progresses. Rough correspondence:

- **Phase 1–2:** CLI tooling, GitHub repo, Docker setup, CI/CD for the platform
- **Phase 2–3:** System design (event ingestion, experiment assignment service), PRD for MVP
- **Phase 4:** ML foundations — understand transformers, embeddings, and evaluation before building the causal forest layer
- **Phase 5:** Prompt engineering + RAG for the "explain this result in plain English" feature; red-team the ML outputs; telemetry for experiment quality monitoring
- **Phase 6:** Landscape analysis (where does this fit in the market?), model economics, capstone — ship a working MVP

Artifacts from each module's exercises will feed directly into the platform where possible.

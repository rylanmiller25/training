# Experimentation Platform — Strategy

## What it is

A startup-focused experimentation platform that goes beyond average treatment effects. Most A/B testing tools tell you "variant B converted 3% better overall." This platform tells you *which types of users* are more likely to have good outcomes under a given treatment — and surfaces that answer in language any founder can act on, not a table of p-values.

The core insight: the interesting signal in most experiments is not the average effect, it's the heterogeneity. A pricing change might hurt power users but convert casual ones. A new onboarding flow might work for technical founders and backfire for non-technical ones. Standard A/B tools hide this. This platform surfaces it — and then explains it.

The second insight: statistics that can't be trusted shouldn't be shown. Before an experiment runs, the platform tells users exactly what they will and won't be able to learn given their expected traffic. After it runs, every result is accompanied by an honest signal on whether it's reliable enough to act on.

The third insight: statistical sophistication and ease of use are not in tension — they're a design problem. The complexity lives in the engine. The user just describes what they want to learn.

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

| Tool | ATE reporting | Segment breakdowns | Subgroup HTE | Uplift scoring | Market experiments | AI interpretation | Natural language setup |
|---|---|---|---|---|---|---|---|
| Optimizely | ✓ | Post-hoc, descriptive | ✗ | ✗ | ✗ | ✗ | ✗ |
| Statsig | ✓ | Some | ✗ | ✗ | ✗ | ✗ | ✗ |
| LaunchDarkly | ✓ | Limited | ✗ | ✗ | ✗ | ✗ | ✗ |
| GrowthBook | ✓ | Post-hoc | ✗ | ✗ | ✗ | ✗ | ✗ |
| **This platform** | ✓ | Predictive | ✓ | ✓ | ✓ | ✓ | ✓ |

Closest academic analogues: Microsoft EconML, Uber CausalML. Neither is productized for startups. Neither explains its outputs in plain language. Neither lets a non-statistician set up a rigorous experiment by describing what they want to learn.

---

## How it works — the interaction model

The entire platform is entered through three questions:

> **What are you testing?**
> **What is the measurable outcome?**
> **What do you want to know?**

That's it. A user types: "We're testing a $49 vs $99 pricing page. The outcome is whether someone upgrades from free to paid within 30 days. I want to know if the price change works differently for technical founders vs. non-technical founders."

From that, the platform:
1. Parses the treatment (two price conditions), the control group, the outcome metric (upgrade within 30 days), and the pre-specified subgroup (founder type)
2. Runs the pre-experiment trust assessment — "With your current signup rate, you'll have reliable overall results in 3 weeks. The subgroup comparison will be reliable if you have at least 200 technical founders in the experiment"
3. Generates the experiment configuration — assignment logic, event tracking schema, metric definitions — without the user touching a setting
4. Launches, runs, and monitors the experiment
5. Surfaces results with AI interpretation embedded directly in every chart and number

**Handling ambiguity with one question, not a form.** When the third answer is underspecified — "I want to know if this works" — the platform asks exactly one clarifying question, in natural language: "Are you more interested in whether it works overall, or whether it works differently for different types of customers?" That single answer determines whether the analysis is a standard ATE or an HTE setup. No dropdowns. No configuration screens.

**Progressive disclosure for power users.** The simple entry is the default. Users who want to see the statistical configuration — significance threshold, power, test type, subgroup pre-specification — can open it. But they never have to. The platform makes defensible statistical choices by default and explains them in plain language when asked.

**The confirmation screen, not the configuration screen.** After parsing intent, the platform shows a summary before launching: what experiment it will run, what it will be able to learn, and what it won't. The user confirms or adjusts in natural language. Statistical complexity surfaces here as *information*, not as inputs the user must supply.

---

## Core features

### 1. Standard experiment infrastructure
- Variant assignment (random, stratified)
- Event tracking SDK (TypeScript-first)
- Real-time result dashboard
- Statistical significance, confidence intervals, p-values

### 2. Know before you run — pre-experiment trust assessment

Before launching, the platform tells users exactly what the experiment can and can't reliably produce given their expected traffic and user mix.

Input:
- Expected sample size and arrival rate
- User attributes available for subgroup analysis
- Target outcome (conversion, retention, LTV, etc.)
- Hypothesized effect size

Output:
- Whether the experiment can reliably detect an overall effect at all
- Which subgroup comparisons are well-powered vs. which will be too noisy to trust
- Estimated time to trustworthy results
- A clear recommendation: run as designed / wait / redesign

The output is shown in plain language, not as a power curve. "With your current signup rate, you'll have reliable overall results in 3 weeks. Subgroup analysis by plan tier will be reliable for Starter and Pro users, but not for your Free tier — it's too small." Users act on this. They trust the results later because they were told upfront what to expect.

This is also the top-of-funnel hook — startups get value from the simulator before they've run a single experiment.

### 3. Heterogeneous treatment effects (HTE) — subgroup analysis

Rather than reporting one average treatment effect, the platform estimates how the treatment effect varies across meaningful user dimensions.

What this looks like in practice:
- User pre-specifies 1–2 dimensions they think might drive different responses (e.g., company size, plan tier, acquisition channel) before the experiment runs
- After results come in, the platform estimates the treatment effect separately for each subgroup, using methods that borrow statistical strength across groups rather than treating each in isolation
- Output: ranked subgroup effects with honest reliability signals

The pre-specification requirement is a feature, not a limitation. It forces the hypothesis upfront, prevents p-hacking, and makes the resulting estimates more precise than post-hoc slicing.

**What users see:** "The $99 plan drove a 28% lift in 90-day retention for companies with more than 20 employees. For solo founders, there was no reliable effect — the result is too uncertain to act on with your current data."

### 4. Willingness-to-pay and market experiment analysis

Beyond product HTE, the platform supports market-level experimentation — the questions that determine whether a startup is targeting the right customers at the right price.

**Price sensitivity and WTP curves:** For price experiments (randomizing price across users), the platform produces a willingness-to-pay curve per segment. Not just "conversion was lower at $99" but a visual showing at what price each segment's conversion drops, with the estimated revenue-maximizing price point per segment highlighted.

**ICP validation:** Positioning message experiments show which message resonates with which user profile. Output: "Technical founders responded strongly to the 'causal inference engine' framing (+34% conversion). Business founders showed no preference between the two messages."

**Channel quality:** Does acquisition channel predict long-term outcome quality? "Paid search users convert at 1.8× the rate of referral users, but churn at 2.4× the rate. Referral has higher LTV per experiment participant."

Pre-built templates for:
- Price sensitivity test (willingness to pay by segment)
- Positioning message test (which narrative lands with which ICP)
- Channel attribution experiment (does the acquisition channel predict outcome quality?)
- Feature pricing test (add-on vs. bundled, tiered vs. flat)

### 5. Uplift scoring — who to target

For each user in the database, the platform estimates the probability of a good outcome under each treatment. This takes experiment results and applies them forward.

- Score the existing user base: "Here are the 200 users most likely to convert if you offer them the $49 plan"
- Good outcome and bad outcome are configurable per experiment (conversion, retention, LTV)
- Scores come with explicit reliability signals based on how similar each user is to the experiment population

### 6. AI interpretation layer — statistics in plain language

This is the feature that makes everything else accessible. Every chart, every result, every subgroup comparison is accompanied by AI-generated interpretation that explains what the statistics actually mean — in language a non-technical founder can read and act on.

**The design pattern:** Results don't sit alone. Alongside each visualization, interpretation surfaces as contextual annotations — think small callout bubbles or a side panel that reads the chart the way a statistician would, but in plain English. As a WTP curve renders, annotations highlight the inflection points: "This is where $149 starts losing SMB customers. Enterprise customers are still converting at the same rate." The user doesn't need to read axes or interpret slopes — the interpretation is embedded in the experience.

Examples of what this sounds like:
- "Customers like your current free-tier users are 2× more likely to upgrade if offered the $49 plan than the $99 plan. This difference is reliable — you have enough data to act on it."
- "The difference in conversion between technical and non-technical founders looks large (18 percentage points), but your data is too thin in the non-technical segment to be confident. Don't make a positioning decision based on this yet."
- "Your experiment shows no meaningful difference between these two onboarding flows overall. But there's a strong signal that users who came from referrals responded much better to Flow B. That's worth investigating."

The interpretation layer is calibrated to the reliability of the underlying statistics. Uncertain results get uncertain language. Reliable results get direct language. The AI doesn't pretend to know more than the data supports — but it also doesn't hide behind hedging when the data is strong.

---

## Simulation partnership idea

The pre-experiment simulator is valuable even without real user data — especially for pre-launch startups or teams designing experiments for a new cohort they haven't seen before.

**Expected Parrot** (survey/LLM-simulated respondents): Partner to let teams simulate experiment outcomes against synthetic user populations before they have real traffic. A startup could describe their target user (e.g., "B2B SaaS founder, 5–50 person company, paying $50–$200/month for tools"), generate a simulated cohort, run a price sensitivity simulation, and see predicted WTP curves — all before writing a line of experiment code.

**Other potential partners:**
- Survey platforms (Wynter, Positly) for recruiting real respondents for pre-launch validation
- CDP platforms (Segment, RudderStack) for pulling user attribute distributions into power analysis

The simulator is a top-of-funnel hook: startups get value before they have an experiment running, then adopt the platform for live experiments.

---

## Key risks and mitigations

| Risk | Mitigation |
|---|---|
| Small startups lack sample size for subgroup analysis | Pre-experiment simulator sets expectations before they run; results surface reliability signals so users know what to act on |
| LLM misparses user intent and configures the wrong experiment | Confirmation screen before launch shows exactly what will run in plain language; user approves before any data is collected; explicit undo |
| AI interpretation is wrong or misleading | Calibrate language tightly to statistical reliability; bias toward hedging on uncertain results rather than false confidence |
| Incumbents add HTE as a feature | Be market-experiment-native and natural-language-native from day one; UX depth they won't prioritize |
| Data privacy / user tracking friction | Offer first-party SDK + server-side tracking; no third-party cookies required |

---

## Build phases (aligned to training curriculum)

- **Phase 1–2:** CLI tooling, GitHub repo, Docker setup, CI/CD for the platform
- **Phase 2–3:** System design (event ingestion, experiment assignment service), PRD for MVP
- **Phase 4:** ML foundations — understand evaluation, inference, and the ML lifecycle before building the HTE and WTP analysis layers
- **Phase 5:** Prompt engineering for the AI interpretation layer; red-team the ML outputs; telemetry for experiment quality monitoring
- **Phase 6:** Landscape analysis (where does this fit in the market?), model economics, capstone — ship a working MVP

Artifacts from each module's exercises will feed directly into the platform where possible.

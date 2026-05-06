# Phase 6 Plan: Landscape + Capstone

**Goal:** Synthesize everything. Build a map of the AI industry. Ship a demo. Construct your portfolio and interview narratives.

**Modules:**
1. `ai-landscape` — who's doing what and why
2. `model-economics` — how the economics of AI work
3. `hci-research` — the research areas at the intersection of AI and human experience
4. `robotics` — embodied AI survey
5. `capstone` — portfolio, demos, and interview prep

The landscape modules (1–4) can be done in any order. The capstone should be last.

---

## Module-by-module approach

### ai-landscape
**Start here — it provides context for everything else in this phase.**

1. Read the State of AI Report (or the summary) before doing exercises.
2. Exercise Set 1 (landscape map) — build the table yourself. Don't copy from a source; force yourself to recall.
3. Exercise Set 2 (lab comparison) — write the comparison in your own words. The goal is an opinion, not a summary.
4. Exercise Set 3 (vertical AI analysis) — pick an industry you have genuine curiosity about.
5. Exercise Set 4 (investment thesis) — be honest about what you'd bet on and why. What would make you wrong is the hardest and most important question.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/COMPETITIVE-ANALYSIS.md`. Map the experimentation platform landscape specifically — this directly informs your go-to-market. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### model-economics
**After ai-landscape — the economics make more sense with the landscape context.**

1. Read the Epoch AI pricing trend data before doing exercises.
2. Exercise Set 1 (pricing timeline) — track the price history. The rate of decline is often surprising.
3. Exercise Set 2 (cost structure) — use the product category you care about most.
4. Exercise Set 3 (Chinchilla scaling laws) — read the abstract and Figure 1 only. Don't get lost in the math.
5. Exercise Set 4 (commoditization strategy) — pick a real company. Be specific about their moat.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/ML-COST-MODEL.md`. Model the compute costs for running causal forests at scale — this directly impacts the platform's pricing. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### hci-research
**Independent — do whenever you have the most energy for it.**

1. Start with the literature survey (Exercise Set 1). Find 3 real papers; read them properly.
2. Exercise Set 2 (trust calibration analysis) — apply the framework to AI tools you've actually used.
3. Exercise Set 3 (design an intelligent UI) — write a detailed design spec. This connects HCI theory to product work.
4. Exercise Set 4 (research agenda) — write your own. Where would you actually investigate if you had the resources?

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/UX-RESEARCH-PLAN.md`. Design user research sessions for the platform — focus on the simulation feature and HTE results interpretation. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### robotics
**This is a survey module — lighter reading, no build exercises.**

1. Read through the core concepts. Focus on "why embodied AI is hard" — this is the substance.
2. Exercise Set 1 (technology landscape map) — research 6 companies. Check their current deployment status.
3. Exercise Set 2 (watch and annotate) — watch one video and actually pause and annotate it.
4. Exercise Set 3 (sim-to-real reading) — find a real paper or blog post. Write the summary.

### capstone
**Last. Do this after all other Phase 6 modules and after most of Phase 5.**

The capstone is not a module you "complete" — it's where everything lands.

**Suggested sequence:**

1. **Choose your demo project** — pick one of Options A, B, or C in the capstone module. Commit to one. Don't spend more than one session deciding.

2. **Build the demo** — work through it iteratively. Ship something working before polishing.
   - Make it deployable (not just local)
   - Write the README as you build, not after

3. **Write the portfolio narrative** — open `docs/projects/PORTFOLIO.md`. Write the "who I am + what I built" section first. Then link your artifacts.

4. **Write the interview narratives** — all 5 prompts in `docs/projects/INTERVIEW-NARRATIVES.md`. Say each one out loud. Revise until you can deliver it fluently without reading.

5. **Final curriculum map update** — go through every module in `docs/CURRICULUM-MAP.md`. Mark everything accurately. This is your honest accounting.

6. **Final log entry** — write a proper reflection in `docs/LOG.md`: what surprised you, what was harder than expected, what you'd do differently.

> **→ Platform:** The capstone is the platform. By now `src/` should contain a working MVP. See [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for the full list of what should be built.

---

## The program is complete when:
- [ ] All modules in all phases marked `complete` in the curriculum map
- [ ] At least one demo deployed with a live URL
- [ ] `docs/projects/PORTFOLIO.md` written and committed
- [ ] `docs/projects/INTERVIEW-NARRATIVES.md` written and committed (all 5 prompts)
- [ ] `docs/reading/AI-LANDSCAPE-MAP.md` committed
- [ ] `docs/reading/AI-INVESTMENT-THESIS.md` committed
- [ ] `docs/reading/RESEARCH-AGENDA.md` committed
- [ ] Final `docs/LOG.md` entry committed
- [ ] You can answer any of the 5 interview prompts without notes

**Platform artifacts from this phase:**
- [ ] `docs/projects/experimentation_platform/COMPETITIVE-ANALYSIS.md` (from `ai-landscape`)
- [ ] `docs/projects/experimentation_platform/ML-COST-MODEL.md` (from `model-economics`)
- [ ] `docs/projects/experimentation_platform/UX-RESEARCH-PLAN.md` (from `hci-research`)
- [ ] `src/` — working MVP (capstone)

---

## A note on done

"Done" is not a checklist completion. It's when you can walk into a technical conversation, understand what's being discussed, contribute a point of view, ask a useful question, and ship something small. The portfolio is evidence of that, not a substitute for it.

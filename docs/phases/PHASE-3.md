# Phase 3 Plan: Product Craft + Business/Finance

**Goal:** Build the vocabulary and frameworks for thinking about products and businesses — the non-technical fluency that lets you operate at the PM/engineering interface.

**Can run in parallel with Phase 2.** No hard dependency between them.

**Modules:**
1. `prds` — how decisions get documented and aligned
2. `unit-economics` — does this business make money per customer?
3. `financial-statements` — how do you read a company's health?
4. `privacy-compliance` — what constraints shape product decisions?
5. `notion` — integrated tool module
6. `figma` — integrated tool module
7. `agile` — how software teams organize and execute work
8. `program-management` — TPM fundamentals: RACI, OKRs, risk registers, cross-team coordination
9. `technical-communication` — design docs, executive briefings, decision records

---

## Module-by-module approach

### prds
**Start here — it's the most conceptually central to PM work.**

1. Read the "What a PRD contains" section carefully. Each section exists for a reason — internalize the *why*.
2. Exercise Set 1 (critique a PRD) — find a real example online before writing your own. Critiquing is easier and teaches you what to avoid.
3. Exercise Set 2 (write a mini PRD) — this is the main artifact. Pick a product feature you'd genuinely want to exist. Don't write a fictional one.
4. Exercise Set 3 (read Shape Up) — Shape Up is a contrarian take that sharpens your thinking on scope and uncertainty. Worth the read.
5. Exercise Set 4 (decision log) — apply the one-way/two-way door framework to a real decision you've seen made.

Key things to internalize:
- What belongs in a problem statement vs a requirement
- Why non-goals are as important as goals
- The difference between a one-way and two-way door decision

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/PRD.md`. Write the PRD for the experimentation platform MVP specifically. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### unit-economics
**After prds — builds on product thinking with financial rigor.**

1. Read through all formulas first, then do Exercise Set 1 (calculate unit economics). Don't skip the math.
2. Exercise Set 2 (churn scenarios) — the goal is to see that NRR > 100% makes churn survivable.
3. Exercise Set 3 (read an S-1) — Snowflake, Datadog, or HubSpot are readable. Look at how they present retention data.
4. Exercise Set 4 (build a model) — do this in a spreadsheet. The exercise of building the model matters more than the output.

Key things to internalize:
- LTV = ARPU ÷ churn rate (for steady-state businesses)
- Why NRR > 100% means a business can grow even without new customers
- The Magic Number and what a reading of 0.4 tells you

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/UNIT-ECONOMICS.md`. Model the pricing and unit economics for the platform specifically — usage-based vs. seat-based vs. experiment-volume pricing. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### financial-statements
**After unit-economics — this adds the public company layer.**

1. Start with the income statement — it's the most intuitive.
2. Exercise Set 1 (read a real income statement) — Datadog or Cloudflare investor relations page.
3. Exercise Set 2 (deferred revenue) — this is the confusing SaaS-specific concept. Work through the numbers.
4. Exercise Set 3 (Rule of 40) — look up 3 public SaaS companies, calculate their score. Does the number match your intuition about their health?
5. Exercise Set 4 (bridge from unit economics) — build the simple P&L.

Key things to internalize:
- Why deferred revenue is a liability but actually a good sign
- Gross margin vs operating margin — what's included in each
- Free cash flow vs GAAP net income — why FCF is more meaningful for SaaS

### privacy-compliance
**Independent — can be done alongside any other module.**

1. Read the GDPR section carefully — you'll encounter these requirements in almost any product that touches EU users.
2. Exercise Set 1 (data flow map) — this is the most practical exercise. Do it for a hypothetical product you'd actually build.
3. Exercise Set 2 (read a real privacy policy) — use Notion or Linear. Read it properly.
4. Exercise Set 3 (GDPR vs CCPA comparison table) — build the table; the contrast makes both clearer.
5. Exercise Set 4 (product decision) — the personalization scenario. Think through all the implications.

Key things to internalize:
- The 6 lawful bases for processing under GDPR
- Opt-in (GDPR default) vs opt-out (CCPA default)
- What a DPA is and why you need one with every vendor

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/PRIVACY-COMPLIANCE.md`. An experiment platform tracks user behavior — the compliance obligations are significant. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### notion + figma
**Do these when they're useful, not as a block.**

- `notion`: set up your tracking workspace for this program first (Exercise Set 1), then come back for the API exploration when you're working on http-apis.
- `figma`: do this after you've read PRDs — the design → spec → build flow is most useful when you understand what a PRD is.

These are tools, not concepts. The exercises matter more than the reading.

> **→ Platform artifact (figma):** Produce `docs/projects/experimentation_platform/DESIGN-MOCKUPS.md`. Mockup the experiment setup flow, results dashboard, HTE segment view, and simulation screen. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### agile
**Do after prds and before program-management — Agile is team-level; program management coordinates across Agile teams.**

1. Read the Agile Manifesto and all 12 principles before anything else. It takes 10 minutes and is load-bearing.
2. Watch the "Scrum in 20 minutes" video, then read the Scrum Guide. The video gives you the picture; the Guide gives you the precision.
3. Exercise Set 1 (principles notes) — write the ceremony removal thought experiment before looking for answers. The reasoning matters more than the answer.
4. Exercise Set 2 (user stories) — write them for the platform, not a hypothetical product. Acceptance criteria are the hard part; don't write vague ones.
5. Exercise Set 3 (sprint planning) — actually constrain yourself to 30 points. The tradeoff decisions are the exercise.
6. Exercise Set 4 (retrospective) — design for the specific situation described, not a generic retro format.
7. Exercise Set 5 (cross-team dependencies) — this is the TPM exercise. Think about what breaks if Squad A slips 1 week.

Key things to internalize:
- The three Scrum roles and why the Scrum Master is not a project manager
- WIP limits in Kanban: they feel counterintuitive until you understand the queueing theory
- DORA metrics: deploy frequency and lead time are the ones that actually correlate with outcomes

### program-management
**Do after agile — program management is the cross-team coordination layer on top of team-level Agile.**

1. Read the "What a TPM does" and "Program structure" sections first — internalize the vocabulary before doing any exercises.
2. Exercise Set 1 (RACI matrix) — build a real matrix for a plausible project, not a toy example. The hardest part is finding the multiple-Accountable mistakes.
3. Exercise Set 2 (dependency map) — map the causal forest feature dependencies. Draw the graph before building the table.
4. Exercise Set 3 (risk register) — don't write abstract risks. Write specific, named risks with a named owner.
5. Exercise Set 4 (program status update) — write a real one. Practice keeping it to one page.
6. Exercise Set 5 (OKRs) — the hardest exercise. "Measurable" is the hard constraint. Don't accept vague key results.

Key things to internalize:
- RACI and why only one Accountable owner per decision
- Critical path vs float — the distinction matters for triage
- OKR grades: 0.7 at Google means the goal was appropriately ambitious

### technical-communication
**Do after program-management — the documents you write as a TPM depend on understanding the PM landscape.**

1. Read the "Document type landscape" section first — memorize which document serves which purpose.
2. Read Malte Ubl's "Design Docs at Google" post before starting Exercise Set 1.
3. Exercise Set 1 (design doc) — this is the main artifact. Write all 7 sections. The "Alternatives considered" section is the one most people skip; don't.
4. Exercise Set 2 (executive 1-pager) — practice BLUF. The recommendation comes first, every time.
5. Exercise Set 3 (decision doc) — write the database decision. Be specific about tradeoffs.
6. Exercise Set 4 (audience translation) — this is the skill interviewers actually probe for. Practice it.

Key things to internalize:
- The Pyramid Principle: conclusion first, then key arguments, then evidence
- BLUF: the reader may stop after the first sentence; make that sentence count
- "Alternatives considered" is the section that signals rigor

---

## Phase 3 is complete when:
- [ ] All nine modules marked `complete` in the curriculum map
- [ ] `docs/projects/MINI-PRD.md` committed
- [ ] `docs/reading/SHAPE-UP-NOTES.md` committed
- [ ] `docs/reading/UNIT-ECON-CALC.md` committed
- [ ] `docs/reading/FINANCIAL-STMT-EXERCISE.md` committed
- [ ] `docs/reading/PRIVACY-DATA-MAP.md` committed
- [ ] `docs/reading/AGILE-PRINCIPLES-NOTES.md` committed
- [ ] `docs/reading/USER-STORIES-EXERCISE.md` committed
- [ ] `docs/reading/SPRINT-PLANNING-EXERCISE.md` committed
- [ ] `docs/reading/RETROSPECTIVE-EXERCISE.md` committed
- [ ] `docs/reading/CROSS-TEAM-DEPENDENCIES.md` committed
- [ ] `docs/reading/RACI-EXERCISE.md` committed
- [ ] `docs/reading/DEPENDENCY-MAP.md` committed
- [ ] `docs/reading/RISK-REGISTER.md` committed
- [ ] `docs/reading/PROGRAM-STATUS-TEMPLATE.md` committed
- [ ] `docs/reading/OKRS-EXPERIMENTATION-PLATFORM.md` committed
- [ ] `docs/reading/DESIGN-DOC-EXERCISE.md` committed
- [ ] `docs/reading/EXEC-BRIEFING-EXERCISE.md` committed
- [ ] `docs/reading/DECISION-DOC-EXERCISE.md` committed
- [ ] Glossary has entries for: PRD, non-goal, LTV, CAC, NRR, churn, gross margin, EBITDA, deferred revenue, GDPR, CCPA, DPA, Agile, Scrum, sprint, backlog, story point, velocity, WIP limit, DORA metrics, user story, acceptance criteria, TPM, RACI, critical path, risk register, OKR, design doc, BLUF, decision doc

**Platform artifacts from this phase:**
- [ ] `docs/projects/experimentation_platform/PRD.md` (from `prds`)
- [ ] `docs/projects/experimentation_platform/UNIT-ECONOMICS.md` (from `unit-economics`)
- [ ] `docs/projects/experimentation_platform/PRIVACY-COMPLIANCE.md` (from `privacy-compliance`)
- [ ] `docs/projects/experimentation_platform/DESIGN-MOCKUPS.md` (from `figma`)

**Next:** Open `docs/phases/PHASE-4.md`

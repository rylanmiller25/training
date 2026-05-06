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

### notion + figma
**Do these when they're useful, not as a block.**

- `notion`: set up your tracking workspace for this program first (Exercise Set 1), then come back for the API exploration when you're working on http-apis.
- `figma`: do this after you've read PRDs — the design → spec → build flow is most useful when you understand what a PRD is.

These are tools, not concepts. The exercises matter more than the reading.

---

## Phase 3 is complete when:
- [ ] All six modules marked `complete` in the curriculum map
- [ ] `docs/projects/mini-prd.md` committed
- [ ] `docs/reading/shape-up-notes.md` committed
- [ ] `docs/reading/unit-econ-calc.md` committed
- [ ] `docs/reading/financial-stmt-exercise.md` committed
- [ ] `docs/reading/privacy-data-map.md` committed
- [ ] Glossary has entries for: PRD, non-goal, LTV, CAC, NRR, churn, gross margin, EBITDA, deferred revenue, GDPR, CCPA, DPA

**Next:** Open `docs/phases/phase-4.md`

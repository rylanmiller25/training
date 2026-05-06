# Module: PRDs + Product Decision-Making

**Phase:** 3  
**Slug:** `prds`  
**Status:** not started  

---

## What it is / how to think about it

A PRD (Product Requirements Document) is how product managers communicate *what to build and why* to engineers, designers, and stakeholders. A great PRD reduces ambiguity, surfaces tradeoffs, and aligns teams before expensive work begins.

**Mental model:** A PRD is a decision log + scoping contract. It answers: what problem are we solving, for whom, why now, what are we building (and explicitly NOT building), and how do we know it worked?

The real skill isn't writing the document — it's the thinking required to fill it in well.

---

## Prerequisites
- No technical prereqs. Benefits from: HTTP + APIs (technical feasibility reasoning), System Design basics.

---

## Best resources

**Primary:**
1. [Lenny's Newsletter – PRD templates](https://www.lennysnewsletter.com/p/my-favorite-product-management-templates) — curated by a top PM newsletter, includes real examples
2. [Shape Up – Basecamp](https://basecamp.com/shapeup) (free book) — alternative to traditional PRDs; excellent framing for scope and uncertainty

**Supporting:**
- [Good Product Manager / Bad Product Manager – Ben Horowitz](https://a16z.com/good-product-manager-bad-product-manager/) — classic essay on PM craft
- [The PM's job is to make the team go fast – Shreyas Doshi](https://twitter.com/shreyas/status/1390823372951474178) — Twitter thread on leverage
- [Inspired: How Tech Companies Build Products – Marty Cagan](https://svpg.com/inspired-how-tech-companies-build-products/) — read chapters 1–5 for product context

**YouTube:**
- [How to write a PRD – Lenny Rachitsky](https://www.youtube.com/watch?v=GNZH3LS3VfA) (20 min)
- [Product Management Mental Models – Kevin Lee](https://www.youtube.com/watch?v=HulgmY15bAc) (15 min)

---

## Core concepts to cover

### What a PRD contains (and why each section exists)

**1. Problem statement**
- What user pain are we solving? Whose? How often? How badly?
- Backed by: user research, support tickets, NPS verbatims, data
- Red flag: "we should build X" without connecting to a real problem

**2. Goals and non-goals**
- Goals: specific, measurable outcomes (not outputs)
- Non-goals: explicitly list what you are NOT building this time — scope defense
- Non-goals are as important as goals; they protect the team from scope creep

**3. User stories / jobs to be done**
- "As a [user], I want to [do something] so that [outcome]"
- Jobs-to-be-done: "When [situation], I want to [motivation], so I can [outcome]"
- Write from user perspective, not implementation perspective

**4. Requirements (functional + non-functional)**
- Functional: what the system does (user can upload a file, system sends confirmation email)
- Non-functional: how it performs (response < 200ms, 99.9% uptime, GDPR compliant)
- Prioritize: must-have (P0) / should-have (P1) / nice-to-have (P2)

**5. Success metrics**
- Primary metric: what moves if this feature works?
- Guardrail metrics: what must NOT regress?
- Avoid vanity metrics (page views); prefer leading indicators

**6. Open questions + risks**
- What do you NOT know yet?
- What could go wrong? (technical, legal, UX, competitive)
- Who needs to sign off?

### Making decisions under uncertainty
- **Reversibility:** for reversible decisions, move fast and learn; for irreversible, be more careful
- **Two-way vs one-way doors:** Bezos framing — most product decisions are two-way doors
- **Opportunity cost:** choosing to build X means NOT building Y
- **Scope cutting:** ship a simpler version first; add complexity only when validated
- **Disagree and commit:** once a decision is made, align and move even if you disagreed

### PRD antipatterns to avoid
- Solution in the problem statement (leading with the answer)
- Requirements that are really implementation details
- "Stretch goals" instead of explicit non-goals
- Missing success metrics (you can't know if it worked)
- No open questions (overconfidence)

---

## Exercises

**Set 1 — Critique a PRD (30 min):**
Find a product spec example online (search "product requirements document example" or use Lenny's templates). Evaluate it against: clear problem statement? Specific success metrics? Explicit non-goals? Open questions listed?
Write a 5-bullet critique in `docs/reading/prd-critique.md`.

**Set 2 — Write a mini PRD (60–90 min):**
Write a PRD for a feature you'd actually want to exist. Keep it short (1–2 pages). Sections required:
- Problem statement (with user + frequency + pain level)
- Goals (2–3, measurable)
- Non-goals (2–3, explicit)
- User stories (3–5)
- Requirements: P0/P1/P2
- Success metrics (primary + guardrail)
- Open questions (2–3)
Save to `docs/projects/mini-prd.md`.

**Set 3 — Read Shape Up (3–4 hours):**
Read Part 1 and Part 2 of [Shape Up](https://basecamp.com/shapeup) (chapters 1–9).
Write a 1-page note summarizing: what is "shaping"? What's an appetite? What's a pitch? How does this differ from traditional PRDs?
Save to `docs/reading/shape-up-notes.md`.

**Set 4 — Decision log exercise (20 min):**
Think of a product decision you've seen made (any context). Fill in:
- What was the decision?
- What options were considered?
- What information was missing?
- Was it a one-way or two-way door?
- What metric would tell you if it was right?
Save to `docs/reading/decision-log-exercise.md`.

---

## Checks — you understand this when you can:
- [ ] Write a problem statement that describes user pain without prescribing a solution
- [ ] Distinguish a functional requirement from a non-functional requirement
- [ ] Write 3 success metrics for a hypothetical feature (including a guardrail)
- [ ] Explain the difference between one-way and two-way door decisions
- [ ] Critique a PRD for missing sections or antipatterns
- [ ] Explain what Shape Up's "appetite" and "pitch" replace in traditional PM processes

---

## Artifacts to commit
- [ ] `docs/projects/mini-prd.md` — your own PRD
- [ ] `docs/reading/prd-critique.md`
- [ ] `docs/reading/shape-up-notes.md`
- [ ] `docs/reading/decision-log-exercise.md`
- [ ] Log entry in `docs/log.md`

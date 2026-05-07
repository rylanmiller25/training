# Module: Agile Methods and Team Execution

**Phase:** 3  
**Slug:** `agile`  
**Status:** not started  

---

## What it is / how to think about it

Agile is the dominant way software teams organize their work. If you're a TPM at Google or DeepMind, every team you'll coordinate with operates inside some version of Agile — sprints, backlogs, standups, retrospectives. Understanding the methodology from the inside lets you work with these teams rather than around them.

**Mental model:** Traditional project management (Waterfall) plans everything upfront, then executes. Agile inverts this — plan just enough to start, ship something small, learn, adjust, repeat. The core bet: in software, requirements change and the best plan is the one you can update.

Goal for this module: understand Agile deeply enough to facilitate its ceremonies, manage dependencies *across* Agile teams (the TPM's specific challenge), and have an informed opinion about when Agile works and when it doesn't.

---

## Prerequisites
- `prds` — Agile user stories and PRDs are complementary; understand what a product decision doc looks like first
- `program-management` — Agile is team-level methodology; program management is cross-team coordination; knowing both makes each clearer

---

## Best resources

**Primary:**
1. [The Agile Manifesto](https://agilemanifesto.org/) — read the manifesto and all 12 principles; short but load-bearing
2. [Scrum Guide (official, 2020)](https://scrumguides.org/scrum-guide.html) — the definitive Scrum reference; 13 pages; read it properly
3. [Shape Up — Basecamp](https://basecamp.com/shapeup) — a contrarian take on Agile from the team that builds project management software; free online; chapters 1–4 and chapters 9–11 are most relevant

**Supporting:**
- [Accelerate — Forsgren, Humble, Kim](https://itrevolution.com/accelerate-book/) — the research behind what actually makes software teams effective; the DORA metrics
- [Kanban: Successful Evolutionary Change — David Anderson](https://www.amazon.com/Kanban-Successful-Evolutionary-Technology-Business/dp/0984521402) — the Kanban bible; chapters 1–4 are sufficient
- [An Elegant Puzzle — Will Larson](https://lethain.com/elegant-puzzle/) — chapters on team design and managing growing teams complement Agile methodology

**YouTube:**
- [Scrum in 20 minutes — Scrum.org](https://www.youtube.com/watch?v=2Vt7Ik8Ublw) (20 min — watch before reading the Scrum Guide)
- [Kanban vs Scrum — Atlassian](https://www.youtube.com/watch?v=rIaz-l1Kf8w) (6 min)
- [Story points are broken — MKBHD — just kidding; use this instead](https://www.youtube.com/watch?v=5YGkEAccsY4) (15 min — "why story points fail")

---

## Core concepts to cover

### The Agile Manifesto and why it exists

Four values (left is prioritized over right):
- **Individuals and interactions** over processes and tools
- **Working software** over comprehensive documentation
- **Customer collaboration** over contract negotiation
- **Responding to change** over following a plan

12 principles: the most important are (1) deliver working software frequently, (2) welcome changing requirements, (3) sustainable pace, and (4) simplicity — the art of maximizing work not done.

Context: Agile emerged in 2001 as a reaction to heavyweight waterfall processes that were failing software teams. Understanding *what it was reacting against* makes the values make more sense.

### Scrum

Scrum is the most widely used Agile framework. Three roles, five ceremonies, three artifacts.

**Roles:**
- **Product Owner (PO):** owns the product backlog; decides what gets built and in what order; the single voice of the business to the team
- **Scrum Master:** facilitates ceremonies, removes blockers, coaches the team on Scrum; does *not* manage the team
- **Development Team:** cross-functional, self-organizing; owns the *how*

**Artifacts:**
- **Product Backlog:** the full ordered list of everything that might be built; owned by the PO; prioritized constantly
- **Sprint Backlog:** the subset of backlog items the team commits to completing in this sprint, plus their plan
- **Increment:** the working, potentially shippable product at the end of each sprint

**Ceremonies (the five events):**

| Ceremony | Who | Cadence | Purpose | Time-box |
|---|---|---|---|---|
| Sprint Planning | Full team | Start of each sprint | What will we do this sprint? How? | ≤ 8 hrs / 4-week sprint |
| Daily Scrum (standup) | Dev team | Daily | What did I do, what will I do, what's blocking me? | 15 min |
| Sprint Review | Full team + stakeholders | End of sprint | Demo the increment; get feedback | ≤ 4 hrs |
| Sprint Retrospective | Full team | End of sprint | How did we work? What do we improve? | ≤ 3 hrs |
| Backlog Refinement | PO + dev team | Mid-sprint | Clarify, estimate, and order upcoming backlog items | ≤ 10% of sprint capacity |

**Sprints:** fixed-length iterations (1–4 weeks, most commonly 2). The sprint is a time-box — the team commits to a goal, then executes, with no scope changes mid-sprint.

### Kanban

Kanban is a flow-based system (not iteration-based). Work flows continuously from "To Do" through "In Progress" to "Done." The key constraint: **Work-In-Progress (WIP) limits** — caps on how many items can be in each column simultaneously.

Why WIP limits matter: too much in progress at once creates context-switching overhead, delays, and invisible blockers. WIP limits force the team to finish things before starting new things.

Key Kanban metrics:
- **Cycle time:** how long a ticket takes from "started" to "done" — the primary measure of throughput
- **Lead time:** how long a ticket takes from "requested" to "done" — includes time waiting to start
- **Throughput:** number of items completed per unit time

When to use Kanban over Scrum: teams with continuous incoming work (support, ops, DevOps), teams where work items aren't comparable in size, or as a starting point for teams new to Agile.

### Agile estimation

**Story points:** relative effort estimates for backlog items. Not hours — abstract units that capture effort, complexity, and uncertainty together. Common scales: Fibonacci (1, 2, 3, 5, 8, 13, 21) or T-shirt sizes (XS, S, M, L, XL).

**Planning poker:** estimation by consensus. Each team member simultaneously reveals their estimate on a card. Outliers explain their reasoning; the team discusses and re-estimates until aligned.

**Velocity:** the average number of story points a team completes per sprint. Used for capacity planning: if velocity is 35 points/sprint and the backlog has 140 points, expect ~4 sprints.

Caution: velocity is a *planning* tool, not a performance metric. Comparing velocity across teams is meaningless — estimates are relative to the team that made them.

**User stories:** the standard format for backlog items:

> As a [type of user], I want [feature or capability] so that [benefit or reason].

Each user story has **acceptance criteria** — specific, testable conditions that define "done" for that story. Without acceptance criteria, done means nothing.

Example:
> **Story:** As a startup founder, I want to see a WTP curve for my pricing experiment so that I can identify the revenue-maximizing price point per customer segment.
>
> **Acceptance criteria:**
> - WTP curve renders for price experiments with 2+ price points and 50+ users per price
> - Curve is broken out by any pre-specified subgroup dimension
> - AI interpretation bubble highlights the inflection point in plain language
> - Insufficient data state shows when sample is too small

### DORA metrics — what actually predicts team effectiveness

The Accelerate research (Forsgren, Humble, Kim) identified four metrics that correlate with software team performance:

1. **Deployment frequency:** how often do you deploy to production? (Elite: multiple times per day)
2. **Lead time for changes:** time from code commit to production? (Elite: less than 1 hour)
3. **Change failure rate:** % of deployments that cause incidents? (Elite: 0–15%)
4. **Mean time to restore (MTTR):** how long to recover from failures? (Elite: less than 1 hour)

These are the metrics to understand, not velocity or story points. A team with high velocity but 50% change failure rate is not performing well.

### Agile at scale — SAFe and alternatives

Single-team Agile is well-understood. Coordinating 5–20 Agile teams around a shared product program is harder and is the TPM's core challenge.

**SAFe (Scaled Agile Framework):** the most widely adopted enterprise scaling approach. Adds a "Program Increment" (PI) level above the sprint — a 10-week planning cycle across all teams. Includes: Program Increment Planning (a 2-day event where all teams align on a shared plan), Agile Release Trains (ARTs — teams of teams that share a mission), and explicit cross-team dependency mapping.

**Spotify model:** tribes (groups of squads working on a related area), squads (autonomous teams), chapters (horizontal communities of practice), guilds (cross-tribe interest groups). Influential but not a blueprint — Spotify themselves don't use it as described.

**LeSS (Large-Scale Scrum):** fewer roles and artifacts than SAFe; closer to pure Scrum principles; works better for smaller scaling challenges.

What a TPM does in any scaled Agile environment: identify cross-team dependencies in PI planning, track risks that span multiple squads, facilitate resolution of impediments the Scrum Master can't resolve within one team.

### The Scrum Master vs TPM distinction

A Scrum Master operates within one team. They facilitate ceremonies, coach on Agile practices, and remove intra-team blockers.

A TPM operates across teams. They coordinate dependencies between teams, manage program-level risks, and ensure that multiple Agile teams are moving toward a shared outcome. A TPM may work with 3–8 Scrum Masters simultaneously.

The TPM does not replace the Scrum Master and should not run individual team ceremonies. They show up *between* teams, not *inside* them.

---

## Exercises

**Set 1 — Read the Scrum Guide + Agile Manifesto (60 min):**
Read both. Write a one-paragraph summary of: what would go wrong if you removed the Daily Scrum? What would go wrong if you removed the Sprint Retrospective? What do the 12 principles say about documentation?
Save to `docs/reading/AGILE-PRINCIPLES-NOTES.md`.

**Set 2 — Write user stories with acceptance criteria (45 min):**
Write 5 user stories for the experimentation platform's pre-experiment simulator feature. For each:
- Use the "As a... I want... so that..." format
- Write 3–5 acceptance criteria (specific, testable, binary)
- Estimate in story points (use Fibonacci scale; be consistent relative to each other)

Save to `docs/reading/USER-STORIES-EXERCISE.md`.

**Set 3 — Design a sprint (45 min):**
Imagine a 2-week sprint for a 4-person team building the experimentation platform's results dashboard. The team has a velocity of 30 points.

From the following backlog (with given point estimates), select what goes into the sprint:
- Implement ATE display card (5 pts)
- Add subgroup breakdown table (8 pts)
- AI interpretation bubble on main results (13 pts)
- WTP curve visualization (13 pts)
- Insufficient data state and messaging (5 pts)
- Export results as CSV (3 pts)
- Add loading states to all charts (2 pts)

Write the sprint goal (one sentence), the selected backlog items and why, and which items are deferred and why.
Save to `docs/reading/SPRINT-PLANNING-EXERCISE.md`.

**Set 4 — Retrospective design (30 min):**
Design a 60-minute retrospective for a team that just shipped a sprint but had a production incident mid-sprint and missed one sprint goal item. What format would you use? What questions would you ask? What outcome do you want from the retro?
Save to `docs/reading/RETROSPECTIVE-EXERCISE.md`.

**Set 5 — Cross-team dependency mapping (30 min):**
The experimentation platform is being built by two squads simultaneously:
- Squad A: data pipeline and experiment assignment service
- Squad B: results dashboard and AI interpretation layer

List at least 5 cross-team dependencies between these squads. For each: which squad is the producer, which is the consumer, what's the risk if it slips, and how would a TPM track it?
Save to `docs/reading/CROSS-TEAM-DEPENDENCIES.md`.

---

## Checks — you understand this when you can:
- [ ] Name Scrum's three roles, five ceremonies, and three artifacts without looking anything up
- [ ] Explain the difference between a product backlog and a sprint backlog
- [ ] Write a user story with acceptance criteria that a developer could implement from
- [ ] Explain what WIP limits do in Kanban and why they help
- [ ] Explain velocity and why it shouldn't be compared across teams
- [ ] Name the four DORA metrics and explain why they matter more than velocity
- [ ] Explain the difference between what a Scrum Master does and what a TPM does
- [ ] Explain what SAFe's Program Increment is and why large programs need something like it

---

## Artifacts to commit
- [ ] `docs/reading/AGILE-PRINCIPLES-NOTES.md`
- [ ] `docs/reading/USER-STORIES-EXERCISE.md`
- [ ] `docs/reading/SPRINT-PLANNING-EXERCISE.md`
- [ ] `docs/reading/RETROSPECTIVE-EXERCISE.md`
- [ ] `docs/reading/CROSS-TEAM-DEPENDENCIES.md`
- [ ] Glossary entries: Agile, Scrum, sprint, backlog, story point, velocity, WIP limit, Kanban, DORA metrics, SAFe, Program Increment, user story, acceptance criteria, Scrum Master, retrospective
- [ ] Log entry in `docs/LOG.md`

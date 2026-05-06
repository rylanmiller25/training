# Module: Program Management for Technical Roles

**Phase:** 3  
**Slug:** `program-management`  
**Status:** not started  

---

## What it is / how to think about it

A Technical Program Manager (TPM) does not write code or own the product vision — they own *execution*. Their job is to take a complex, multi-team technical initiative and make sure it actually ships: coordinating dependencies, surfacing risks early, keeping stakeholders informed, and driving alignment without having authority over anyone.

**Mental model:** Think of a TPM as the connective tissue of an engineering organization. Individual engineers own components. Engineering managers own their teams. Product managers own the "what." The TPM owns the *how, when, and who* — the cross-team coordination that would otherwise fall through the cracks.

Goal for this module: build the vocabulary, tools, and operating instincts for TPM work. Every concept here has a direct analog in the work you'll do as a candidate and in your first months on the job.

---

## Prerequisites
- `prds` — you need to understand what a product decision document looks like before managing a program around one
- `technical-communication` — program management is downstream of clear writing

---

## Best resources

**Primary:**
1. [An Elegant Puzzle — Will Larson](https://lethain.com/elegant-puzzle/) — the best book on engineering organization; chapters on systems thinking apply directly to TPM work
2. [Measure What Matters — John Doerr](https://www.whatmatters.com/) — the canonical OKR book; used at Google since the late 1990s
3. [How Google Works — Eric Schmidt & Jonathan Rosenberg](https://www.howgoogleworks.net/) — Google's operating culture; relevant to any Google TPM role

**Supporting:**
- [TPM competencies — Google's published framework](https://grow.google/intl/ALL_us/story/what-is-a-technical-program-manager/) — what Google says it looks for
- [Risk management basics — PMI](https://www.pmi.org/learning/library/risk-management-concept-terms-defined-1798) — foundational PM terminology
- [DACI vs RACI — Medium/Atlassian](https://www.atlassian.com/blog/teamwork/daci-decision-making-framework) — decision-making frameworks compared

**YouTube:**
- [Google TPM interview prep — Exponent](https://www.youtube.com/watch?v=K-DFjlzHOmY) (30 min — what Google actually asks)
- [OKR goal-setting — Google for Startups](https://www.youtube.com/watch?v=mJB83EZtAjc) (20 min)

---

## Core concepts to cover

### What a TPM does (vs PM vs EM)

| Role | Owns | Primary artifact |
|---|---|---|
| PM (product manager) | What to build and why | PRD, roadmap, success metrics |
| EM (engineering manager) | Who builds it, team health | Team performance, career growth |
| TPM (technical program manager) | How it gets built across teams, when | Program plan, risk register, status update |

Key insight: TPMs operate *across* teams. A PM owns one product area; a TPM spans multiple teams to deliver a program (a collection of projects coordinated toward a shared goal).

### Program structure

- **Program:** the umbrella initiative (e.g., "launch the causal forest feature by Q4")
- **Project:** a time-bounded unit of work owned by one team within the program
- **Workstream:** a track of parallel work (e.g., ML infrastructure workstream, API workstream, frontend workstream)
- **Milestone:** a meaningful checkpoint that proves progress (not just "done 30% of tasks")
- **Launch gate / go/no-go:** a formal decision point before releasing to customers

Good milestones are verifiable: "demo works end-to-end on staging" is better than "integration 50% complete."

### RACI matrix

RACI defines who is involved in each decision or deliverable:

- **Responsible:** Does the work. One team or person.
- **Accountable:** Ultimately owns the outcome. Approves the output. One person only.
- **Consulted:** Two-way communication; their input is needed before decisions. (Subject matter experts, legal, security)
- **Informed:** One-way communication; they're kept in the loop but don't need to weigh in.

Common mistakes: multiple Accountable parties (creates diffusion), no Informed parties (creates surprise), forgetting legal/security as Consulted.

### Dependency mapping and the critical path

A **dependency** is when one workstream cannot start or finish until another workstream produces something first.

**Critical path:** the longest chain of dependent tasks in a program. Any delay on the critical path delays the entire program. Tasks *not* on the critical path have **float** (slack) — they can slip without impacting the delivery date.

To find the critical path:
1. List all tasks and their durations
2. Draw a directed graph: each task is a node; edges represent dependencies
3. The longest path through the graph is the critical path

In practice: TPMs use JIRA, Asana, Linear, or Google Sheets for dependency tracking. The tool matters less than the discipline of maintaining it.

### Risk register

A risk register captures identified risks before they become problems. Each entry has:

| Field | Description |
|---|---|
| Risk | What might go wrong |
| Probability | Likelihood (Low / Medium / High or 1–5) |
| Impact | Consequence if it materializes (Low / Medium / High or 1–5) |
| Owner | Who is responsible for monitoring and mitigating |
| Mitigation | What you're doing to reduce probability or impact |
| Contingency | What you'll do if the risk materializes anyway |

**Risk score** = Probability × Impact. Prioritize high-score risks.

A good risk register is updated weekly and reviewed in program standups. The goal is to have no *surprises* — only pre-identified risks materializing.

### OKRs (Objectives and Key Results)

Google uses OKRs at every level from company to individual team. The format:

> **Objective:** An ambitious, qualitative goal that describes where you want to go. It should be memorable and inspiring.
>
> **Key Result (KR):** A measurable outcome that proves you achieved the objective. Should be a metric with a number. 3–5 per objective.

Bad KR: "Improve experiment quality" (not measurable)  
Good KR: "Reduce median time-to-significance for experiments from 14 days to 7 days by Q3"

OKR rhythm at Google:
- Annual company OKRs → quarterly team OKRs → individual contributor OKRs
- Graded at end of quarter: 0.6–0.7 is the target (70% = ambitious goal)
- 1.0 means the goal wasn't ambitious enough; 0.0 means something went wrong

### Driving execution without authority

This is the hardest part of TPM work. You can't order engineers to do things. You drive through:

- **Clarity:** Nobody can ignore a well-framed risk. Write it clearly, name the impact, name the date.
- **Escalation paths:** Know when to escalate and to whom. Escalate early; don't surprise your managers.
- **Status visibility:** Weekly status updates (green/yellow/red) make problems impossible to ignore without active effort.
- **Trust:** Engineers help TPMs who understand the work. The "technical" in TPM is not decorative.

Status color conventions:
- **Green:** On track; no action needed from leadership
- **Yellow:** At risk; action needed within 1–2 weeks to avoid slipping
- **Red:** Blocked or off track; decision or resource needed now

### Program reviews and launch reviews

**Program review (weekly/biweekly):** Standing meeting where each workstream lead gives a 2-minute update. TPM facilitates; decision items are the only things that need group discussion. Status should be pre-read.

**Launch review (before a release):** Formal checklist-based review. At Google this includes: security review, privacy review, legal sign-off, SRE/oncall handoff, launch metrics defined. TPM coordinates all of these happening before the launch date.

---

## Exercises

**Set 1 — RACI matrix (30 min):**
Design a RACI matrix for a hypothetical feature launch involving: a backend engineering team, a data science team, a frontend team, a security reviewer, and a legal/privacy reviewer. The feature: adding experiment data export to the experimentation platform (CSV download of experiment results and PII-stripped user cohorts).
Identify at least 6 deliverables/decisions and fill in the matrix. Where do you have multiple Accountable parties? Fix them.
Save to `docs/reading/RACI-EXERCISE.md`.

**Set 2 — Dependency map (45 min):**
Map the dependencies for shipping the causal forest feature end-to-end. Workstreams:
1. Data pipeline — event ingestion and preprocessing
2. ML training — causal forest model training and validation
3. Serving API — serving the causal forest results via REST API
4. Frontend — HTE results dashboard
5. Explanation layer — LLM-generated plain-English summaries
6. Documentation + launch

Draw the dependency graph (use a table or Mermaid diagram). Identify the critical path. What is the longest dependency chain? What can run in parallel?
Save to `docs/reading/DEPENDENCY-MAP.md`.

**Set 3 — Risk register (30 min):**
Write a risk register for the experimentation platform launch. Identify at least 5 risks across: technical, legal/compliance, timeline, adoption. For each: probability, impact, risk score, owner, mitigation, contingency.
Which 2 risks are your highest priority?
Save to `docs/reading/RISK-REGISTER.md`.

**Set 4 — Program status update (20 min):**
Write a weekly program status update for a fictional program: "Experimentation Platform v1 Launch." Include: overall status (color), one sentence per workstream, top risk, decisions needed from leadership, and next week's focus. Keep it under one page.
Save to `docs/reading/PROGRAM-STATUS-TEMPLATE.md`.

**Set 5 — Write OKRs (30 min):**
Write one Objective with 3 Key Results for the experimentation platform. The objective should be ambitious but not vague. Each KR should have a specific metric and target.
Then write one OKR for *yourself* as a TPM working on this program. What does your success as a TPM look like, measured in numbers?
Save to `docs/reading/OKRS-EXPERIMENTATION-PLATFORM.md`.

---

## Checks — you understand this when you can:
- [ ] Explain what a TPM does differently from a PM and an EM
- [ ] Build a RACI matrix for a 3-team project and explain why multiple Accountable parties is a problem
- [ ] Draw a dependency graph and identify the critical path
- [ ] Write a risk register entry with probability, impact, mitigation, and contingency
- [ ] Write a green/yellow/red program status update in under one page
- [ ] Write an OKR with 3 measurable key results and explain what a 0.7 grade means at Google

---

## Artifacts to commit
- [ ] `docs/reading/RACI-EXERCISE.md`
- [ ] `docs/reading/DEPENDENCY-MAP.md`
- [ ] `docs/reading/RISK-REGISTER.md`
- [ ] `docs/reading/PROGRAM-STATUS-TEMPLATE.md`
- [ ] `docs/reading/OKRS-EXPERIMENTATION-PLATFORM.md`
- [ ] Glossary entries: TPM, RACI, critical path, risk register, OKR, program review, launch review, float (schedule)
- [ ] Log entry in `docs/LOG.md`

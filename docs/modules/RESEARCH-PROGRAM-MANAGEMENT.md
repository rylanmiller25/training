# Module: Research Program Management at AI Labs

**Phase:** 6  
**Slug:** `research-program-management`  
**Status:** not started  

---

## What it is / how to think about it

Research Program Management (RPM) is TPM work applied to AI research organizations. The tools from the `program-management` module apply — RACI, risk registers, OKRs — but the context changes fundamentally. You are no longer managing engineers building to a known spec. You are managing scientists pursuing goals that may be fundamentally unsolvable on any given timeline, and whose outputs are papers and breakthroughs rather than shipped features.

**Mental model:** Software engineering programs are like construction — the blueprint exists, the materials are known, the timeline is estimable. AI research programs are more like expeditions. You know the direction and the destination, but not the terrain or how long it will take. The RPM's job is to keep the expedition moving, surface decisions to leadership when the terrain changes, and translate progress (or lack of progress) into language the organization can act on.

This module is a synthesis module. It assumes you have completed: `program-management`, `technical-communication`, `mlops`, and most of Phase 5. Without that foundation, the context here won't land.

---

## Prerequisites
- `program-management` — the core TPM toolkit
- `technical-communication` — writing for researchers vs engineers vs executives
- `mlops` — understanding the ML lifecycle you'll be managing
- Phases 4–5 completed — you need to understand AI capabilities and limitations to manage AI programs credibly

---

## Best resources

**Primary:**
1. [DeepMind — About / Our work](https://deepmind.google/about/) — read the About, Research, and Impact sections; understand how they position their programs publicly
2. [Gemini Technical Report](https://arxiv.org/abs/2312.11805) — read the Overview (pp. 1–8); this is what a major model program produces; understand what went into coordinating it
3. [Anthropic Model Card — Claude 2](https://www.anthropic.com/index/claude-2-model-card) — an example of safety communication; what gets evaluated and how it's reported
4. [80,000 Hours — AI Safety career guide](https://80000hours.org/problem-profiles/artificial-intelligence/) — why safety is a first-class consideration at top labs, not an afterthought

**Supporting:**
- [On the Opportunities and Risks of Foundation Models — Stanford CRFM](https://arxiv.org/abs/2108.07258) — read the abstract and section 1; the kind of research program a TPM might help coordinate
- [The Alignment Problem — Brian Christian](https://brianchristian.org/the-alignment-problem/) — narrative understanding of what AI safety research is trying to solve
- [Google Research — Publications blog](https://research.google/blog/) — real examples of research communication; what papers look like from the outside
- [DeepMind Safety Research](https://deepmind.google/research/publications/) — scan the publications list; understand what kinds of safety work happen at a top lab

**YouTube:**
- [Inside DeepMind — documentary](https://www.youtube.com/watch?v=rbsqaJwpu6A) (20 min) — organizational culture and how research programs run
- [AI safety and governance at Anthropic — Amanda Askell](https://www.youtube.com/watch?v=3kJNI94XRSI) (45 min) — safety as a research discipline

---

## Core concepts to cover

### How AI research labs are organized

The core organizational units at a lab like DeepMind or Google Brain:

- **Research teams:** groups of researchers working on a shared research problem (language modeling, reinforcement learning, protein structure, safety). Their output is papers, techniques, and models.
- **Product/applied teams:** take research outputs and build them into products (Gemini app, Gemini API, DeepMind for science tools). Their output is deployed systems.
- **Safety teams:** evaluate models before release and research safety techniques. Their output is safety reports, evaluations, and policy recommendations.
- **Infrastructure / ML engineering teams:** build the compute, training, and serving infrastructure that research teams use. Their output is platforms.

Where TPMs sit:
- Embedded in research programs — tracking progress, managing external collaborations, coordinating safety reviews
- On the research-to-product handoff — translating what the research team produced into what the product team needs
- On large cross-functional programs — e.g., a major model release that requires research, safety, policy, product, and engineering alignment

### Managing researchers

Researchers are not engineers. The most common mistake from product-organization TPMs moving to research: treating research milestones like feature milestones.

Key differences:

| Dimension | Engineering team | Research team |
|---|---|---|
| Success metric | Shipped feature, uptime, latency | Paper published, technique discovered, capability demonstrated |
| Timeline predictability | High — known specifications | Low — fundamental uncertainty |
| Motivation | Ship quality product, career growth | Intellectual contribution, publication credit, reputation in the research community |
| Feedback cycle | Deploy → observe → iterate (days/weeks) | Experiment → fail → rethink (weeks/months) |
| "Done" definition | Spec fully implemented | Often unclear until a breakthrough occurs |

How to work with researchers effectively:
- **Earn technical credibility.** Researchers will not respect a TPM who can't engage with the substance of their work. You don't need to be a researcher, but you need to understand what they're doing well enough to ask good questions.
- **Protect research time.** Process overhead (status meetings, OKR grading, cross-team reviews) is especially costly for researchers. Be ruthless about which process actually needs their time.
- **Separate research pace from communication pace.** Research may be slow; communication to leadership still needs to happen weekly. The TPM's job is to represent the research in progress accurately — including representing "we don't know yet" as a legitimate state.

### Research program structure

Research programs differ from product programs in milestone design:

**Bad research milestone:** "Complete causal inference research" (not verifiable)
**Better research milestone:** "Validate that the causal forest approach outperforms DML on the synthetic benchmark by the end of Q2" (specific, binary, verifiable)

Research programs often use **exploration gates**:
- End of exploration: "We have validated that X approach is worth investing in" — go/no-go to commit resources
- End of development: "We have a working prototype that achieves Y performance on Z benchmark"
- End of evaluation: "External reviewers confirm the technique generalizes beyond our benchmark"

These gates replace feature-style milestones. They acknowledge uncertainty while still creating accountability and decision points.

### The publication process

Research at AI labs is published via academic conferences and journals. The lifecycle:

1. **Research** — run experiments, get results, write the paper
2. **Internal review** — peers at the lab review for technical accuracy, novelty, and writing quality
3. **Safety review** — safety team evaluates dual-use risk: could this paper enable harmful applications? What information should be omitted?
4. **Legal/IP review** — does the paper reveal proprietary techniques? Is this information the organization wants to publish or protect?
5. **Submission** — submit to a conference (NeurIPS, ICML, ICLR, EMNLP, etc.) or journal; double-blind peer review
6. **Revision** — revise based on reviewer feedback; resubmit if rejected

Publication timelines: major ML conferences have 6-month cycles from submission deadline to publication. This creates a predictable but inflexible schedule that TPMs must plan around.

**Open source strategy:** some labs publish everything (Meta), some publish selectively (DeepMind publishes techniques, not model weights), some are more closed (OpenAI has moved toward less publication over time). The strategy reflects the organization's view on competitive advantage and safety obligations.

### Safety evaluation before model release

Before a major model release at a safety-conscious lab (DeepMind, Anthropic, OpenAI), several evaluations happen:

- **Capability evaluation:** what can the model do? What new capabilities does it have vs previous versions? (Benchmarks: MMLU, HumanEval, MATH, etc.)
- **Safety evaluation:** what harmful outputs can the model produce? How does it respond to adversarial prompts? What are the residual risks?
- **Red-teaming:** both internal and external teams attempt to elicit harmful behavior
- **Third-party audit:** some labs bring in external auditors (UK AISI, METR, etc.)
- **Policy review:** legal and policy teams evaluate regulatory obligations and voluntary commitments

The output is a **model card** or **safety report** — a public document describing what was evaluated, what was found, and what the residual risks are. (See the Anthropic Claude model card as an example.)

A TPM at this level helps coordinate: who does each evaluation, by when, what the go/no-go criteria are, and who makes the final call.

### Communicating research progress to leadership

The hardest communication challenge in research RPM: telling leadership that progress is slow without creating panic or inappropriate pressure.

Principles:
- **Represent uncertainty accurately.** "We don't know yet" is a legitimate state. Do not translate it into false confidence for leadership.
- **Lead with what you know and what you're doing.** "We've ruled out approach A. We're now testing approach B. We expect to know by end of month."
- **Frame negative results as valuable.** In research, learning that something doesn't work is progress. Help leadership understand this — "we've eliminated a dead end" is a meaningful update.
- **Separate exploration phase from delivery phase.** Don't hold exploration milestones to delivery-phase standards.

### Cross-team alignment: research to product

The handoff from research to product is reliably the hardest part of AI lab operations. Sources of friction:

- Research models are not production-ready by default (no serving infrastructure, no error handling, no latency requirements)
- Product teams want guarantees the research team cannot give ("will this accuracy hold on live traffic?")
- Research teams feel ownership over the work and resist changes made for engineering pragmatism
- Safety teams may impose constraints neither research nor product teams expected

A TPM managing this handoff should:
1. Get alignment on handoff criteria before development begins ("what does 'handed off' mean?")
2. Embed a product engineer in the research team during the final research phase (they see the work in progress, not a finished artifact)
3. Write a clear handoff doc: what the model does, what it doesn't do, what the known failure modes are, what the safety sign-offs cover
4. Define ownership explicitly: after handoff, who owns retraining? Who owns serving reliability?

---

## Exercises

**Set 1 — Map an AI lab's organization (45 min):**
Choose either DeepMind or Anthropic. Using public information (their website, job postings, research publications, blog posts), map:
- What are the major research teams / divisions?
- How does the safety team relate to the research teams?
- Where would a TPM sit in the organization?
- What programs would a TPM in this lab likely run?
Be honest about what you don't know. Save to `docs/reading/AI-LAB-ORG-MAP.md`.

**Set 2 — Design research program milestones (45 min):**
Design a milestone structure for a 3-phase research program: "Developing and validating the causal forest HTE engine for the experimentation platform."

For each phase, write:
- Duration
- The specific question the phase is trying to answer
- The verifiable gate criterion (what does "done" look like?)
- Who makes the go/no-go decision?
- What happens if the criterion isn't met?

Save to `docs/reading/RESEARCH-PROGRAM-MILESTONES.md`.

**Set 3 — Write a research brief for non-technical leadership (45 min):**
Write a 1-page brief explaining what causal forests are and why the experimentation platform uses them — without jargon — for a fictitious VP of Product who is technically literate but not an ML practitioner. They need to understand: what problem it solves, why we chose it over simpler approaches, and what the risks are if our causal forest estimates are wrong.
Apply BLUF. Use the Pyramid Principle. Do not explain math.
Save to `docs/reading/RESEARCH-BRIEF-EXERCISE.md`.

**Set 4 — Analyze a safety report (30 min):**
Read either:
- [Anthropic Claude 2 Model Card](https://www.anthropic.com/index/claude-2-model-card), or
- A safety section from the [Gemini Technical Report](https://arxiv.org/abs/2312.11805) (Section 5)

Write: what did they evaluate, how, and who was involved? What is the model explicitly *not* evaluated on? What residual risks are acknowledged? What would a TPM need to coordinate to produce this document?
Save to `docs/reading/SAFETY-REPORT-ANALYSIS.md`.

**Set 5 — Research-to-product handoff (30 min):**
Identify 3 specific coordination challenges that arise when the experimentation platform's causal forest research prototype transitions to the product engineering team. For each challenge:
- What is the friction?
- Who is on each side of the friction?
- What would a TPM do to resolve it before work begins?

Save to `docs/reading/RESEARCH-TO-PRODUCT-HANDOFF.md`.

---

## Checks — you understand this when you can:
- [ ] Explain how an AI research lab is structured and where a TPM operates
- [ ] Articulate why managing researchers differs from managing product engineers (3 specific differences)
- [ ] Design milestone structure for a research program using exploration gates rather than feature milestones
- [ ] Explain what happens during safety evaluation before a major model release
- [ ] Write a 1-page research brief for a non-technical executive, applying BLUF and the Pyramid Principle
- [ ] Identify the 3 most common friction points in a research-to-product handoff and explain how a TPM addresses each

---

## Artifacts to commit
- [ ] `docs/reading/AI-LAB-ORG-MAP.md`
- [ ] `docs/reading/RESEARCH-PROGRAM-MILESTONES.md`
- [ ] `docs/reading/RESEARCH-BRIEF-EXERCISE.md`
- [ ] `docs/reading/SAFETY-REPORT-ANALYSIS.md`
- [ ] `docs/reading/RESEARCH-TO-PRODUCT-HANDOFF.md`
- [ ] Glossary entries: research program management, exploration gate, model card, safety evaluation, red-teaming (organizational), research-to-product handoff, dual-use risk
- [ ] Log entry in `docs/LOG.md`

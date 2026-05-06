# Module: Technical Communication at Scale

**Phase:** 3  
**Slug:** `technical-communication`  
**Status:** not started  

---

## What it is / how to think about it

At small startups, communication is informal — Slack, a shared doc, a quick call. At large engineering organizations (Google, DeepMind, Meta), communication is formalized precisely because there are too many people, too many ongoing projects, and too many decisions in flight for informal methods to scale.

**Mental model:** Think of technical communication at scale like a series of translation layers. A complex technical reality needs to be translated into a precise engineering spec for the team building it, a concise design document for the team reviewing it, and a crisp 1-pager for the leadership team approving it. The same underlying truth — but rendered differently for each audience.

Google has a strong design doc culture. Before major technical decisions are made, someone writes a doc. That doc is the record of the decision: what was considered, what was rejected, and why. Knowing how to write — and how to read — these documents fluently is a core TPM skill.

---

## Prerequisites
- `prds` — you need to know what a PRD is before you can understand how it differs from a design doc
- `program-management` — program status updates are a form of technical communication; this module builds on that

---

## Best resources

**Primary:**
1. [Design Docs at Google — Malte Ubl](https://www.industrialempathy.com/posts/design-docs-at-google/) — the best public explanation of how Google actually uses design docs
2. [How to Write a Good Software Design Doc — Medium](https://medium.com/machine-words/writing-technical-design-docs-71f446e42173) — practical format guide
3. [BLUF: The Military Standard for Clear Communication — Animalz](https://www.animalz.co/blog/bottom-line-up-front/) — bottom-line-up-front; the foundation of executive communication

**Supporting:**
- [The Pyramid Principle — Barbara Minto](https://www.amazon.com/Pyramid-Principle-Logic-Writing-Thinking/dp/0273710516) — the framework behind structured executive communication (McKinsey consulting standard)
- [Google's technical writing guide](https://developers.google.com/tech-writing/overview) — free, online, practical
- [An Elegant Puzzle, chapter on "Staying aligned with authority" — Will Larson](https://lethain.com/elegant-puzzle/) — how to communicate with leadership when you don't control the narrative

**YouTube:**
- [Technical Writing at Google — Google Tech Talks](https://www.youtube.com/watch?v=YHbzaVkbJbw) (1 hr — Google's own technical writing course, condensed)
- [The Pyramid Principle explained](https://www.youtube.com/watch?v=_7_N5CDl7P8) (12 min)

---

## Core concepts to cover

### The document type landscape

Different documents serve different purposes. Confusing the type wastes the reader's time:

| Document type | Purpose | Primary reader | Length |
|---|---|---|---|
| PRD | What to build and why | Product, eng, leadership | 2–10 pages |
| Design doc | How we'll build it technically | Engineers reviewing the design | 3–15 pages |
| Tech spec | Step-by-step implementation details | Engineers building it | As needed |
| Decision doc | Record of a decision made | Future team, auditors | 1–2 pages |
| Program status | Current state of a running program | Leadership, stakeholders | 1 page |
| Executive 1-pager | Brief summary of a situation + recommendation | VP, director-level | 1 page |

A PRD answers: "Should we build this?" A design doc answers: "How will we build this?" A tech spec answers: "What exactly will I write?" They are additive — a complex feature might have all three.

### Google design doc format

Google design docs follow a loose but recognizable structure:

1. **Context / background** — What is the situation? Why are we here? One paragraph.
2. **Goals** — What outcomes does this design achieve? Measurable where possible.
3. **Non-goals** — What is explicitly out of scope? This prevents scope creep and sets expectations.
4. **Overview / proposed design** — The high-level description. Start here before diving into details. Include a diagram if the system is complex.
5. **Detailed design** — The specifics: APIs, data models, algorithms, error handling. Goes deep enough that engineers can implement from this section.
6. **Alternatives considered** — What else did you consider? Why did you reject it? This is the most important section for demonstrating rigor. A doc with no alternatives looks like no tradeoff analysis was done.
7. **Open questions** — What is still unresolved? Who decides? By when?
8. **Appendix** — Prototypes, data, supporting analysis.

The critical section is **Alternatives considered.** It signals that the author thought about the problem seriously, not just wrote down the first solution they thought of.

### BLUF — bottom line up front

Military and intelligence writing (and increasingly tech executive writing) leads with the conclusion:

> **BLUF:** Recommendation is X. Action needed: Y by Z.

Traditional academic and narrative writing builds to the conclusion. Executive communication inverts this — the reader may stop reading at any moment, so the most important information comes first.

Applied to a program status update:
- **Lead with the status color and the decision needed** ("Status: YELLOW. Decision needed by Friday on whether to delay the launch 2 weeks or cut scope.")
- **Then give context** ("The ML training workstream is blocked on data pipeline access...")
- **Then give detail** (timeline, risk, alternatives)

### The Pyramid Principle (structured executive writing)

Barbara Minto's Pyramid Principle:
- **Start with the governing thought** — the main recommendation or conclusion
- **Support with key arguments** (3 is ideal) — each key argument should be distinct and collectively exhaustive
- **Support each argument with evidence or sub-arguments**

In practice:
```
Recommendation: Delay the launch by 2 weeks
├── The ML model accuracy is below the launch threshold (evidence: eval scores)
├── Pushing with lower accuracy creates product credibility risk (argument)
└── 2 weeks allows full retraining with the new dataset (evidence: ML team estimate)
```

This structure makes documents skimmable. A reader can read just the top level and understand the recommendation, or drill into any branch for detail.

### Technical writing for engineers vs leadership

The same content needs different rendering for different audiences:

**For engineers:** Precision and specificity. Technical vocabulary is assumed. Include data types, error codes, edge cases. Omitting detail is worse than overexplaining.

**For engineering managers:** Frame in terms of team coordination, timelines, and risk. They trust you know the technical details; what they need is: what does this mean for our roadmap and our team?

**For VPs / directors:** Frame in terms of outcomes, risks, and decisions. They are not reading for technical understanding. They're reading for: do I need to do anything? Is there a risk I'm not aware of?

A common mistake: writing a document that's technically complete but not actionable for its intended reader. If the reader finishes and doesn't know what to do next, the document failed.

### Decision docs and "disagree and commit"

When a team makes a significant technical decision — especially a contentious one — a **decision doc** records:

1. The decision made
2. What alternatives were considered
3. Who was involved
4. The rationale for the chosen path
5. What signals would cause us to revisit this decision

"Disagree and commit" is Amazon's / Google's phrase for the expected behavior after a decision is made: even if you argued against it, you commit fully once the decision is finalized. A decision doc makes it clear that the disagreement was heard and documented — you don't re-litigate every meeting.

### Writing for AI research organizations

At AI labs (DeepMind, Anthropic, Google Brain), technical communication has additional considerations:

- **Research progress docs** are looser than product design docs — uncertainty is expected, negative results are valuable
- **Safety communication** requires extra precision: what exactly was evaluated, what was not evaluated, what the residual risks are
- **Publication prep** involves internal review (accuracy), legal review (IP), and safety review (dual use) before external publication
- **Lab-to-product handoff docs** are often the most painful to write: translating "this works in research conditions" into "here is what needs to be true for production"

---

## Exercises

**Set 1 — Write a design doc (90 min):**
Write a Google-style design doc for one component of the experimentation platform: the **event ingestion pipeline** (the system that receives experiment events from the SDK and stores them). Use the 7-section format above.
Include: what triggers an event, how events flow through the system, the data model, failure handling, and at least 2 alternatives considered (e.g., Kafka vs direct write to Postgres).
Save to `docs/reading/DESIGN-DOC-EXERCISE.md`.

**Set 2 — Write an executive 1-pager (30 min):**
Write a BLUF-style executive 1-pager for the following scenario:
> *You are a TPM at an AI startup. The ML team has discovered that the causal forest model performs poorly for customer segments with fewer than 500 events. This affects 40% of current customers. The ML team proposes a 6-week retraining project. You need to get VP approval to delay the Q3 launch.*

Use the Pyramid Principle. Lead with the recommendation. Keep it to 1 page.
Save to `docs/reading/EXEC-BRIEFING-EXERCISE.md`.

**Set 3 — Write a decision doc (30 min):**
Write a decision doc for a real technical decision in the experimentation platform: **choosing between PostgreSQL (relational) and ClickHouse (columnar analytics DB) for storing experiment events.**
Document both options, who would be consulted, the decision made, and what would cause you to revisit it.
Save to `docs/reading/DECISION-DOC-EXERCISE.md`.

**Set 4 — Translate a technical doc for a different audience (30 min):**
Take the design doc you wrote in Set 1. Write a 1-paragraph version of it for:
a) An engineering manager who needs to understand timeline and team impact
b) A VP who needs to understand the business risk if this component isn't built right
Append both to `docs/reading/DESIGN-DOC-EXERCISE.md`.

---

## Checks — you understand this when you can:
- [ ] Explain the difference between a PRD, a design doc, a tech spec, and a decision doc
- [ ] Write a design doc with all 7 sections, including at least 2 alternatives considered
- [ ] Write a BLUF executive update in under 1 page that leads with the recommendation
- [ ] Explain the Pyramid Principle in one sentence and apply it to a real writing task
- [ ] Explain what "disagree and commit" means and how a decision doc supports it
- [ ] Translate the same technical content for an engineering audience vs a VP audience

---

## Artifacts to commit
- [ ] `docs/reading/DESIGN-DOC-EXERCISE.md`
- [ ] `docs/reading/EXEC-BRIEFING-EXERCISE.md`
- [ ] `docs/reading/DECISION-DOC-EXERCISE.md`
- [ ] Glossary entries: design doc, BLUF, Pyramid Principle, decision doc, tech spec, disagree and commit
- [ ] Log entry in `docs/LOG.md`

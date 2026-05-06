# Module: HITL Design (Human-in-the-Loop)

**Phase:** 5  
**Slug:** `hitl`  
**Status:** not started  

---

## What it is / how to think about it

Human-in-the-Loop (HITL) design places humans at strategic checkpoints in AI workflows to review, correct, or approve model outputs before they have real-world effect. It's the primary mechanism for catching AI failures before they cause harm.

**Mental model:** Think of it like a junior analyst presenting work to a manager before it goes to the client. The analyst does the heavy lifting; the manager catches errors and maintains accountability. You design *where* the review happens, *who* does it, and *how* feedback improves the system.

---

## Prerequisites
- LLM Failures, LLM Eval modules

---

## Best resources

**Primary:**
1. [Guidelines for Human-AI Interaction – Microsoft Research](https://www.microsoft.com/en-us/research/project/guidelines-for-human-ai-interaction/) — 18 design principles with examples
2. [People + AI Guidebook – Google PAIR](https://pair.withgoogle.com/guidebook/) — practical design patterns for AI products

**Supporting:**
- [Scalable Oversight – Anthropic](https://arxiv.org/abs/2211.03540) — longer-term view on human oversight as models get more capable
- [AI Incident Database](https://incidentdatabase.ai/) — real-world AI failures; identify which HITL checkpoint would have caught each

**YouTube:**
- [Human-in-the-loop AI – MIT lecture](https://www.youtube.com/watch?v=VR8Oc4VlLQ4) (45 min)

---

## Core concepts

### Why HITL
- Models fail in predictable and unpredictable ways
- Some failures have high stakes (medical, legal, financial, safety-critical)
- Human review catches errors; human feedback improves the system over time
- Regulatory and ethical requirements in many domains

### Where to place review gates
- **Pre-action:** human approves before AI takes an action (highest safety; lowest automation benefit)
- **Post-action with rollback:** AI acts; human can reverse within a window
- **Spot-check sampling:** review N% of outputs; catch systemic issues, not every error
- **Exception-based:** AI flags low-confidence or high-risk outputs for human review; rest auto-approve

### Designing review interfaces
- Show the model's reasoning, not just its output (transparency builds appropriate trust)
- Show confidence scores; don't hide uncertainty
- Make the correct action obvious (one-click approve/reject/edit)
- Capture structured feedback (category of error, not just "wrong")
- Minimize cognitive load — reviewers see thousands; each decision must be fast

### Feedback loops
- Reviewed outputs → labeled training data → fine-tuning or eval improvement
- Track reviewer agreement rate — low agreement means the task is ambiguous
- Track correction patterns — systematic corrections indicate a prompt or model issue

### Calibrating automation level
- **Never automate:** high-stakes, low-volume, novel situations (e.g. medical diagnosis, legal filings)
- **Automate with sampling:** well-understood, high-volume, reversible (e.g. content tagging)
- **Fully automate:** repetitive, low-stakes, easily reversible (e.g. formatting, spell check)
- Framework: (probability of error) × (cost of error) → proportionate review intensity

### Workforce considerations
- Review queues must be staffed; don't design HITL without planning the human capacity
- Reviewer burnout: tedious review work degrades quality over time
- Reviewer calibration: different reviewers → inconsistent labels (track inter-annotator agreement)

---

## Exercises

**Set 1 — Design a HITL workflow (45 min):**
Choose a real AI use case (e.g. auto-responding to customer support emails, generating legal document summaries, triaging medical records).
Design the full HITL workflow:
- Where are the review gates?
- What does the reviewer see?
- What actions can they take?
- How does feedback flow back into improvement?
- What's the target human review rate?
Save to `docs/projects/HITL-WORKFLOW-DESIGN.md`.

**Set 2 — Analyze an AI failure (30 min):**
Go to [AI Incident Database](https://incidentdatabase.ai/) and find a real incident.
- What was the AI doing?
- What went wrong?
- At what point in the workflow would a HITL gate have caught it?
- What review interface would have made the catch practical at scale?
Save to `docs/reading/HITL-INCIDENT-ANALYSIS.md`.

**Set 3 — Review interface critique (20 min):**
Find a screenshot or demo of an AI-assisted review tool (GitHub Copilot, Gmail Smart Reply, Grammarly, etc.).
Evaluate using Microsoft's 18 HITL principles:
- Does it explain why it made its suggestion?
- Does it show confidence?
- Is it easy to dismiss/accept?
- Does it learn from corrections?
Save to `docs/reading/HITL-INTERFACE-CRITIQUE.md`.

---

## HITL in practice: OpenClaw and Keystroke
Two tools in this curriculum give you concrete HITL design surfaces:
- **OpenClaw** (`openclaw` module): a local autonomous agent with real system access. The HITL exercise in that module asks you to design confirmation gates for specific skill categories — apply what you learned here.
- **Keystroke** (`keystroke` module): its execution model supports pausing a workflow pending human approval. Build a Keystroke workflow with a HITL gate: if the AI output confidence is below a threshold, create a Linear ticket and wait for approval before proceeding.

---

## Checks — you understand this when you can:
- [ ] Explain 4 placement strategies for human review gates and when to use each
- [ ] Design a review interface for a high-volume AI output workflow
- [ ] Explain how to calibrate how much to automate vs review
- [ ] Explain how human feedback flows back into model improvement
- [ ] Identify which type of HITL gate would catch a specific failure mode

---

## Artifacts to commit
- [ ] `docs/projects/HITL-WORKFLOW-DESIGN.md`
- [ ] `docs/reading/HITL-INCIDENT-ANALYSIS.md`
- [ ] `docs/reading/HITL-INTERFACE-CRITIQUE.md`
- [ ] Glossary entries: HITL, review gate, spot-check, inter-annotator agreement, feedback loop
- [ ] Log entry in `docs/LOG.md`

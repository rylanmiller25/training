# Module: HCI + AI Research Areas

**Phase:** 6 (Weeks 47–52)  
**Slug:** `hci-research`  
**Status:** not started  
**Estimated time:** 6–8 hours

---

## What it is / how to think about it

Human-Computer Interaction (HCI) research studies how people use and experience technology — and increasingly, how they interact with AI systems. This module covers the research areas most relevant to Rylan's interest in building at the intersection of AI, social computing, XR, and intelligent interfaces.

**Mental model:** HCI is the discipline that keeps AI grounded in human reality. It asks: not just "can the system do this?" but "do people actually benefit, trust, and use it well?" Good HCI research informs product design with evidence, not assumption.

---

## Prerequisites
- HITL module; LLM Failures module (for trust calibration context)

---

## Best resources

**Primary:**
1. [ACM CHI conference proceedings](https://dl.acm.org/conference/chi) — the top venue for HCI research; many papers are open access
2. [ACM CSCW proceedings](https://dl.acm.org/conference/cscw) — social computing and computer-supported cooperative work

**Supporting:**
- [Anthropic's alignment research](https://www.anthropic.com/research) — interpretability + trust + human-AI interaction
- [Stanford HAI](https://hai.stanford.edu/research) — interdisciplinary human-centered AI research
- [MIT Media Lab](https://www.media.mit.edu/research/) — speculative and applied HCI

**YouTube:**
- [HCI research overview – Scott Klemmer (Coursera)](https://www.youtube.com/playlist?list=PLLssT5z_DsK_nusHL_Mjt87THSTlgrsyJ) (free HCI design course)
- [Trust in AI systems – Stanford HAI panel](https://www.youtube.com/watch?v=cFWRaL-FAts) (30 min)

---

## Research areas

### Social computing
- How technology mediates social interaction, community formation, and collective intelligence
- Key topics: online communities, moderation, platform effects, reputation systems, crowdsourcing
- AI angle: how does AI change social dynamics? (misinformation, deepfakes, AI personas, parasocial AI relationships)
- Key papers to know: "No Silver Bullet" (Brooks), GroupLens (collaborative filtering origin), Wikipedia research

### Extended Reality (XR) — VR, AR, MR
- **VR:** fully immersive; replaces real world; presence and embodiment research
- **AR:** overlays digital on physical; spatial computing; context-aware interfaces
- **MR:** physical + digital interact dynamically
- Key questions: presence and embodiment, spatial interaction design, discomfort and motion sickness, social presence, privacy in always-on cameras
- AI in XR: scene understanding, natural language spatial interfaces, AI avatars, real-time 3D generation

### Mobile + Ubiquitous Computing
- Computing embedded in everyday objects and environments (IoT, smart homes, wearables)
- Context-aware computing: systems that adapt to user location, activity, social context
- Key design challenges: interruption management, attention economy, ambient display, glanceable interfaces
- AI angle: on-device models, continuous sensing, predictive action, privacy tradeoffs of always-listening

### Predictive + Intelligent UIs
- Interfaces that anticipate user intent and adapt proactively
- **Autocomplete / next-word prediction:** keyboards, IDEs, command palettes
- **Proactive recommendations:** surface information before user asks
- **Adaptive interfaces:** change layout/features based on user behavior and context
- Key tension: helpfulness vs intrusiveness; automation bias vs appropriate reliance

### Trust calibration in human-AI interaction
- Users often overtrust or undertrust AI systems
- **Overtrust:** accept AI outputs without critical evaluation; automation complacency
- **Undertrust:** reject useful AI assistance; unnecessary friction
- Calibrated trust: user's trust reflects actual system reliability
- Design interventions: uncertainty communication, explanation, confidence indicators, failure disclosure
- Research: "appropriate reliance," "mental models of AI," "explainable AI" (XAI)

### Key HCI research methods
- **Usability studies:** observe users completing tasks; measure completion rate, errors, time
- **A/B testing:** compare two interface variants on behavioral metrics
- **Diary studies:** participants record experiences in context over time
- **Surveys + interviews:** self-reported attitudes and mental models
- **Log analysis:** behavioral signals from product data (clicks, time, paths)
- **Think-aloud protocol:** user verbalizes thoughts while using a system

---

## Exercises

**Set 1 — Survey a research area (45 min):**
Choose one: social computing, XR, or predictive UIs.
Find 3 recent (2022–2025) CHI or CSCW papers in that area.
For each: what was the research question? What did they find? What was the implication for product design?
Save to `docs/reading/hci-literature-survey.md`.

**Set 2 — Trust calibration analysis (30 min):**
Think of 3 AI features you've used (autocomplete, recommendations, search, customer support bot).
For each:
- Did you overtrust, undertrust, or appropriately trust it?
- What interface design signals led to that calibration?
- What would you change to improve trust calibration?
Save to `docs/reading/trust-calibration-analysis.md`.

**Set 3 — Design an intelligent UI (45 min):**
Design a predictive interface for one scenario:
- A calendar assistant that proactively suggests meeting prep (document review, travel time)
- A coding assistant that notices you're stuck and offers to explain the error
- An email assistant that drafts responses based on your typical replies
Specify: what signals does it use? What does it show proactively? How does the user control it? How do you avoid intrusiveness?
Save to `docs/projects/intelligent-ui-design.md`.

**Set 4 — Research agenda (30 min):**
Write a 1-page research agenda: if you were a PhD student or researcher, what would you investigate?
Pick one intersection (e.g. "AI trust calibration in XR environments" or "social norms in human-AI co-creation").
Frame: what's the open question? Why does it matter? What method would you use to study it?
Save to `docs/reading/research-agenda.md`.

---

## Checks — you understand this when you can:
- [ ] Describe what social computing research studies and name 2 key topics
- [ ] Explain the key design challenges in AR vs VR interfaces
- [ ] Explain what trust calibration is and why overtrust is as dangerous as undertrust
- [ ] Design an intelligent interface with explicit signals, controls, and trust mechanisms
- [ ] Explain 3 HCI research methods and when to use each

---

## Artifacts to commit
- [ ] `docs/reading/hci-literature-survey.md`
- [ ] `docs/reading/trust-calibration-analysis.md`
- [ ] `docs/projects/intelligent-ui-design.md`
- [ ] `docs/reading/research-agenda.md`
- [ ] Glossary entries: HCI, social computing, XR, ubiquitous computing, trust calibration, explainable AI, automation bias
- [ ] Log entry in `docs/log.md`

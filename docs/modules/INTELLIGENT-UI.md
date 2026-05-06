# Module: Predictive + Intelligent UI

**Phase:** 5  
**Slug:** `intelligent-ui`  
**Status:** not started  

---

## What it is / how to think about it

Intelligent UI is the practice of building interfaces that use AI/ML to predict user intent, reduce friction, and adapt to context — so the interface becomes progressively more useful as it learns. The model acts behind the UI, not beside it.

**Mental model:** A traditional UI waits for the user to act. An intelligent UI anticipates what the user is about to do and either pre-computes it (ghost text, suggestions) or restructures itself to make the likely next action easier (adaptive layout, contextual shortcuts). The model's job is to collapse the distance between user intent and interface response.

---

## Prerequisites
- Prompt Engineering, HITL, LLM Eval modules
- Embeddings module (Phase 4) — for intent modeling

---

## Best resources

**Primary:**
1. [People + AI Guidebook — Google PAIR](https://pair.withgoogle.com/guidebook/) — design patterns for AI-powered UIs; the practical reference for this module
2. [GitHub Copilot design blog posts](https://github.blog/tag/github-copilot/) — the most influential intelligent UI case study; read the design decisions behind ghost text

**Supporting:**
- [Microsoft HAX Toolkit](https://www.microsoft.com/en-us/haxtoolkit/) — human-AI experience guidelines including predictive features
- [Aria — Figma plugin AI design patterns](https://www.figma.com/blog/how-we-think-about-ai-design-patterns/) — how Figma thinks about AI in their own product
- [UI Patterns for AI — UX Collective](https://uxdesign.cc/ai-ux-patterns) — practical pattern library

**YouTube:**
- [AI UX Design Patterns — Google I/O talk](https://www.youtube.com/watch?v=6B7cpDdv5xQ) (35 min)
- [How Copilot works — GitHub Engineering](https://www.youtube.com/watch?v=suoqFDlAaes) (25 min)

---

## Core concepts

### The spectrum of AI in UI
```
Fully manual ←────────────────────────────────────────────→ Fully autonomous
  User does   |  Suggestions  |  Adaptive   |  Predictive  |  AI acts
  everything  |  (accept/reject)  |  (reorders UI)  |  (pre-fills)  |  on behalf
```

Each point on the spectrum has appropriate use cases. The choice depends on: stakes (how bad is a wrong prediction?), reversibility (can the user easily undo?), and model confidence (do you actually know what they want?).

### Ghost text / predictive text
- Model predicts what the user is about to type; shows it in gray; Tab to accept
- Copilot's ghost text is the canonical example: the model sees context → infers intent → completes
- Design challenges: latency (feels slow if >100ms), false positives (distracting), streaming (partial completions feel alive)
- Key principle: suggestions must be easy to ignore. If rejecting is harder than accepting, users feel pestered

### Intent modeling
- Infer what the user is trying to accomplish from: current input, recent history, document context, user profile, similar users' patterns
- Not always ML — simple heuristics (user always does X after Y) beat overfit models at low data volumes
- Intent signals: cursor position, dwell time, edit distance from default, repeated actions

### Adaptive interfaces
- UI layout, options, or content shifts based on predicted usage patterns
- Examples: surfacing frequently used tools, hiding rarely used ones, reordering a list by predicted relevance
- Risk: confuses users when things move; best practice is to never move elements that users explicitly placed

### Contextual suggestions
- System-initiated recommendations at moments of high intent
- Triggers: document type, cursor context, recent errors, time of day, collaboration context
- Must be dismissible in one gesture and not block the primary task

### Streaming and perceived latency
- Users tolerate latency better when something appears to be happening (streaming tokens, progress animation)
- TTFT (time to first token) matters more than total time for perceived responsiveness
- Partial completions that appear progressively feel faster than complete completions that appear all at once

### Error states in predictive UI
- When the model is confidently wrong, ghost text or suggestions are actively harmful
- Calibrate: don't surface suggestions below a confidence threshold
- Graceful degradation: if model is unavailable, fall back to no suggestions (not broken-looking empty states)

### Signaling AI in the interface
- Users should always know when content is AI-generated vs human-created
- Use consistent visual language: icon, color, label — across all AI-generated surfaces
- "AI might be wrong" is not a sufficient disclosure; design for correction, not just disclosure

### Personalization and privacy
- Adaptive UI improves with data — but logging user behavior raises privacy concerns
- Best practice: be explicit about what is stored, give users control, use on-device inference where possible
- Dark pattern: a UI that "adapts" in ways that serve the product over the user (e.g., surfacing high-margin items)

---

## Exercises

**Set 1 — Critique an intelligent UI (30 min):**
Pick one: GitHub Copilot, Gmail Smart Compose, Notion AI, Grammarly, or VS Code IntelliSense.
Evaluate:
- Where on the manual ↔ autonomous spectrum does it sit?
- How does it signal AI involvement?
- How easy is it to reject or correct suggestions?
- Where does it fail or annoy? What's the root cause?
- What would you change in the design?
Save to `docs/reading/INTELLIGENT-UI-CRITIQUE.md`.

**Set 2 — Design a predictive feature (45 min):**
Design a ghost text / predictive completion feature for one of:
- A search box in a data dashboard
- A form field (address, product name, tags)
- A text editor for a specific domain (legal, medical, code)

Design doc should cover: when to trigger, what model input to use, how to display the suggestion, how to handle latency, what to do when wrong.
Save to `docs/reading/PREDICTIVE-FEATURE-DESIGN.md`.

**Set 3 — Implement a simple predictive input (60 min):**
Build a TypeScript component: a text input that calls an LLM API as the user types (debounced at 300ms) and shows a ghost text completion. Requirements:
- Debounce: don't call the API on every keystroke
- Tab to accept, Escape to dismiss
- Show a subtle loading state while waiting
- Handle errors silently (don't break the input)

Save to `docs/projects/INTELLIGENT-UI-DEMO/`.

**Set 4 — Platform intelligent UI design (45 min):**
Design the intelligent UI layer for the experimentation platform's results dashboard:
- What should auto-suggest based on the experiment type?
- How could the UI adapt based on whether the user is technical or non-technical?
- Where would predictive text help in the experiment setup flow?
- How would you signal AI-generated explanations vs. raw data?

This feeds directly into the platform artifact. Save to `docs/projects/experimentation_platform/INTELLIGENT-UI-DESIGN.md`.

---

## Checks — you understand this when you can:
- [ ] Explain the manual ↔ autonomous spectrum and give an example at each end
- [ ] Describe what ghost text is and the 3 key design constraints on it
- [ ] Explain what intent modeling is and name 3 types of intent signals
- [ ] Identify 2 privacy risks in adaptive/personalized UI and how to mitigate them
- [ ] Critique any AI-powered UI using the PAIR guidelines as a framework

---

## Artifacts to commit
- [ ] `docs/reading/INTELLIGENT-UI-CRITIQUE.md`
- [ ] `docs/reading/PREDICTIVE-FEATURE-DESIGN.md`
- [ ] `docs/projects/INTELLIGENT-UI-DEMO/`
- [ ] `docs/projects/experimentation_platform/INTELLIGENT-UI-DESIGN.md`
- [ ] Glossary entries: ghost text, intent modeling, adaptive interface, TTFT, predictive UI, AI affordance
- [ ] Log entry in `docs/LOG.md`

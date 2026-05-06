# Phase 4 Plan: AI Foundations

**Goal:** Build intuition for how language models actually work — their capabilities, their limits, and why they behave the way they do. This phase is about understanding, not building. The building comes in Phase 5.

**Modules:**
1. `transformers` — the architecture underlying everything
2. `embeddings` — how meaning becomes math
3. `ml-eval` — how to measure if a model works
4. `llm-eval` — the harder version of that problem for language models
5. `rl-rlhf` — how models get aligned to human preferences
6. `inference-opt` — how model serving actually works at scale
7. `llm-failures` — the failure modes you'll actually encounter

The first module (`transformers`) is a hard prerequisite for everything else. After that, the remaining six can be done in almost any order, though the suggested sequence above works well.

---

## Module-by-module approach

### transformers
**Start here. Everything else depends on this mental model.**

1. Read the Jay Alammar "Illustrated Transformer" first — it's the best visual explanation that exists. Don't skip it.
2. Watch the 3Blue1Brown attention video. These two together will give you the intuition.
3. Exercise Set 1 (tokenization) — spend real time at tiktokenizer.vercel.app. This is where the abstract becomes concrete.
4. Exercise Set 2 (context window experiments) — actually do these with a live model. Observe what happens at the edges.
5. Exercise Set 3 (temperature) — interactive; takes 15 minutes and permanently changes how you think about model outputs.
6. Exercise Set 4 (concept map) — write or draw your mental model. The act of writing it consolidates understanding.

What you're trying to internalize:
- Why tokenization affects model behavior in non-obvious ways (counting, spelling, non-English)
- What "attention" means intuitively — not the math, the concept
- The context window as a hard limit on memory

### embeddings
**After transformers — builds on the vector/semantic intuition.**

1. Read the Simon Willison piece first — it's the most practical intro.
2. Exercise Set 1 (cosine similarity intuition) — do the prediction before running anything. Being wrong is instructive.
3. Exercise Set 2 (generate and compare embeddings) — the most hands-on exercise. Use Google Colab if you don't want to set up local Python.
4. Exercise Set 3 (semantic search) — build the minimal version. This pattern is the foundation of RAG in Phase 5.
5. Exercise Set 4 (multimodal experiment) — upload an image to Claude or GPT-4V and test what it can and can't do.

### ml-eval
**After transformers, but independent from the other modules.**

1. Read through the confusion matrix and metrics sections — understand precision, recall, and when each matters.
2. Exercise Set 1 (confusion matrix practice) — do the math by hand.
3. Exercise Set 2 (interpret metrics) — the spam filter with 99% accuracy but 20% recall is a classic gotcha.
4. Exercise Set 3 (spot the leakage) — all three scenarios represent real mistakes that invalidate real ML projects.
5. Exercise Set 4 (run a real evaluation) — Google Colab, scikit-learn breast cancer dataset. See what the numbers look like in practice.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/ml-eval-framework.md`. Design how you'll evaluate the reliability of the causal forest layer specifically. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### llm-eval
**After ml-eval and transformers — applies the eval concepts to the LLM context.**

1. Read the "why LLM eval is hard" section carefully. This is the key insight the module builds on.
2. Exercise Set 1 (run a model against a benchmark) — the LMSYS Arena. Does the leaderboard match your experience?
3. Exercise Set 2 (design an eval suite) — the support ticket summarization scenario. This is the most practically useful exercise in this module.
4. Exercise Set 3 (LLM-as-judge experiment) — build a prompt that scores outputs. Notice where it agrees with you and where it doesn't.
5. Exercise Set 4 (TruthfulQA paper) — read the abstract and the surprising result about larger models.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/llm-eval-plan.md`. Design how you'll evaluate the plain-English explanation feature specifically. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### rl-rlhf
**After transformers and llm-failures — makes most sense after you understand what RLHF is trying to fix.**

1. Read the Hugging Face RLHF blog first — it's the best practical explanation.
2. Exercise Set 1 (intuition check) — answer first, then compare to the blog. This surfaces what you actually understand vs what you think you understand.
3. Exercise Set 2 (reward hacking examples) — finding real examples matters. The pattern is everywhere.
4. Exercise Set 3 (InstructGPT paper) — read sections 1–2. This is where RLHF went from research to product.
5. Exercise Set 4 (behavioral analysis) — test for sycophancy and refusal behavior yourself. Empirical beats abstract.

### inference-opt
**After transformers — can be done in parallel with other modules.**

1. Read the latency components section first. TTFT vs throughput is a distinction that will come up constantly.
2. Exercise Set 1 (measure latency) — actually time your API calls. Run the experiment.
3. Exercise Set 2 (streaming implementation) — write the streaming code. See how different the UX feels.
4. Exercise Set 3 (prompt caching experiment) — if you're using the Anthropic API, actually verify you're hitting the cache.
5. Exercise Set 4 (cost estimation) — do this calculation for a feature you'd actually want to build.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/ml-serving-design.md`. Design how the platform will serve causal forest and uplift model results at query time. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### llm-failures
**Do this after transformers and before Phase 5 — this is the prerequisite for red-teaming and HITL design.**

1. Read all 10 failure modes. Don't just scan — each one deserves a minute of thought.
2. Exercise Set 1 (induce hallucinations) — actually do it. Which topics are most susceptible?
3. Exercise Set 2 (prompt injection demo) — build the simple system. Test both the attack and the defense.
4. Exercise Set 3 (sycophancy test) — this one is often surprising. The capitulation can be subtle.
5. Exercise Set 4 (failure taxonomy) — apply the framework to a real AI product you've used.

---

## Phase 4 is complete when:
- [ ] All seven modules marked `complete` in the curriculum map
- [ ] `docs/reading/tokenization-notes.md` committed
- [ ] `docs/projects/embedding-experiment.md` committed
- [ ] `docs/projects/semantic-search/` committed
- [ ] `docs/reading/ml-eval-exercises.md` committed
- [ ] `docs/projects/eval-suite-design.md` committed
- [ ] `docs/reading/reward-hacking-examples.md` committed
- [ ] `docs/projects/streaming-demo.ts` committed
- [ ] `docs/reading/hallucination-experiments.md` committed
- [ ] Glossary has entries for: token, transformer, attention, context window, embedding, cosine similarity, precision, recall, AUC, RLHF, reward hacking, TTFT, hallucination, prompt injection, sycophancy

**Platform artifacts from this phase:**
- [ ] `docs/projects/experimentation_platform/ml-eval-framework.md` (from `ml-eval`)
- [ ] `docs/projects/experimentation_platform/llm-eval-plan.md` (from `llm-eval`)
- [ ] `docs/projects/experimentation_platform/ml-serving-design.md` (from `inference-opt`)

**Next:** Open `docs/phases/phase-5.md`

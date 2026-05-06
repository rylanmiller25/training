# Module: LLM Evaluation

**Phase:** 4  
**Slug:** `llm-eval`  
**Status:** not started  

---

## What it is / how to think about it

LLM evaluation is the practice of systematically measuring whether a language model (or AI feature) actually does what you want. It's harder than traditional software testing because there's no single "correct" answer — outputs are probabilistic and context-dependent.

**Mental model:** Imagine hiring a contractor. You don't just ask "did they show up?" — you check: did they build what the spec said, is the quality acceptable, did they break anything else? LLM evals are the same — you define what good looks like, then build systems to measure it consistently.

---

## Prerequisites
- Transformers module (context window, hallucination intuition)

---

## Best resources

**Primary:**
1. [HELM – Stanford CRFM](https://crfm.stanford.edu/helm/latest/) — comprehensive public benchmark suite; read the methodology
2. [Anthropic's evals guide](https://www.anthropic.com/research/evaluating-ai-systems) — practical framing from the team building Claude

**Supporting:**
- [LMSYS Chatbot Arena](https://chat.lmsys.org/) — human preference leaderboard via pairwise comparisons; understand its methodology
- [OpenAI Evals framework](https://github.com/openai/evals) — open-source eval framework; read the README
- [Ragas](https://docs.ragas.io/) — RAG evaluation framework (useful for Phase 5)

**YouTube:**
- [LLM Evaluation – Hamel Husain](https://www.youtube.com/watch?v=A8N8QFDNenA) (45 min — practitioner perspective)
- [How to evaluate LLMs – AI Jason](https://www.youtube.com/watch?v=oMFGM_Pq_-A) (20 min)

---

## Core concepts to cover

### Why LLM eval is hard
- No ground truth: "good" is often subjective or context-dependent
- High variance: same prompt → different outputs across runs
- Benchmark gaming: models can be optimized on public benchmarks without improving real-world performance
- Distribution shift: benchmark tasks rarely match your actual use case
- Goodhart's Law: when a measure becomes a target, it ceases to be a good measure

### Types of evals

**Automated evals:**
- **Exact match:** output must equal reference string (good for classification, structured tasks)
- **Regex / rule-based:** check for presence/absence of patterns
- **Embedding similarity:** compare semantic similarity to reference answer
- **Model-graded (LLM-as-judge):** use another LLM to score outputs on criteria
  - Advantage: flexible, scalable
  - Risk: the judge model has its own biases; can be gamed
- **F1 / BLEU / ROUGE:** overlap-based metrics (NLP research); poor proxies for actual quality

**Human evals:**
- **Pairwise preference:** show two outputs, ask which is better (Arena-style)
- **Absolute rating:** rate output on 1–5 scale per criterion
- **Task completion:** can a human accomplish the intended task using the output?
- Gold standard; expensive and slow; use for calibration and high-stakes decisions

### What to evaluate
- **Correctness:** is the factual content accurate?
- **Faithfulness:** does the output stay within the provided context (RAG)?
- **Relevance:** does it actually answer the question asked?
- **Completeness:** does it cover all required points?
- **Harmlessness:** does it avoid harmful, unsafe, or policy-violating content?
- **Format:** does it follow the required output format?
- **Latency / cost:** is it fast and cheap enough for production?

### Building an eval suite
1. Define the task clearly (inputs, outputs, acceptance criteria)
2. Collect gold examples (human-labeled, high-quality reference outputs)
3. Choose metrics for each criterion
4. Set pass/fail thresholds
5. Run on a holdout set; don't overfit to your eval set
6. Automate — run on every model change or prompt change

### Benchmark landscape (know what exists)
- **MMLU:** multi-subject multiple choice (measures knowledge breadth)
- **HumanEval / MBPP:** code generation benchmarks
- **TruthfulQA:** measures tendency to hallucinate on known tricky questions
- **HellaSwag / WinoGrande:** commonsense reasoning
- **MT-Bench / Alpaca Eval:** instruction following
- **LMSYS Arena:** human pairwise preferences (correlates best with real-world satisfaction)

### Eval in production
- **A/B testing:** route % of traffic to new model/prompt; measure downstream outcomes
- **Logging + sampling:** sample production outputs for periodic human review
- **Drift detection:** monitor output quality metrics over time; alert on degradation
- **Canary deployments:** roll out to 5% of users; compare evals before full rollout

---

## Exercises

**Set 1 — Run a model against a benchmark (30 min):**
Use the LMSYS Arena (lmsys.org/chat) or similar tool to:
1. Ask the same 5 questions to two different models
2. Rate each answer for: accuracy, completeness, format
3. Does the leaderboard ranking match your subjective preference?
Write observations in `docs/reading/EVAL-BENCHMARK-EXERCISE.md`.

**Set 2 — Design an eval suite (45 min):**
You're building a feature that summarizes customer support tickets for agents. Design an eval:
1. What are the 3 most important quality dimensions?
2. What inputs would you use (construct 5 example tickets)?
3. What does a "perfect" summary look like? Write 2 reference outputs.
4. How would you automate scoring? (exact match? LLM-as-judge? keyword check?)
5. What's your pass/fail threshold?
Save to `docs/projects/EVAL-SUITE-DESIGN.md`.

**Set 3 — LLM-as-judge experiment (30 min):**
Using Claude or GPT-4:
1. Write a prompt that asks the model to score a summary on 3 criteria (1–5 scale), returning JSON
2. Feed it 5 different quality summaries (write them yourself — one great, one mediocre, three in between)
3. Does the model's scoring match your intuition?
4. What happens if you change the rubric wording?
Save code/prompts + results to `docs/projects/LLM-JUDGE-EXPERIMENT.md`.

**Set 4 — Read a real eval paper (30 min):**
Read the TruthfulQA paper abstract + results section (https://arxiv.org/abs/2109.07958).
- What task was it measuring?
- How did the authors construct the questions?
- What surprising result did they find about larger models?
Write a 5-bullet summary in `docs/reading/TRUTHFULQA-NOTES.md`.

---

## Checks — you understand this when you can:
- [ ] Explain why LLM eval is harder than traditional software testing
- [ ] Describe 3 types of automated evals and when to use each
- [ ] Explain what Goodhart's Law means for benchmark scores
- [ ] Design an eval suite for a real AI feature (dimensions, examples, metrics, thresholds)
- [ ] Explain what LLM-as-judge is and its risks
- [ ] Explain how you'd detect model degradation in production

---

## Artifacts to commit
- [ ] `docs/reading/EVAL-BENCHMARK-EXERCISE.md`
- [ ] `docs/projects/EVAL-SUITE-DESIGN.md`
- [ ] `docs/projects/LLM-JUDGE-EXPERIMENT.md`
- [ ] `docs/reading/TRUTHFULQA-NOTES.md`
- [ ] Glossary entries: eval, benchmark, LLM-as-judge, MMLU, Goodhart's Law, pairwise preference, A/B testing
- [ ] Log entry in `docs/LOG.md`

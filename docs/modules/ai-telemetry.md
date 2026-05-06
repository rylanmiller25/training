# Module: AI Product Telemetry

**Phase:** 5  
**Slug:** `ai-telemetry`  
**Status:** not started  

---

## What it is / how to think about it

AI features need different observability than traditional software. A function either returns the right value or it doesn't — but an LLM response is on a spectrum from excellent to harmful, and that spectrum shifts over time as models change, prompts drift, and user behavior evolves.

**Mental model:** Traditional monitoring asks "is the service up?" AI telemetry asks "is the service *good*?" You need to monitor quality metrics, not just uptime metrics.

---

## Prerequisites
- LLM Eval, LLM Failures, Prompt Engineering modules

---

## Best resources

**Primary:**
1. [LangSmith docs](https://docs.smith.langchain.com/) — production observability platform for LLM apps; read the concepts
2. [Langfuse docs](https://langfuse.com/docs) — open-source alternative; good for self-hosted

**Supporting:**
- [Evaluating LLMs in production – Chip Huyen](https://huyenchip.com/2023/04/11/llm-engineering.html) — practical production lessons
- [AI observability guide – Arize AI](https://arize.com/blog-course/llm-observability/)

**YouTube:**
- [LLM Monitoring in production – Hamel Husain](https://www.youtube.com/watch?v=VFarC1gY0xA) (40 min)

---

## Core concepts

### What to log
Every LLM call in production should log:
- **Input:** full prompt (system + user), model, parameters (temperature, max tokens)
- **Output:** full response text, finish reason (stop, length, content filter)
- **Metadata:** user ID, session ID, feature name, latency, token counts (input/output), cost
- **Feedback:** thumbs up/down, explicit ratings, downstream outcomes (did user accept the suggestion?)

### Metrics to track
- **Latency:** P50, P95, P99 TTFT and total response time
- **Token usage:** input + output tokens per request; cost per request; cost per user/feature
- **Error rates:** model API errors, content filter triggers, timeout rates
- **Quality metrics (sampled):** faithfulness, relevance, helpfulness (from auto-eval or human review)
- **User feedback signals:** explicit (rating) and implicit (did they copy the output? edit it? ignore it?)

### Drift detection
- **Input distribution drift:** are users asking different types of questions over time?
- **Output drift:** are model responses changing in style/quality without prompt changes?
- **Quality score drift:** are automated eval scores trending down?
- Alert when: quality score drops 10%+ week-over-week, error rate exceeds threshold, latency P95 spikes

### Trace visualization
- For multi-step pipelines (agent, RAG, chain), log each step as a span
- Visualize the full trace: what was retrieved, what was the intermediate output, where did it go wrong?
- Tools: LangSmith, Langfuse, Honeycomb (for custom traces via OpenTelemetry)

### Feedback loops
- Surface low-rated conversations to reviewers automatically
- Tag failure categories: retrieval failure, hallucination, wrong format, unhelpful
- Use tagged failures to improve eval suite and prompts
- Track improvement: did the change fix this category of failure?

### Privacy considerations when logging
- Don't log PII in production traces by default — or mask/redact it
- Comply with data retention policies — don't store prompts indefinitely
- Get user consent if logging is used to improve the model

---

## Exercises

**Set 1 — Instrument a simple LLM app (45 min):**
Take the prompt-eng or RAG project you built. Add logging:
1. Before/after each LLM call: log input tokens, output tokens, latency
2. Log to console in structured JSON (so it could be sent to a log aggregator)
3. Calculate and print cost per request (use current pricing)
Save instrumented code to `docs/projects/telemetry-demo/`.

**Set 2 — Design a monitoring dashboard (30 min):**
For a production AI feature (e.g. customer support auto-reply), design the monitoring dashboard:
- What metrics appear in the top row? (the "is it healthy?" view)
- What charts would you show for weekly review?
- What alert conditions trigger a page?
- What data feeds into the monthly quality review?
Save to `docs/reading/ai-monitoring-dashboard.md`.

**Set 3 — Failure triage exercise (20 min):**
Given 5 sampled LLM outputs with user feedback (write them yourself — 2 good, 1 hallucination, 1 wrong format, 1 unhelpful):
1. Categorize each failure type
2. Identify whether the root cause is: retrieval, prompt, model, or input quality
3. What change would prevent each?
Save to `docs/reading/failure-triage-exercise.md`.

---

## Checks — you understand this when you can:
- [ ] List the 5 things you must log for every LLM call in production
- [ ] Explain what drift detection is and how to alert on it
- [ ] Explain how implicit user feedback (copy, edit, ignore) differs from explicit ratings
- [ ] Design a monitoring dashboard for an AI feature
- [ ] Explain what a trace is in the context of a multi-step LLM pipeline

---

## Artifacts to commit
- [ ] `docs/projects/telemetry-demo/`
- [ ] `docs/reading/ai-monitoring-dashboard.md`
- [ ] `docs/reading/failure-triage-exercise.md`
- [ ] Glossary entries: telemetry, trace, span, drift detection, implicit feedback, quality score
- [ ] Log entry in `docs/log.md`

# Module: Model Selection + Platform Decisions

**Phase:** 5 (Weeks 37–46)  
**Slug:** `model-selection`  
**Status:** not started  
**Estimated time:** 4–5 hours

---

## What it is / how to think about it

Choosing which model and platform to use for an AI feature is a product and business decision, not just a technical one. The "best" model is the cheapest one that meets your quality bar — and that bar changes with task type, latency requirements, volume, and compliance constraints.

**Mental model:** Like choosing cloud providers or databases — you evaluate on capability, cost, reliability, ecosystem, and lock-in risk. No single choice is right for every use case.

---

## Prerequisites
- LLM Eval, Inference Optimization, Transformers modules

---

## Best resources

**Primary:**
1. [LMSYS Chatbot Arena](https://chat.lmsys.org/) — human preference leaderboard; best real-world quality signal
2. [Artificial Analysis](https://artificialanalysis.ai/) — independent benchmarking of models on quality + speed + cost

**Supporting:**
- [Scale AI HELM Lite](https://crfm.stanford.edu/helm/lite/latest/) — academic benchmarks
- [Simon Willison's LLM comparison blog](https://simonwillison.net/) — practitioner notes on new models

**YouTube:**
- [How to choose an LLM – Hamel Husain](https://www.youtube.com/watch?v=c-c2hJ0Ps4w) (30 min)

---

## Core concepts

### Evaluation dimensions
- **Quality:** benchmark scores + task-specific evals on your actual use case
- **Latency:** TTFT + throughput at your expected concurrency
- **Cost:** input + output token pricing; factor in prompt caching savings
- **Context window:** how much text can you fit? Does your use case need 8K, 100K, or 1M tokens?
- **Reliability:** uptime SLA; rate limits; geographic availability
- **Compliance:** data processing agreements, SOC2, HIPAA, GDPR residency requirements
- **Vendor lock-in:** how hard is it to switch if pricing doubles or quality drops?

### Model tiers to know (as of 2026)
- **Frontier/flagship:** Claude claude-opus-4-7, GPT-4o, Gemini 1.5 Pro — best quality; highest cost; use for hard tasks
- **Mid-tier:** Claude claude-sonnet-4-6, GPT-4o-mini, Gemini 1.5 Flash — good quality/cost balance; most production workloads
- **Small/fast:** Claude claude-haiku-4-5, Gemini Flash — cheapest; lowest latency; simple tasks, high volume
- **Open source:** Llama 3.x, Mistral, Qwen — run yourself; no per-token API cost; need infra; data stays on-prem

### Task-to-model matching
| Task type | Model tier |
|-----------|-----------|
| Complex reasoning, coding, analysis | Frontier |
| Customer support, content generation, summarization | Mid-tier |
| Classification, routing, simple extraction | Small/fast |
| Embeddings | Dedicated embedding model |
| Image understanding | Multimodal (Claude claude-sonnet-4-6, GPT-4V) |

### Cost calculation
```
Monthly cost = (requests/day × 30) × ((avg_input_tokens × input_price) + (avg_output_tokens × output_price))

Example: 10K requests/day, 1K input tokens, 500 output tokens, Claude claude-sonnet-4-6
= 300K requests/month × ((1000 × $3/1M) + (500 × $15/1M))
= 300K × ($0.003 + $0.0075)
= 300K × $0.0105 = $3,150/month
```

### Open source vs API tradeoffs
- **API (Anthropic, OpenAI):** no infra to manage; pay per token; data sent to provider; rate limited; model updates handled for you
- **Open source (Llama, Mistral):** run on your own GPU; no per-token cost at scale; data never leaves your infra; you manage updates, scaling, reliability
- **Crossover point:** typically when spending > $10K–50K/month on API costs, open source becomes worth the operational overhead

### Commodity risk
- Leading models converge in quality rapidly
- What's frontier today is mid-tier in 12 months
- Avoid deep lock-in to proprietary APIs: use abstraction layers (LiteLLM), maintain the ability to swap
- Bet on capabilities (what the model can do), not specific providers

### Streaming + caching decisions
- Always stream for interactive UIs
- Cache common prefixes (system prompts, static context)
- Consider: synchronous (await full response) vs streaming for your use case

---

## Exercises

**Set 1 — Model comparison on your task (45 min):**
Choose a specific task (e.g. summarizing a long document, classifying support tickets, generating code).
Run the same 10 inputs through 3 models (e.g. claude-haiku-4-5, claude-sonnet-4-6, claude-opus-4-7 or GPT-4o-mini vs GPT-4o).
Rate each output on quality. Calculate cost per 1M requests for each model.
Build a recommendation: which model for production? Why?
Save to `docs/projects/model-comparison.md`.

**Set 2 — Cost model (30 min):**
Design a cost model for an AI feature you'd build:
- Inputs: requests per day, average input tokens, average output tokens
- Calculate: monthly cost for small/mid/flagship model tiers
- Calculate: breakeven requests/month where open source beats API
Save to `docs/reading/model-cost-model.md`.

**Set 3 — Compliance check (20 min):**
Research: what data processing commitments do the major providers offer?
- Does Anthropic offer a HIPAA BAA?
- Does OpenAI train on API data by default?
- What's the difference between Azure OpenAI and OpenAI's API for enterprise compliance?
Save to `docs/reading/ai-compliance-notes.md`.

---

## Checks — you understand this when you can:
- [ ] Name 3 frontier, 3 mid-tier, and 3 small models and their trade-offs
- [ ] Calculate monthly API cost given prompt length and volume
- [ ] Explain when open source becomes more cost-effective than API
- [ ] Explain 3 compliance considerations that affect model selection
- [ ] Explain what commodity risk means for model selection strategy

---

## Artifacts to commit
- [ ] `docs/projects/model-comparison.md`
- [ ] `docs/reading/model-cost-model.md`
- [ ] `docs/reading/ai-compliance-notes.md`
- [ ] Glossary entries: frontier model, commodity risk, vendor lock-in, open source LLM, LiteLLM
- [ ] Log entry in `docs/log.md`

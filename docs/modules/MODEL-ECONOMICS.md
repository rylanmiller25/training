# Module: Model Economics + Commoditization

**Phase:** 6  
**Slug:** `model-economics`  
**Status:** not started  

---

## What it is / how to think about it

Model economics covers the cost structure of training and serving AI models, scaling laws, and what happens to prices and value capture as capabilities commoditize. It's how you reason about the AI industry's long-term structure.

**Mental model:** Semiconductor economics compressed into software timelines. Training costs fall as hardware improves; inference costs fall as optimization matures; capabilities converge across providers. The question is always: who captures value when the core technology becomes cheap?

---

## Prerequisites
- AI Landscape module; Inference Optimization module

---

## Best resources

**Primary:**
1. [Epoch AI – Training compute trends](https://epochai.org/blog/tracking-large-language-model-training) — data on training costs over time
2. [Scaling Laws for Neural Language Models – OpenAI](https://arxiv.org/abs/2001.08361) — original paper; read abstract + key results

**Supporting:**
- [The economics of AI – Dario Amodei](https://darioamodei.com/machines-of-loving-grace) — Anthropic CEO's long-form view
- [AI pricing trends – Artificial Analysis](https://artificialanalysis.ai/models) — live tracking of cost/performance

**YouTube:**
- [Scaling laws explained – AI Explained](https://www.youtube.com/watch?v=UFC2kTKhPFY) (20 min)
- [The economics of AI startups – a16z](https://www.youtube.com/watch?v=_J0Hs8p9p_Y) (40 min)

---

## Core concepts

### Training costs
- Training frontier models costs $10M–$1B+ in compute
- Dominated by: GPU/TPU time, electricity, engineering talent
- Cost has followed Moore's Law in efficiency: same capability costs 2–3x less per year as hardware improves
- But capability appetite scales faster than efficiency — labs spend more each generation

### Inference costs
- Inference is per-token: the cost to generate one token at scale
- Inference is ~10–100x cheaper per parameter than training
- Rapidly declining: 2023 GPT-4 level quality costs 100x less in 2026 (driven by optimization, smaller models, quantization)
- Implication: the barrier to deploying AI drops every year

### Scaling laws (Chinchilla)
- Model performance scales predictably with: model size, training data, compute
- **Chinchilla scaling:** optimal compute allocation = scale model and data together; smaller models trained on more data often outperform larger models trained on less
- Log-linear relationship: doubling compute gives predictable capability gains
- Implies: labs can predict how much capability they'll get before training (to some extent)

### The 7-layer AI cost stack

When building an AI product, the model API line item is the visible cost. The true cost stack has seven layers, and products that only price based on the API layer routinely underprice and destroy margins.

1. **Model cost:** input + output token charges from the API provider
2. **Retrieval cost:** vector database queries, embedding generation, search infrastructure for RAG pipelines
3. **Orchestration cost:** LangChain / LangGraph execution, tool call overhead, multi-agent coordination infrastructure
4. **Latency cost:** the compute kept warm to hit SLA targets (cold starts are free; hot standby is not)
5. **Failure and retry cost:** re-runs from model hallucinations, JSON parse failures, tool call errors — typically adds 10–30% to nominal API cost in production
6. **Evaluation cost:** ongoing evals, human review, red-teaming, quality monitoring
7. **Data infrastructure cost:** logging, tracing, prompt/output storage, feedback capture

Most pricing models quote against layer 1 only. Real unit economics require summing all seven.

**Implication for the experimentation platform:** The AI interpretation layer runs against every chart render. At scale, retrieval (context from prior experiments), failure/retry (JSON parse on interpretation outputs), and logging infrastructure may exceed the model token cost.

### The 4 AI pricing models

**Usage-based:** Price per API call, per query, or per active experiment. Aligns with how your costs scale. Easiest to model; hardest for customers to budget. Best when usage is bursty or unpredictable.

**Hybrid (seat + usage):** Base platform fee per seat, plus overage charges beyond a usage threshold. Gives customers predictability; gives you a floor. The dominant model for B2B AI tools at Series A+.

**Outcome-based:** Price on the value delivered, not on consumption. For the experimentation platform: charge per experiment that reaches statistical significance, or per insight that drives a measurable business decision. Highest perceived value; hardest to measure; requires deep instrumentation.

**Capacity-based:** Flat fee for a committed capacity tier (e.g., up to 20 concurrent experiments, up to 10M events/month). Predictable for both sides; works when usage is fairly steady. Common in infrastructure-adjacent AI tools.

**Pricing trap:** Don't price based on what feels fair — price based on cost structure. Variable costs in AI scale with usage; a fixed subscription on a usage-variable product is the fastest way to margin compression at scale.

### Cost optimization techniques

When AI unit economics are tight, four levers move the needle most:

**Token diet:** Compress context ruthlessly. Summarize prior conversation turns instead of passing full history. Strip redundant instructions from system prompts. Use shorter model names and field labels in structured outputs. A 40% context reduction is often achievable without quality loss.

**Context compression:** Use a small, cheap model to compress long context before passing to the primary model. E.g., use a 4B parameter model to summarize a 20K-token document to 500 tokens, then pass to the frontier model for reasoning. Saves 95%+ of input token cost on long-context tasks.

**Model right-sizing (cascaded inference):** Route tasks by complexity. Simple tasks (classification, formatting, extraction) go to small fast cheap models. Complex tasks (multi-step reasoning, novel synthesis) go to frontier models. In practice, 60–80% of tasks in most products are simple enough for a small model.

**Cascaded inference pattern:** Score each incoming request for complexity (or predicted output length) before routing. Routing logic itself adds ~$0.0001 per request — trivially offset by routing 70% of traffic to a model that's 20x cheaper.

**For the experimentation platform:** HTE analysis and causal inference are complex — frontier model territory. Result interpretation at the chart level is simpler — good candidate for a smaller model. Pre-experiment power analysis (deterministic math wrapped in natural language) needs almost no model intelligence — cheapest possible model or no model at all.

### Pricing structure
- API pricing: $ per million input tokens + $ per million output tokens
- Output is 3–5x more expensive than input (generation is slower)
- Prices fall ~50% per year as competition and efficiency improve
- Implication: products built on API margins today will see cost structures improve dramatically

### Commoditization dynamics
- **Phase 1 (now):** frontier model has clear quality advantage → can charge premium
- **Phase 2 (18–24 months later):** competitors reach parity → margin compression
- **Phase 3:** model APIs become commodity inputs, like cloud compute or bandwidth
- Historical parallel: databases, cloud storage, email infrastructure all followed this curve

### Value capture in commoditizing markets
- As model APIs commoditize, value shifts to:
  - **Distribution:** who already has the users?
  - **Proprietary data:** unique training data or fine-tuning sets
  - **Workflow integration:** deep embedding in existing tools (switching cost)
  - **Trust and compliance:** regulated industries pay premium for security/compliance
  - **Speed:** fastest time to market in a specific vertical

### The training vs inference split
- Companies that only do inference (no training) are more exposed to commoditization
- Owning training capability = control over differentiation + alignment
- But training requires massive capital → most companies will always be inference-only

---

## Exercises

**Set 1 — Pricing timeline (20 min):**
Research historical API pricing:
- What did GPT-4 cost per 1M tokens when it launched (early 2023)?
- What does equivalent quality cost today?
- Plot the trend. What does this mean for AI product margins?
Save to `docs/reading/MODEL-PRICING-TRENDS.md`.

**Set 2 — Full cost stack analysis (45 min):**
Map the 7-layer cost stack for the experimentation platform:
- For a user who runs 5 experiments per month with ~50K events each, estimate costs at each of the 7 layers
- Where are the largest cost centers? Where are you most uncertain?
- At what scale (number of paying customers) does each layer become significant?
- How does a 50% model API price drop affect total unit economics?
Save to `docs/reading/AI-COST-STRUCTURE.md`.

**Set 3 — Pricing model design (30 min):**
Design a pricing model for the experimentation platform:
- Which of the 4 pricing models fits best, and why? (usage-based, hybrid, outcome-based, capacity-based)
- What is the billable unit? Why that unit and not another?
- At your chosen price point, what gross margin do you achieve at 50 / 500 / 5000 customers?
- What happens to margins if you implement cascaded inference for the interpretation layer?
Save to `docs/reading/PLATFORM-PRICING-MODEL.md`.

**Set 4 — Scaling laws intuition (20 min):**
Read just the abstract and Figure 1 of the Chinchilla paper (https://arxiv.org/abs/2203.15556).
- What was the key finding?
- What mistake were prior labs making?
- What does "compute-optimal" mean?
Save notes to `docs/reading/SCALING-LAWS-NOTES.md`.

**Set 5 — Commoditization strategy (20 min):**
Choose one company building on AI APIs (Cursor, Jasper, Perplexity, etc.).
- What is their moat as model APIs commoditize?
- What would happen to them if their core model provider made a competing product?
- How would you advise them to build defensibility?
Save to `docs/reading/COMMODITIZATION-STRATEGY.md`.

---

## Checks — you understand this when you can:
- [ ] Explain why inference costs fall faster than training costs
- [ ] Explain scaling laws (Chinchilla) in one paragraph
- [ ] Name all 7 layers of the AI cost stack and explain why each matters
- [ ] Explain the 4 AI pricing models and when each is appropriate
- [ ] Explain token diet, context compression, and cascaded inference — and apply each to the experimentation platform
- [ ] Predict the margin trajectory for a product built on API pricing
- [ ] Explain 3 sources of defensibility as model capabilities commoditize
- [ ] Explain when it makes economic sense to train vs use APIs

---

## Artifacts to commit
- [ ] `docs/reading/MODEL-PRICING-TRENDS.md`
- [ ] `docs/reading/AI-COST-STRUCTURE.md`
- [ ] `docs/reading/PLATFORM-PRICING-MODEL.md`
- [ ] `docs/reading/SCALING-LAWS-NOTES.md`
- [ ] `docs/reading/COMMODITIZATION-STRATEGY.md`
- [ ] Glossary entries: scaling laws, Chinchilla, compute-optimal, inference cost, training cost, commoditization, token diet, cascaded inference, context compression, usage-based pricing, outcome-based pricing
- [ ] Log entry in `docs/LOG.md`

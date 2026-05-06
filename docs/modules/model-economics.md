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
Save to `docs/reading/model-pricing-trends.md`.

**Set 2 — Cost structure analysis (30 min):**
For a hypothetical AI-first company (pick: coding assistant, customer support bot, document analysis tool):
- What's the API cost per user per month at your pricing tier?
- What gross margin can you achieve?
- How does that margin change if API prices fall 50%?
- At what scale does training your own model become cost-effective?
Save to `docs/reading/ai-cost-structure.md`.

**Set 3 — Scaling laws intuition (20 min):**
Read just the abstract and Figure 1 of the Chinchilla paper (https://arxiv.org/abs/2203.15556).
- What was the key finding?
- What mistake were prior labs making?
- What does "compute-optimal" mean?
Save notes to `docs/reading/scaling-laws-notes.md`.

**Set 4 — Commoditization strategy (20 min):**
Choose one company building on AI APIs (Cursor, Jasper, Perplexity, etc.).
- What is their moat as model APIs commoditize?
- What would happen to them if their core model provider made a competing product?
- How would you advise them to build defensibility?
Save to `docs/reading/commoditization-strategy.md`.

---

## Checks — you understand this when you can:
- [ ] Explain why inference costs fall faster than training costs
- [ ] Explain scaling laws (Chinchilla) in one paragraph
- [ ] Predict the margin trajectory for a product built on API pricing
- [ ] Explain 3 sources of defensibility as model capabilities commoditize
- [ ] Explain when it makes economic sense to train vs use APIs

---

## Artifacts to commit
- [ ] `docs/reading/model-pricing-trends.md`
- [ ] `docs/reading/ai-cost-structure.md`
- [ ] `docs/reading/scaling-laws-notes.md`
- [ ] `docs/reading/commoditization-strategy.md`
- [ ] Glossary entries: scaling laws, Chinchilla, compute-optimal, inference cost, training cost, commoditization
- [ ] Log entry in `docs/log.md`

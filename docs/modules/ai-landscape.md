# Module: AI Product Landscape + Lab Structures

**Phase:** 6  
**Slug:** `ai-landscape`  
**Status:** not started  

---

## What it is / how to think about it

This module builds a map of who's doing what in AI — labs, products, investment flows, and go-to-market patterns. The goal isn't to memorize facts, but to develop a framework for reading any new development and knowing where it fits.

**Mental model:** The AI landscape is a stack. At the bottom are compute providers (NVIDIA, cloud). Above that are model providers (Anthropic, OpenAI, Google, Meta). Above that are platforms and dev tools (LangChain, Hugging Face). At the top are vertical applications. Money flows up from applications and down from investors.

---

## Prerequisites
- Transformers, LLM Eval, Model Selection modules

---

## Best resources

**Primary:**
1. [State of AI Report – Air Street Capital](https://www.stateof.ai/) — annual; comprehensive; covers research + products + industry
2. [a16z AI canon](https://a16z.com/ai-canon/) — curated reading list for AI fundamentals and applications

**Supporting:**
- [Anthropic's interpretability research](https://www.anthropic.com/research) — see what frontier labs actually work on
- [Pitchbook / CB Insights AI funding reports](https://pitchbook.com/) — where money is flowing (check free reports)
- [Ben Thompson – Stratechery](https://stratechery.com/) — business strategy analysis of AI companies

**YouTube:**
- [AI landscape explained – Sequoia Capital](https://www.youtube.com/watch?v=ZNs7KGgJ4lk) (30 min)
- [The AI Triad – Andrej Karpathy](https://www.youtube.com/watch?v=zjkBMFhNj_g) (20 min on compute/data/algorithms)

---

## Core concepts

### The major AI labs (as of 2026)
- **Anthropic:** safety-focused; Claude models; Constitutional AI; interpretability research
- **OpenAI:** GPT-4o; ChatGPT; Microsoft partnership; operator APIs
- **Google DeepMind:** Gemini; AlphaFold; deep integration with Google Cloud + consumer products
- **Meta AI:** open-source Llama models; massive distribution through social platforms
- **Mistral:** European; open + commercial; efficiency-focused
- **xAI:** Grok; Twitter/X distribution; Elon Musk

### Lab structures
- Most frontier labs are a hybrid: research org + product company
- Research produces papers and model capabilities; product teams ship applications
- Safety teams at Anthropic and OpenAI operate semi-independently, with publication rights
- Compute is a moat: training frontier models costs $10M–$1B+; only a handful of organizations can afford it

### The AI product stack
```
[Vertical apps] (customer-specific; e.g. Harvey for legal, Otter.ai for meetings)
[Horizontal platforms] (Cursor, Notion AI, GitHub Copilot)
[Developer tools + orchestration] (LangChain, LlamaIndex, Weights & Biases, Keystroke, n8n)
[Foundation model APIs] (Anthropic, OpenAI, Google, Cohere)
[Open source models] (Meta Llama, Mistral)
[Cloud infrastructure] (AWS, GCP, Azure)
[Compute hardware] (NVIDIA H100/H200, Google TPUs, AMD)
```

### Go-to-market patterns
- **API-first:** sell to developers; usage-based pricing; grow via product viral loops
- **Co-pilot:** embed AI into existing workflows (GitHub Copilot, Cursor, Notion AI)
- **Vertical AI:** build the full stack for a specific industry (legal, medical, finance)
- **Consumer AI:** ChatGPT model — mass-market; subscription + freemium
- **Enterprise AI:** large contracts; compliance, security, custom models; long sales cycles

### Where investment flows
- Infrastructure: GPU clusters, model training, serving infra
- Developer tools: observability, evals, fine-tuning platforms
- Vertical AI apps: healthcare, legal, finance, education, coding
- Consumer AI: companions, tutoring, creative tools
- Robotics: embodied AI is the emerging frontier

### Commoditization dynamics
- Frontier model capabilities converge rapidly (18-month lag from leader to parity)
- Model APIs are increasingly substitutable; differentiation moves up the stack
- Value accrues to: distribution (who has users?), proprietary data, unique workflows
- Companies building on top of model APIs are exposed to margin compression as API prices fall

### Vertical vs horizontal AI
- **Horizontal:** general-purpose tools that work across industries (ChatGPT, Copilot)
  - Pros: large TAM; network effects; broad data
  - Cons: hard to customize deeply for any vertical; face direct competition from labs
- **Vertical:** deep specialization in one industry (Harvey for legal, Rad AI for radiology)
  - Pros: domain-specific data, workflow integration, defensible moats
  - Cons: smaller TAM; requires domain expertise; slower sales cycles

---

## Exercises

**Set 1 — Landscape map (45 min):**
Draw (or write in markdown table) the current AI landscape:
- 5 foundation model providers (name their flagship model, pricing tier, differentiator)
- 5 horizontal AI products (name use case, pricing, distribution strategy)
- 5 vertical AI companies (industry, what they do, why they're defensible)
Save to `docs/reading/ai-landscape-map.md`.

**Set 2 — Lab comparison (30 min):**
Compare Anthropic, OpenAI, and Google DeepMind across:
- Safety philosophy
- Business model
- Key partnerships
- Open vs closed research posture
- Where each is strong / weak
Save to `docs/reading/lab-comparison.md`.

**Set 3 — Industry disruption analysis (30 min):**
Pick one industry: legal, healthcare, education, or finance.
- What current workflows are being disrupted by AI?
- Who are the leading AI-native companies in this space?
- What are the biggest barriers (regulatory, trust, data)?
- What does the winning product look like in 5 years?
Save to `docs/reading/vertical-ai-analysis.md`.

**Set 4 — Investment thesis (20 min):**
If you were investing $1M in AI companies today:
- What would you invest in: infrastructure, developer tools, horizontal, or vertical apps?
- What's your thesis? What needs to be true?
- What would make you wrong?
Save to `docs/reading/ai-investment-thesis.md`.

---

## Checks — you understand this when you can:
- [ ] Name 5 frontier AI labs and their key differentiators
- [ ] Describe the AI product stack from compute to application
- [ ] Explain 3 go-to-market patterns for AI companies
- [ ] Explain why model commoditization affects where value accrues
- [ ] Compare vertical vs horizontal AI strategies with examples

---

## Artifacts to commit
- [ ] `docs/reading/ai-landscape-map.md`
- [ ] `docs/reading/lab-comparison.md`
- [ ] `docs/reading/vertical-ai-analysis.md`
- [ ] `docs/reading/ai-investment-thesis.md`
- [ ] Glossary entries: horizontal AI, vertical AI, co-pilot, API-first, commoditization, compute moat
- [ ] Log entry in `docs/log.md`

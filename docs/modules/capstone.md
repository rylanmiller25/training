# Module: Capstone — Portfolio + Synthesis

**Phase:** 6 (Weeks 47–52)  
**Slug:** `capstone`  
**Status:** not started  
**Estimated time:** 15–20 hours (spread across the final weeks)

---

## What it is / how to think about it

The capstone is where everything comes together: you demonstrate what you've learned by shipping something, writing about it, and constructing interview-ready narratives. The goal is a portfolio that proves technical fluency, not just course completion.

**Mental model:** This is your show-don't-tell moment. Anyone can list topics they studied. Employers and collaborators trust demonstrated output: code you shipped, decisions you documented, analysis you published.

---

## Prerequisites
- All prior phases (ideally Phases 1–5 substantially complete)

---

## Deliverables

### 1. Written portfolio (docs/projects/portfolio.md)
A single document that links to and narrates your artifacts. Sections:
- **Who I am + what I built:** 2–3 paragraph narrative
- **Technical projects:** what you built, why, what you learned, link to code
- **Analysis artifacts:** design docs, system designs, case studies you wrote
- **Key concepts I can explain:** 5–10 concepts you understand deeply enough to teach
- **What I want to work on next:** where you want to apply this

### 2. Shipped demos (at least 1–2)
Requirements for each:
- Deployed and accessible (not just local)
- Solves a real problem (even a toy one)
- Has a short README explaining what it does and how
- Code is in this repo under `docs/projects/`

**Demo ideas (pick 1–2):**
- A RAG-powered chatbot over a document set of your choice
- A semantic search tool over a set of articles/notes
- A multi-step LLM agent that does something useful (fetch, reason, respond)
- An AI-assisted product spec generator (input: problem statement → output: structured PRD)
- A simple data analysis pipeline with LLM-generated insights

### 3. Interview-ready narratives
For 5 topics, write a 200-word narrative you could deliver verbally:
1. **"Walk me through how you'd build an AI feature from scratch"** — cover: use case selection, prompt design, eval, HITL, monitoring
2. **"What are the most important failure modes to watch for in LLM systems?"** — hallucination, prompt injection, sycophancy, context failures
3. **"How would you evaluate whether an AI feature is working in production?"** — metrics, evals, user feedback, drift detection
4. **"How do you think about the cost/quality tradeoff in model selection?"** — tiers, cost calculation, when to use smaller models
5. **"Tell me about a technical project you worked on"** — pick one of your demos; explain the problem, your approach, what you learned

Save narratives to `docs/projects/interview-narratives.md`.

### 4. Concept glossary review
Review `docs/glossary.md` — fill in any missing terms. Ensure you can define every entry in your own words without reading it.

---

## Capstone project brief (choose one)

### Option A: AI Document Intelligence Tool
Build a system that:
- Accepts a set of documents (upload or paste)
- Answers questions about them (RAG)
- Generates a structured summary with key facts, action items, open questions
- Deploys as a Vercel/Railway app with a simple UI

Tech: TypeScript, Anthropic SDK, Vercel AI SDK, pgvector or ChromaDB

### Option B: AI-Assisted PRD Generator
Build a tool that:
- Takes a problem statement as input
- Generates a structured PRD (goals, non-goals, user stories, requirements, metrics)
- Allows iterative refinement via chat
- Outputs as Markdown

Tech: TypeScript, Anthropic SDK, streaming responses, markdown rendering

### Option C: AI Research Assistant
Build a system that:
- Takes a research question
- Searches a knowledge base (pre-indexed articles or your own reading notes)
- Synthesizes an answer with citations
- Highlights uncertainty and gaps

Tech: TypeScript, embeddings, vector search, streaming

---

## Timeline (spread across Weeks 47–52)

| Week | Focus |
|------|-------|
| 47 | Choose demo project; start building |
| 48 | Complete demo; write README |
| 49 | Write portfolio narrative |
| 50 | Write interview narratives (5) |
| 51 | Deploy demo; polish all artifacts |
| 52 | Review + reflection; update curriculum map with all statuses; share |

---

## Checks — you understand this when you can:
- [ ] Ship and deploy at least one AI-powered demo
- [ ] Narrate your technical work in a 5-minute verbal explanation
- [ ] Answer: "how would you build X?" for any of the 5 interview prompts
- [ ] Point to artifacts in this repo as evidence for claimed skills
- [ ] Identify 3 things you'd do differently if starting over

---

## Artifacts to commit
- [ ] `docs/projects/portfolio.md`
- [ ] `docs/projects/interview-narratives.md`
- [ ] One deployed demo with README (under `docs/projects/<demo-slug>/`)
- [ ] Final update to `docs/curriculum-map.md` with all module statuses
- [ ] Final update to `docs/log.md` with year-end reflection

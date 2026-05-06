# Phase 5 Plan: AI Product Engineering

**Goal:** Build and operate real AI features. Everything in this phase is hands-on. You should be shipping code and deploying things.

**Modules:**
1. `prompt-eng` — the foundation of all LLM product work
2. `rag` — the most common production AI pattern
3. `hitl` — how you keep humans in the loop
4. `ai-telemetry` — how you know if it's working in production
5. `red-teaming` — how you stress-test before shipping
6. `model-selection` — how you pick the right model and platform
7. `langchain` — the dominant framework for LLM applications
8. `huggingface` — the open-source model ecosystem
9. `keystroke` — production AI agent platform (TypeScript-native, MCP-integrated)
10. `openclaw` — local autonomous agent for hands-on study
11. `intelligent-ui` — building AI-powered adaptive and predictive interfaces

Start with `prompt-eng` — everything else builds on the ability to write reliable prompts. After that, `rag` and `model-selection` should come before `langchain`. Do `keystroke` after `langchain` — it's the production layer on top of the patterns you'll have learned. Do `openclaw` after `red-teaming` and `hitl` — you'll apply those frameworks directly against a running agent.

---

## Module-by-module approach

### prompt-eng
**Do this first. Every other module assumes you can write a reliable prompt.**

1. Read the Anthropic and OpenAI guides — both, not just one. They complement each other.
2. Exercise Set 1 (prompt debugging) — start with a deliberately bad prompt and improve it iteratively. Keep every version. The iteration record is the learning.
3. Exercise Set 2 (few-shot design) — build the support ticket classifier. Test it on edge cases intentionally.
4. Exercise Set 3 (chain-of-thought experiment) — run the same question 3 ways. The difference is often striking.
5. Exercise Set 4 (structured output pipeline) — this is the capstone. A prompt that reliably returns valid JSON is an engineering artifact, not just a query.

What you're building toward: prompts that you can version, test, and ship with confidence.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/EXPLANATION-PROMPTS.md`. These are the prompts that translate causal forest output into plain-English insights for founders. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### rag
**After prompt-eng and embeddings (Phase 4).**

1. Read the pipeline overview before anything else. Indexing → retrieval → generation. Know where each failure mode lives.
2. Exercise Set 1 (basic RAG pipeline) — build it yourself first, without a framework. This is more important than it sounds. Understanding what LangChain is doing for you requires having done it manually.
3. Exercise Set 2 (chunking experiment) — actually compare chunking strategies. The right chunk size is task-dependent; experiencing this firsthand matters.
4. Exercise Set 3 (faithfulness eval) — manually check 10 outputs. What % hallucinate beyond the context? This calibrates your intuition for what "good RAG" looks like.
5. Exercise Set 4 (design a production RAG system) — the design doc is the artifact. Write it for a realistic scenario.

### hitl
**After llm-failures (Phase 4) — you need to know what you're guarding against.**

1. Read the Microsoft and Google PAIR resources before doing any exercises.
2. Exercise Set 1 (design a workflow) — this is the main exercise. Pick a real use case you care about.
3. Exercise Set 2 (incident analysis) — the AI Incident Database is sobering. Spend time here.
4. Exercise Set 3 (interface critique) — look at a real AI-assisted tool. Use the 18 Microsoft principles as a lens.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/HITL-DESIGN.md`. Design the human review gates for high-stakes experiment recommendations on the platform. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### ai-telemetry
**After hitl — monitoring is the production companion to HITL design.**

1. Read the LangSmith and Langfuse docs overviews before exercises.
2. Exercise Set 1 (instrument a simple app) — add logging to your RAG project from the rag module. See what real traces look like.
3. Exercise Set 2 (monitoring dashboard design) — write the design doc. The specific metrics you choose reveal your understanding.
4. Exercise Set 3 (failure triage) — write 5 sample outputs yourself and categorize them. The act of labeling sharpens your ability to recognize failure categories.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/ML-TELEMETRY-PLAN.md`. Design the telemetry strategy for the platform's ML components. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### red-teaming
**After llm-failures and prompt-eng.**

1. Read the Microsoft and Anthropic red-teaming resources.
2. Exercise Set 1 (jailbreak attempts) — structured adversarial testing. Document what works and what doesn't.
3. Exercise Set 2 (indirect injection) — build the system, inject the attack. This is an important pattern to experience concretely.
4. Exercise Set 3 (red-team your own feature) — pick something you've built in this phase. This is the most valuable exercise.
5. Exercise Set 4 (safety report) — read a real model safety report. Compare their methodology to what you just did.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/RED-TEAM-REPORT.md`. Red-team the platform's ML outputs specifically — the causal forest and explanation features you're building. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### model-selection
**Can be done any time after Phase 4 — independent of other Phase 5 modules.**

1. Read the Artificial Analysis site and the LMSYS Arena methodology.
2. Exercise Set 1 (model comparison) — actually run the same 10 inputs through 3 models. Use something you actually care about evaluating.
3. Exercise Set 2 (cost model) — build a spreadsheet. The calculation should feel mechanical by the end.
4. Exercise Set 3 (compliance check) — research the DPA and HIPAA BAA questions. These come up constantly in enterprise sales.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/MODEL-SELECTION.md`. Select and justify the LLM for the platform's plain-English explanation feature. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### langchain
**After rag — you'll understand what it's abstracting if you've done RAG manually.**

1. Read the LCEL docs before writing any code.
2. Exercise Set 1 (basic LCEL chain) — two chained LLM calls. Simple, but forces you to understand the pipe syntax.
3. Exercise Set 2 (RAG with LangChain) — rebuild your hand-rolled RAG using LangChain. The comparison is the point.
4. Exercise Set 3 (ReAct agent) — the tool-using agent exercise. Watch the intermediate steps in the output.
5. Exercise Set 4 (tradeoff critique) — this written reflection is as important as the code. When would you not use LangChain?

### huggingface
**Can be done any time in Phase 5 — relatively independent.**

1. Explore the Hub first (Exercise Set 1) — browse before you build.
2. Exercise Set 2 (run a model locally) — Google Colab, sentence-transformers. Get something running.
3. Exercise Set 3 (Open LLM Leaderboard) — spend time understanding how the models compare.
4. Exercise Set 4 (deploy a Space) — actually deploy something. A live URL matters.

### keystroke
**After langchain — Keystroke is the production layer on patterns you'll already understand.**

1. Read the Keystroke docs and browse the template library before building anything.
2. Exercise Set 1 (first agent) — get a working agent with a tool before anything else.
3. Exercise Set 2 (workflow with integrations) — build something that connects to GitHub or Slack. Realistic internal tooling.
4. Exercise Set 3 (persistent memory agent) — this is the most conceptually interesting exercise. Observe how the agent behaves differently with cached vs fresh context.
5. Exercise Set 4 (MCP server setup) — connect a Keystroke agent to Claude Code. This is the integration that makes everything click together. Keep this running — you can use it throughout the rest of the program.
6. Exercise Set 5 (red-team) — apply the red-teaming framework to your own agent. You built it; now break it.

Key insight: Keystroke, n8n, and LangChain are solving the same problem at different layers of abstraction and for different audiences. Understanding all three gives you the vocabulary to have an informed opinion about tooling decisions.

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/KEYSTROKE-INTEGRATION.md`. Design a Keystroke agent that monitors platform results and triggers actions — significance alerts, anomaly tickets, weekly status summaries. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### openclaw
**After red-teaming and hitl — you're applying those frameworks to a live agent.**

1. Set up in Docker or a VM — not your primary machine. Read the safety section carefully first.
2. Exercise Set 1 (setup) — get it running and connected to Telegram. Don't skip the sandboxing.
3. Exercise Set 2 (skill exploration) — use it like a real tool for 30 minutes. Let the failures happen naturally.
4. Exercise Set 3 (red-team it) — structured adversarial testing against a running agent. This will be more interesting than the theory.
5. Exercise Set 4 (HITL guardrails) — design the guardrails you wish it had based on what you found.
6. Exercise Set 5 (connect to n8n) — the inter-tool integration exercise. OpenClaw triggers n8n; n8n processes and responds.

### intelligent-ui
**After prompt-eng and hitl — you need both to design AI interfaces responsibly.**

1. Read the Google PAIR guidebook first — it's the practical reference for this module.
2. Exercise Set 1 (critique) — pick a real AI-powered UI and evaluate it against the PAIR principles. Be specific about what fails.
3. Exercise Set 2 (design) — design a predictive feature for a specific use case. Write the design doc before writing any code.
4. Exercise Set 3 (implement) — build the TypeScript ghost text component. Get it working before polishing it.
5. Exercise Set 4 (platform) — design the intelligent UI layer for the experimentation platform. This is the main platform artifact from this module.

Key thing to internalize: every AI surface in a UI is a contract with the user — it implies the AI will be right enough, often enough, for the effort of adopting it to be worth it. The design question is always: what happens when it's wrong?

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/INTELLIGENT-UI-DESIGN.md`. Design the adaptive and predictive UI layer for the results dashboard. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

---

## Phase 5 is complete when:
- [ ] All eleven modules marked `complete` in the curriculum map
- [ ] `docs/projects/structured-output-pipeline/` committed
- [ ] `docs/projects/basic-rag/` committed
- [ ] `docs/projects/HITL-WORKFLOW-DESIGN.md` committed
- [ ] `docs/projects/telemetry-demo/` committed
- [ ] `docs/projects/RED-TEAM-REPORT.md` committed
- [ ] `docs/projects/MODEL-COMPARISON.md` committed
- [ ] `docs/projects/langchain-rag/` committed
- [ ] `docs/projects/HF-SPACE-DEMO.md` committed (with live URL)
- [ ] `docs/projects/KEYSTROKE-MCP-SETUP.md` committed (Keystroke → Claude Code MCP connection working)
- [ ] `docs/projects/KEYSTROKE-RED-TEAM.md` committed
- [ ] `docs/projects/OPENCLAW-RED-TEAM.md` committed
- [ ] `docs/reading/OPENCLAW-HITL-DESIGN.md` committed
- [ ] `docs/projects/OPENCLAW-N8N-INTEGRATION.md` committed
- [ ] `docs/projects/INTELLIGENT-UI-DEMO/` committed
- [ ] Glossary has entries for: few-shot, chain-of-thought, RAG, chunking, faithfulness, HITL, drift detection, red-teaming, jailbreak, prompt injection, LCEL, ReAct, model card, Keystroke, MCP server, OpenClaw, AgentSkill, durable execution, ghost text, intent modeling, adaptive interface

**Platform artifacts from this phase:**
- [ ] `docs/projects/experimentation_platform/EXPLANATION-PROMPTS.md` (from `prompt-eng`)
- [ ] `docs/projects/experimentation_platform/HITL-DESIGN.md` (from `hitl`)
- [ ] `docs/projects/experimentation_platform/ML-TELEMETRY-PLAN.md` (from `ai-telemetry`)
- [ ] `docs/projects/experimentation_platform/RED-TEAM-REPORT.md` (from `red-teaming`)
- [ ] `docs/projects/experimentation_platform/MODEL-SELECTION.md` (from `model-selection`)
- [ ] `docs/projects/experimentation_platform/KEYSTROKE-INTEGRATION.md` (from `keystroke`)
- [ ] `docs/projects/experimentation_platform/INTELLIGENT-UI-DESIGN.md` (from `intelligent-ui`)

**Next:** Open `docs/phases/PHASE-6.md`

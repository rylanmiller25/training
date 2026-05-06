# Training Program Plan

## What this project is
This repo is a personal, agent-assisted training program to build strong technical fluency for software/tech roles (target: technical PM / product + engineering interface). Background: economics, entrepreneurship, strategy. Goal: become highly knowledgeable (not necessarily specialist-expert) across core software engineering + AI product domains, with enough hands-on practice to talk credibly and ship small systems. Also, side goal is to be able to build a software or AI product and/or to build out research projects on human-AI interaction, social computing, extended reality, mobile and ubiquitous computing, and predictive and intelligent UIs.

## What agents must help produce (deliverables)
Agents should create an ordered curriculum and keep it coherent over time.

- **Curriculum map**: ordered phases, prerequisites, and why the order.
- **Topic modules** (one per topic area) with:
  - **What it is / how to think about it**
  - **Prereqs**
  - **Best resources**: websites + docs + courses + YouTube playlists/videos
  - **Exercises**: small builds, practice tasks, quizzes, writing prompts
  - **Checks**: "you understand this when you can…"
  - **Artifacts**: notes, diagrams, mini-projects committed to this repo
- **Running log**: what was learned, what's next, gaps to revisit.

File conventions for modules:
- `docs/modules/<slug>.md`
- `docs/projects/<slug>.md`
- `docs/reading/<slug>.md`

## Decision rules (ordering + focus)
Agents should prioritize:
- **Compounding foundations first** (command line, git, HTTP/APIs, SQL, basic programming, systems thinking).
- **Practice over passive**: every module has exercises + output artifacts.
- **"Ship" mindset**: connect topics to tickets, code review, CI/CD, deploys, monitoring, and iteration.
- **AI as product + engineering**: not just model trivia—focus on failure modes, evaluation, telemetry, HITL, safety, and economics.

## Curriculum phases (recommended order)
Agents should keep the plan modular; preserve the dependency structure.

### Phase 0: Setup + baseline
- Dev environment, CLI comfort, note-taking system, repo structure, habit loop.
- Start a glossary and "concept map" that gets updated as you learn.

### Phase 1: Engineering fundamentals
Focus: the minimum set that makes everything else easier.
- Linux + command line fluency + shell scripting basics
- Git/GitHub: branches, PRs, code review culture, navigating repos, tracing function calls
- HTTP + APIs (REST), auth patterns, status codes
- SQL: joins, aggregations, window functions; analysis habits
- Tooling: Postman (API exploration), basic debugging workflows

### Phase 2: Shipping software (systems + delivery)
- Docker basics + "why containers exist"
- Cloud fundamentals (AWS/GCP/Azure concepts; compute/storage/networking; billing intuition; serverless)
- CI/CD concepts, automated testing purpose, deployment pipelines
- System design basics: DB vs cache, sync vs async, queues, trade-offs
- Security basics: authn/authz, OAuth/JWT/API keys, common vulns (SQLi/XSS), secure-by-default thinking

### Phase 3: Product craft + business/finance toolkit
- PRDs and product decision-making under uncertainty
- Growth/unit economics: LTV/CAC, magic number, gross margin, unit economics
- Financial statements: read income statement / balance sheet / cash flow; connect to SaaS/AI
- Privacy/compliance basics: GDPR/CCPA, data minimization, privacy-by-design trade-offs

### Phase 4: AI foundations (intuition + evaluation)
Aim: be able to reason about models and their limits, not just recite definitions.
- Transformer intuition, embeddings, multimodal models
- Predictive ML evaluation basics (metrics, leakage, calibration, failure analysis)
- LLM evaluation: benchmarks vs real-world evals; why it's unsolved
- RL, RLHF (conceptual), reward hacking, failure modes
- Inference optimization intuition: latency, batching, caching, streaming trade-offs
- Hallucination/tool misuse/context window management/looping/error propagation

### Phase 5: AI product engineering (build + operate)
- Prompting systematically: structured outputs, few-shot patterns, constitutional prompting
- RAG: when it's right, where it breaks, retrieval/evals, indexing basics
- HITL design: review points, escalation, QA workflows
- Telemetry for AI features: what to log, how to detect drift/failure, feedback loops
- Red-teaming and adversarial testing: stress tests before shipping
- Model selection and platform decisions: cost, reliability, commodity risk, vendor lock-in, compliance
- LangChain/LangGraph (as implementation patterns, not "magic")
- Hugging Face ecosystem: models/datasets/spaces/inference endpoints (conceptual + practical)

### Phase 6: Landscape + capstone synthesis
- AI lab structures: org models, research→product pipelines, current focus areas
- AI product landscape: verticals disrupted, where money flows, go-to-market patterns
- Model economics: training vs inference costs, pricing, scaling laws intuition, commoditization risks
- Vertical vs horizontal AI (strategy + product implications)
- Robotics/embodied AI (survey + "what's hard")
- Capstone: a written portfolio + 1–2 small shipped demos + interview-ready narratives

## Tool/product understanding modules (integrated, not separate "theory")
Agents should teach these tools in the context of shipping workflows.
- Notion: docs-as-product, knowledge base, database views, integrations; connect to GitHub + Cursor + Claude Code workflows
- Figma: design systems, components, handoff, interaction patterns; connect to PRDs + dev workflows
- GitHub: PR workflows, issues, review, actions (CI), release habits
- Postman: API exploration, auth, environments, collections; connect to debugging and system integration

## Topic backlog (normalize into modules)
All topics below have been converted to module files in `docs/modules/`. The curriculum map in `docs/curriculum-map.md` tracks status.

## How agents should find resources
For each module, agents should provide:
- 1–2 **primary** sources (official docs / canonical book/course)
- 2–4 **supporting** sources (blogs, cheat sheets, references)
- 1–3 **YouTube** resources (playlist preferred)
- A short "why these" note (relevance + depth + currency)

## Success criteria (what "done" looks like)
- A coherent ordered curriculum that can be followed module by module.
- A set of modules with exercises and artifacts.
- Demonstrable outputs: mini-projects, notes, diagrams, and a capstone portfolio.

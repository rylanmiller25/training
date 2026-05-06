# Experimentation Platform — Module Roadmap

## How to use this file

Your workflow for each module:
1. Open the phase plan and read the module's approach section
2. Complete the module's exercises (as directed)
3. When you see a `→ Platform artifact` callout in the phase plan, produce that artifact too
4. Commit both the module artifact and the platform artifact before moving on

The phase plans include a `→ Platform artifact` callout at the end of every relevant module section — you won't need to cross-reference this file mid-module. Come here for the full details on what each artifact should contain.

Not every module produces a platform artifact — only the ones listed below are directly applicable to building the platform. The rest build knowledge that feeds into the platform indirectly.

---

---

## Phase 1 — Engineering Fundamentals

| Module | Platform artifact | What to produce |
|---|---|---|
| `http-apis` | `docs/projects/experimentation_platform/API-DESIGN.md` | Design the core platform APIs: experiment assignment endpoint, event ingestion endpoint, results query endpoint. Define request/response shapes. |
| `sql` | `docs/projects/experimentation_platform/DATA-MODEL.md` | Design the database schema: experiments, variants, assignments, events, users, outcomes tables. Think through indexes and query patterns. |
| `postman` | `docs/projects/experimentation_platform/API-COLLECTION.md` | Document a Postman collection for testing the platform API (even if the server isn't built yet — spec-first). |

---

## Phase 2 — Shipping Software

| Module | Platform artifact | What to produce |
|---|---|---|
| `system-design` | `docs/projects/experimentation_platform/SYSTEM-DESIGN.md` | Full system design: event ingestion pipeline, experiment assignment service, causal forest compute layer, results API, frontend. Include architecture diagram (ASCII or Mermaid). |
| `docker` | `src/docker-compose.yml` | Docker Compose setup for local development: platform API, database, ML compute service. |
| `cloud` | `docs/projects/experimentation_platform/DEPLOYMENT-ARCHITECTURE.md` | Deployment architecture: which services run where, how they scale, estimated cloud costs. |
| `cicd` | `src/.github/workflows/` | CI/CD pipeline: lint, type-check, test on PR; deploy on merge to main. |
| `security` | `docs/projects/experimentation_platform/SECURITY-MODEL.md` | Security design: API auth, tenant isolation (one company's experiment data can't leak to another), data retention policy, PII handling in event logs. |
| `n8n` | `docs/projects/experimentation_platform/N8N-WORKFLOWS.md` | Design n8n workflows for: alerting when experiment reaches significance, routing low-quality results to review queue, daily metrics digest. |

---

## Phase 3 — Product Craft + Business

| Module | Platform artifact | What to produce |
|---|---|---|
| `prds` | `docs/projects/experimentation_platform/PRD.md` | Full PRD for the MVP: problem statement, user stories, success metrics, scope, out-of-scope, open questions. |
| `unit-economics` | `docs/projects/experimentation_platform/UNIT-ECONOMICS.md` | Pricing model and unit economics: what to charge, cost per customer, contribution margin, payback period. Consider usage-based vs. seat-based vs. experiment-volume pricing. |
| `privacy-compliance` | `docs/projects/experimentation_platform/PRIVACY-COMPLIANCE.md` | Privacy design: GDPR/CCPA obligations for an experiment platform (user consent for tracking, data subject access requests, right to deletion, cross-border data rules). |
| `figma` | `docs/projects/experimentation_platform/DESIGN-MOCKUPS.md` | Mockups or wireframes for: experiment setup flow, results dashboard, HTE segment view, pre-experiment simulation screen. Link to Figma file. |

---

## Phase 4 — AI Foundations

| Module | Platform artifact | What to produce |
|---|---|---|
| `ml-eval` | `docs/projects/experimentation_platform/ML-EVAL-FRAMEWORK.md` | Evaluation framework for the causal forest layer: how do you know the HTE estimates are reliable? What metrics, what validation strategy, what thresholds trigger a warning to the user? |
| `llm-eval` | `docs/projects/experimentation_platform/LLM-EVAL-PLAN.md` | Evaluation plan for the "explain this result in plain English" feature: what does a good explanation look like? How do you measure it? What failure modes matter most? |
| `inference-opt` | `docs/projects/experimentation_platform/ML-SERVING-DESIGN.md` | Design for serving the causal forest and uplift model at query time: latency targets, batching strategy, caching, model update cadence. |

---

## Phase 5 — AI Product Engineering

| Module | Platform artifact | What to produce |
|---|---|---|
| `prompt-eng` | `docs/projects/experimentation_platform/EXPLANATION-PROMPTS.md` | The prompts that convert causal forest output into plain-English insights for non-technical founders ("Users like Sarah are 2× more likely to convert at $49 than at $99"). Iterate until the explanations are accurate and interpretable. |
| `hitl` | `docs/projects/experimentation_platform/HITL-DESIGN.md` | HITL design for high-stakes experiment decisions: when should the platform require human review before surfacing a recommendation? What does the review interface look like? |
| `ai-telemetry` | `docs/projects/experimentation_platform/ML-TELEMETRY-PLAN.md` | Telemetry plan for the ML components: what to log for each causal forest run, how to detect model drift, alert conditions. |
| `red-teaming` | `docs/projects/experimentation_platform/RED-TEAM-REPORT.md` | Red-team the platform's ML outputs: can you manipulate the causal forest by gaming input data? Can you extract other companies' experiment data? What happens with adversarial inputs to the explanation feature? |
| `model-selection` | `docs/projects/experimentation_platform/MODEL-SELECTION.md` | Which LLM to use for the explanation feature: evaluate on cost, latency, accuracy, and interpretability of output. Document the decision and tradeoffs. |
| `keystroke` | `docs/projects/experimentation_platform/KEYSTROKE-INTEGRATION.md` | Design a Keystroke agent that monitors experiment results and triggers actions: notify team when significance reached, create Linear ticket when anomaly detected, summarize weekly experiment status. |

---

## Phase 6 — Landscape + Capstone

| Module | Platform artifact | What to produce |
|---|---|---|
| `ai-landscape` | `docs/projects/experimentation_platform/COMPETITIVE-ANALYSIS.md` | Competitive landscape: map Optimizely, Statsig, LaunchDarkly, GrowthBook, and academic tools (EconML, CausalML) against this platform's feature set. Where is the white space? |
| `model-economics` | `docs/projects/experimentation_platform/ML-COST-MODEL.md` | Cost model for running causal forests at scale: compute cost per experiment, cost at 10 / 100 / 1000 customers, where the margins break down. |
| `hci-research` | `docs/projects/experimentation_platform/UX-RESEARCH-PLAN.md` | UX research plan: what do you need to learn from early users? Design 3 research sessions — one for setup/onboarding, one for results interpretation, one for the simulation feature. |
| `capstone` | `src/` | The capstone is the platform. By this point you should have: working experiment assignment service, event ingestion, causal forest compute, results API, and the plain-English explanation layer. Ship a working MVP. |

---

## Modules not listed here

The following modules build foundational knowledge that informs the platform but don't produce a platform-specific artifact:
- `cli-linux`, `git-github` — tooling you use throughout, not platform-specific output
- `transformers`, `embeddings`, `rl-rlhf` — background ML knowledge; informs the causal forest design but no direct artifact
- `llm-failures` — informs the red-team and eval work; captured in those artifacts
- `rag`, `langchain`, `huggingface` — useful context; apply judgment during capstone if RAG or a specific model is needed
- `notion` — workflow tool; no platform artifact
- `openclaw`, `robotics` — not applicable to this platform
- `financial-statements` — background knowledge for unit-economics work

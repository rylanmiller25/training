# Curriculum Map

Work through phases in order. Within each phase, the listed dependency order matters — later modules build on earlier ones.

---

## Phase 0: Setup + Baseline
**Goal:** Working environment, repo structure, glossary habit started.  
**No modules — just setup.**

Deliverables:
- `docs/GLOSSARY.md` started
- `docs/LOG.md` started
- This curriculum map understood

**Unlocks:** Phase 1

---

## Phase 1: Engineering Fundamentals
**Prereqs:** Phase 0  
**Dependency order within phase:** CLI → Git → HTTP/APIs → SQL → Experimentation (SQL can run parallel to Git/HTTP; Experimentation requires SQL)

| Module | Slug | Status |
|--------|------|--------|
| Linux + CLI fluency | `cli-linux` | not started |
| Git + GitHub | `git-github` | not started |
| HTTP + REST APIs | `http-apis` | not started |
| Postman | `postman` | not started |
| SQL | `sql` | not started |
| Experimentation + A/B testing | `experimentation` | not started |

**Unlocks:** Phase 2 (containers, cloud, CI/CD all need CLI + Git + APIs as prereqs)

---

## Phase 2: Shipping Software
**Prereqs:** Phase 1  

| Module | Slug | Status |
|--------|------|--------|
| Docker | `docker` | not started |
| Cloud fundamentals | `cloud` | not started |
| CI/CD + testing | `cicd` | not started |
| System design basics | `system-design` | not started |
| Security basics | `security` | not started |
| n8n — workflow automation | `n8n` | not started |
| Advanced SQL + analytics engineering | `advanced-sql` | not started |

**Unlocks:** Phase 3 (product craft) and Phase 4 (AI foundations both need this context)

---

## Phase 3: Product Craft + Business/Finance
**Prereqs:** Phase 1 (can run parallel to Phase 2)

| Module | Slug | Status |
|--------|------|--------|
| PRDs | `prds` | not started |
| Growth + unit economics | `unit-economics` | not started |
| Financial statements | `financial-statements` | not started |
| Privacy + compliance | `privacy-compliance` | not started |
| Notion | `notion` | not started |
| Figma | `figma` | not started |
| Agile methods + team execution | `agile` | not started |
| Program management | `program-management` | not started |
| Technical communication | `technical-communication` | not started |

---

## Phase 4: AI Foundations
**Prereqs:** Phases 1–2

| Module | Slug | Status |
|--------|------|--------|
| Transformer intuition | `transformers` | not started |
| Embeddings + multimodal | `embeddings` | not started |
| Predictive ML evaluation | `ml-eval` | not started |
| LLM evaluation | `llm-eval` | not started |
| RL + RLHF | `rl-rlhf` | not started |
| Inference optimization | `inference-opt` | not started |
| LLM failure modes | `llm-failures` | not started |
| MLOps + ML lifecycle | `mlops` | not started |

**Unlocks:** Phase 5

---

## Phase 5: AI Product Engineering
**Prereqs:** Phase 4

| Module | Slug | Status |
|--------|------|--------|
| Prompt engineering | `prompt-eng` | not started |
| RAG | `rag` | not started |
| HITL design | `hitl` | not started |
| AI telemetry | `ai-telemetry` | not started |
| Red-teaming | `red-teaming` | not started |
| Model selection | `model-selection` | not started |
| LangChain / LangGraph | `langchain` | not started |
| Hugging Face | `huggingface` | not started |
| Keystroke — AI agent platform | `keystroke` | not started |
| OpenClaw — local autonomous agent | `openclaw` | not started |
| Predictive + Intelligent UI | `intelligent-ui` | not started |

---

## Phase 6: Landscape + Capstone
**Prereqs:** Phases 4–5

| Module | Slug | Status |
|--------|------|--------|
| AI product landscape + labs | `ai-landscape` | not started |
| Model economics | `model-economics` | not started |
| AI product strategy | `ai-product-strategy` | not started |
| HCI + research areas | `hci-research` | not started |
| Robotics + embodied AI | `robotics` | not started |
| Social computing | `social-computing` | not started |
| Extended reality (XR) | `extended-reality` | not started |
| Mobile + ubiquitous computing | `mobile-ubiquitous` | not started |
| Research program management | `research-program-management` | not started |
| AI PM interview prep | `ai-pm-interviews` | not started |
| Capstone | `capstone` | not started |

---

## How to navigate
1. Open the phase plan in `docs/phases/PHASE-N.md` for the phase you're starting — it tells you the recommended approach for each module within that phase
2. Mark modules `in progress` when you start, `complete` when all checks are done
3. A module is complete when every check in its "Checks" section is ticked
4. Move to the next module when checks pass — don't rush, don't linger
5. Log what you learned and any gaps in `docs/LOG.md`

## Phase plans
- [Phase 0 — Setup](phases/PHASE-0.md)
- [Phase 1 — Engineering Fundamentals](phases/PHASE-1.md)
- [Phase 2 — Shipping Software](phases/PHASE-2.md)
- [Phase 3 — Product Craft + Business/Finance](phases/PHASE-3.md)
- [Phase 4 — AI Foundations](phases/PHASE-4.md)
- [Phase 5 — AI Product Engineering](phases/PHASE-5.md)
- [Phase 6 — Landscape + Capstone](phases/PHASE-6.md)

---

## Platform artifact index

Every module that produces a platform artifact is listed here. The artifact is produced during the module — not at the end. Full specs for each artifact are in [docs/projects/experimentation_platform/ROADMAP.md](projects/experimentation_platform/ROADMAP.md).

| Phase | Module | Artifact |
|---|---|---|
| 1 | `http-apis` | `docs/projects/experimentation_platform/API-DESIGN.md` |
| 1 | `postman` | `docs/projects/experimentation_platform/API-COLLECTION.md` |
| 1 | `sql` | `docs/projects/experimentation_platform/DATA-MODEL.md` |
| 1 | `experimentation` | `docs/projects/experimentation_platform/EXPERIMENT-METHODOLOGY.md` |
| 2 | `docker` | `src/docker-compose.yml` |
| 2 | `cloud` | `docs/projects/experimentation_platform/DEPLOYMENT-ARCHITECTURE.md` |
| 2 | `cicd` | `src/.github/workflows/` |
| 2 | `system-design` | `docs/projects/experimentation_platform/SYSTEM-DESIGN.md` |
| 2 | `security` | `docs/projects/experimentation_platform/SECURITY-MODEL.md` |
| 2 | `n8n` | `docs/projects/experimentation_platform/N8N-WORKFLOWS.md` |
| 3 | `prds` | `docs/projects/experimentation_platform/PRD.md` |
| 3 | `unit-economics` | `docs/projects/experimentation_platform/UNIT-ECONOMICS.md` |
| 3 | `privacy-compliance` | `docs/projects/experimentation_platform/PRIVACY-COMPLIANCE.md` |
| 3 | `figma` | `docs/projects/experimentation_platform/DESIGN-MOCKUPS.md` |
| 4 | `ml-eval` | `docs/projects/experimentation_platform/ML-EVAL-FRAMEWORK.md` |
| 4 | `llm-eval` | `docs/projects/experimentation_platform/LLM-EVAL-PLAN.md` |
| 4 | `inference-opt` | `docs/projects/experimentation_platform/ML-SERVING-DESIGN.md` |
| 4 | `mlops` | `docs/projects/experimentation_platform/TRAINING-PIPELINE-DESIGN.md` |
| 5 | `prompt-eng` | `docs/projects/experimentation_platform/EXPLANATION-PROMPTS.md` |
| 5 | `hitl` | `docs/projects/experimentation_platform/HITL-DESIGN.md` |
| 5 | `ai-telemetry` | `docs/projects/experimentation_platform/ML-TELEMETRY-PLAN.md` |
| 5 | `red-teaming` | `docs/projects/experimentation_platform/RED-TEAM-REPORT.md` |
| 5 | `model-selection` | `docs/projects/experimentation_platform/MODEL-SELECTION.md` |
| 5 | `keystroke` | `docs/projects/experimentation_platform/KEYSTROKE-INTEGRATION.md` |
| 5 | `intelligent-ui` | `docs/projects/experimentation_platform/INTELLIGENT-UI-DESIGN.md` |
| 6 | `ai-landscape` | `docs/projects/experimentation_platform/COMPETITIVE-ANALYSIS.md` |
| 6 | `model-economics` | `docs/projects/experimentation_platform/ML-COST-MODEL.md` |
| 6 | `hci-research` | `docs/projects/experimentation_platform/UX-RESEARCH-PLAN.md` |
| 6 | `capstone` | `src/` — working MVP |

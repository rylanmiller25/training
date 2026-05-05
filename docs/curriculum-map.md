# Curriculum Map

**Program start:** 2026-05-05 | **Target:** 52 weeks

## Phase overview

| Phase | Program weeks | Calendar | Focus |
|-------|---------------|----------|-------|
| 0 | 1 | 2026-W18 | Setup + baseline |
| 1 | 2–6 | 2026-W19–W23 | Engineering fundamentals |
| 2 | 7–12 | 2026-W24–W29 | Shipping software |
| 3 | 13–22 | 2026-W30–W39 | Product craft + business/finance |
| 4 | 23–36 | 2026-W40–W53 | AI foundations |
| 5 | 37–46 | 2027-W01–W10 | AI product engineering |
| 6 | 47–52 | 2027-W11–W16 | Landscape + capstone |

---

## Phase 0 (Week 1): Setup + Baseline
**Goal:** Working environment, note-taking habit, repo structure.
**Modules:** *(none — setup only)*
**Deliverables:** glossary.md started, weekly log started, this curriculum map.
**Unlocks:** Phase 1

---

## Phase 1 (Weeks 2–6): Engineering Fundamentals
**Prereqs:** Phase 0 complete
**Dependency order within phase:**
1. CLI/Linux → (everything else depends on terminal comfort)
2. Git/GitHub → (needed for all artifact commits)
3. HTTP + APIs → (prereq for auth, cloud, product integrations)
4. SQL → (independent; can run parallel to Git/HTTP)

| Module | Slug | Status |
|--------|------|--------|
| Linux + CLI fluency | `cli-linux` | not started |
| Git + GitHub | `git-github` | not started |
| HTTP + REST APIs | `http-apis` | not started |
| SQL | `sql` | not started |
| Postman | `postman` | not started |

**Unlocks:** Phase 2 (containers, cloud, CI/CD need CLI + Git + APIs as prereqs)

---

## Phase 2 (Weeks 7–12): Shipping Software
**Prereqs:** Phase 1 complete
**Topics:** Docker, cloud fundamentals, CI/CD, system design basics, security basics

| Module | Slug | Status |
|--------|------|--------|
| Docker | `docker` | not started |
| Cloud fundamentals | `cloud` | not started |
| CI/CD + testing | `cicd` | not started |
| System design basics | `system-design` | not started |
| Security basics | `security` | not started |

---

## Phase 3 (Weeks 13–22): Product Craft + Business/Finance
**Prereqs:** Phase 1 (can overlap with Phase 2)
**Topics:** PRDs, growth metrics, financial statements, privacy/compliance

| Module | Slug | Status |
|--------|------|--------|
| PRDs | `prds` | not started |
| Growth + unit economics | `unit-economics` | not started |
| Financial statements | `financial-statements` | not started |
| Privacy + compliance | `privacy-compliance` | not started |
| Notion | `notion` | not started |
| Figma | `figma` | not started |

---

## Phase 4 (Weeks 23–36): AI Foundations
**Prereqs:** Phases 1–2
**Topics:** Transformers, embeddings, eval, RL/RLHF, inference, failure modes

| Module | Slug | Status |
|--------|------|--------|
| Transformer intuition | `transformers` | not started |
| Embeddings + multimodal | `embeddings` | not started |
| LLM evaluation | `llm-eval` | not started |
| Predictive ML eval | `ml-eval` | not started |
| RL + RLHF | `rl-rlhf` | not started |
| Inference optimization | `inference-opt` | not started |
| Failure modes | `llm-failures` | not started |

---

## Phase 5 (Weeks 37–46): AI Product Engineering
**Prereqs:** Phase 4
**Topics:** Prompting, RAG, HITL, telemetry, red-teaming, model selection, LangChain, Hugging Face

| Module | Slug | Status |
|--------|------|--------|
| Prompt engineering | `prompt-eng` | not started |
| RAG | `rag` | not started |
| HITL design | `hitl` | not started |
| AI telemetry | `ai-telemetry` | not started |
| Red-teaming | `red-teaming` | not started |
| Model selection | `model-selection` | not started |
| LangChain/LangGraph | `langchain` | not started |
| Hugging Face | `huggingface` | not started |

---

## Phase 6 (Weeks 47–52): Landscape + Capstone
**Prereqs:** Phases 4–5
**Topics:** AI lab structures, product landscape, model economics, robotics, capstone

| Module | Slug | Status |
|--------|------|--------|
| AI lab structures | `ai-labs` | not started |
| AI product landscape | `ai-landscape` | not started |
| Model economics | `model-economics` | not started |
| Vertical vs horizontal AI | `ai-strategy` | not started |
| Robotics/embodied AI | `robotics` | not started |
| HCI + research areas | `hci-research` | not started |

---

## Integrated tool modules (woven throughout)
- `postman` — taught during Phase 1 (HTTP/APIs)
- `notion` — taught during Phase 3
- `figma` — taught during Phase 3
- `github-workflows` — taught during Phase 1, deepened in Phase 2

## How to update status
Change `not started` → `in progress` → `complete` as you work through each module. Update the running log at `docs/log.md`.

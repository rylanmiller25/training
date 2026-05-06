# Module: MLOps and the ML Lifecycle

**Phase:** 4  
**Slug:** `mlops`  
**Status:** not started  

---

## What it is / how to think about it

MLOps is the set of practices, tools, and infrastructure that take a machine learning model from research notebook to production system — and keep it running reliably afterward. It's the operational discipline that makes ML engineering different from software engineering.

**Mental model:** Software engineering has a relatively stable deployment lifecycle: write code, test, deploy, monitor. ML adds a second lifecycle layered on top — the *model lifecycle*: collect data, train, evaluate, deploy, monitor for drift, retrain. The model lifecycle runs in parallel with the software lifecycle and creates new coordination problems: who owns the training pipeline, how does a new model version get promoted, who decides when to retrain?

For a TPM at an AI lab, MLOps knowledge serves two purposes: (1) you need to understand what the ML engineering team is doing so you can identify risks and dependencies, and (2) you'll often own the coordination of research-to-production handoffs, which is fundamentally an MLOps problem.

---

## Prerequisites
- `transformers`, `ml-eval`, `inference-opt` — this module assumes you understand models, evaluation metrics, and serving
- `docker`, `cicd` — MLOps pipelines are containerized; CI/CD patterns apply

---

## Best resources

**Primary:**
1. [Machine Learning Engineering — Andriy Burkov](http://www.mlebook.com/) — free PDF; the most practical ML engineering book; chapters 1–3 and 7–9 are most relevant
2. [Weights & Biases documentation — W&B](https://docs.wandb.ai/guides) — the hands-on experiment tracking tool; read "Runs," "Artifacts," and "Model Registry" sections
3. [Hidden Technical Debt in ML Systems — Sculley et al. (2015)](https://papers.nips.cc/paper/2015/file/86df7dcfd896fcaf2674f757a2463eba-Paper.pdf) — the canonical paper; 10 pages; required reading for any ML practitioner

**Supporting:**
- [Full Stack Deep Learning — course](https://fullstackdeeplearning.com/) — free course covering the full ML production lifecycle
- [Chip Huyen's MLOps blog](https://huyenchip.com/) — practical, opinionated writing on production ML
- [MLflow documentation](https://mlflow.org/docs/latest/index.html) — the open-source alternative to W&B; widely used in research settings
- [Evidently AI blog on data drift](https://www.evidentlyai.com/blog) — the best resource for understanding drift detection

**YouTube:**
- [MLOps — Machine Learning Operations — Caltech](https://www.youtube.com/watch?v=7jKTofl2vmM) (45 min overview)
- [Weights & Biases tutorial — W&B](https://www.youtube.com/watch?v=krFicMl5B4k) (30 min hands-on)

---

## Core concepts to cover

### The ML lifecycle

```
Data collection
    ↓
Data preprocessing / feature engineering
    ↓
Model training
    ↓
Evaluation (offline metrics: accuracy, RMSE, AUC, etc.)
    ↓
Serving / deployment
    ↓
Monitoring (online metrics: latency, data drift, prediction drift)
    ↓
Retrain trigger → back to training
```

Each stage has tooling, ownership questions, and failure modes. The most common production failure isn't a bug in the model — it's a silent failure in one of these stages (corrupted data, drift that isn't detected, a stale model serving predictions on shifted inputs).

### Experiment tracking

Training an ML model involves thousands of decisions: hyperparameters, dataset version, preprocessing steps, architecture changes. Without tracking, it's impossible to reproduce a result or understand what changed between a good and bad run.

**Weights & Biases (W&B)** and **MLflow** both solve this:
- Log metrics (loss, accuracy) across training runs
- Store artifacts (trained model files, datasets, evaluation reports)
- Compare runs side by side
- Tag the "best" run for promotion to production

The **model registry** is the critical concept: it's the curated list of models that have passed evaluation and are approved for serving. Promotion from "experiment" to "registered model" to "production" is a deliberate, auditable step.

### Feature stores

A **feature store** is a shared data layer that serves pre-computed features to both training pipelines and serving systems. The key problem it solves: **training-serving skew**.

Training-serving skew occurs when the features computed during training differ (even slightly) from the features computed at serving time. This causes models to perform differently in production than in evaluation — often silently.

Feature stores solve this by computing features once and serving the same version to both contexts. At research lab scale, this becomes critical: many models may share features, and centralized consistency matters.

Common tools: Feast, Tecton, Vertex AI Feature Store.

### Model versioning and lineage

Every trained model should have traceable lineage:
- What training data (version, date range, preprocessing steps)?
- What hyperparameters?
- What evaluation scores?
- Who approved promotion to production?

Without lineage, debugging production failures is extremely difficult. If a model starts producing bad predictions, you need to know: what changed?

Git handles code versioning. MLflow/W&B handle model versioning. Data versioning (for datasets) is handled by tools like DVC or by timestamped S3 buckets.

### Training pipelines and orchestration

A **training pipeline** is an automated sequence of steps:
1. Pull training data from the data warehouse
2. Run preprocessing and feature engineering
3. Train the model
4. Evaluate against held-out test set
5. If evaluation passes: push model artifact to the registry
6. Optionally: trigger deployment

Orchestration tools run these pipelines reliably on schedules or on triggers (e.g., new data arrival):
- **Kubeflow Pipelines** — Kubernetes-native; used at Google/GCP
- **Vertex AI Pipelines** — Google's managed version
- **Apache Airflow** — general-purpose pipeline orchestrator; widely used
- **Metaflow** — Netflix's open-source ML pipeline tool

For a causal forest model, the training pipeline runs when: new experiment data arrives, the model drifts beyond a threshold, or the team manually triggers a retrain.

### Model serving infrastructure

See also the `inference-opt` module for serving optimization. The MLOps angle:

- **Online serving:** model is loaded into memory and responds to real-time API requests; latency-sensitive
- **Batch inference:** model runs on a large dataset and outputs predictions to storage; throughput-sensitive; not latency-sensitive
- **Shadow deployment:** new model runs in parallel with the production model but its predictions are not shown to users; lets you compare behavior before committing
- **Canary deployment:** route a small percentage of traffic (5%, 10%) to the new model version before full rollout; roll back if metrics degrade
- **A/B testing a model:** deliberately route traffic to two model versions and measure downstream business metrics; not just offline accuracy

### Data and model drift

**Data drift:** the distribution of incoming data changes over time. Example: a causal forest trained on experiments from Q1 receives Q3 data where user demographics have shifted.

**Concept drift (model drift):** the relationship between features and the target changes. Example: user behavior that predicted conversion in 2023 no longer predicts conversion in 2025.

**Detection approaches:**
- Population Stability Index (PSI) — measures distribution shift for individual features
- Kolmogorov-Smirnov test — statistical test for distribution change
- Monitor prediction confidence distributions over time — if the model becomes less confident on average, the inputs have drifted
- Monitor downstream business metrics — ultimately, if the model is drifting, the business metrics it was optimized for should degrade

**Response:**
- Alert on drift threshold breaches
- Trigger retraining pipeline
- Escalate to the ML team if drift is unexpected (may indicate a data pipeline bug rather than natural drift)

### ML technical debt (the Sculley taxonomy)

The [Hidden Technical Debt in ML Systems](https://papers.nips.cc/paper/2015/file/86df7dcfd896fcaf2674f757a2463eba-Paper.pdf) paper categorizes the debt unique to ML systems:

- **Boundary erosion:** dependencies between ML components are often implicit; changing one model can silently break another
- **Undeclared consumers:** downstream systems consuming model outputs without being registered as dependents
- **Data dependencies:** ML systems are tightly coupled to their training data; data schema changes break models
- **Pipeline jungles:** preprocessing pipelines grow organically into unmaintainable tangles
- **Glue code:** most of a real ML system is glue code that connects components, not the model itself
- **Configuration debt:** hyperparameters, thresholds, and flags proliferate without governance
- **Feedback loops:** when a model's outputs influence future training data (recommendation systems, fraud detection)

A TPM working on an ML program should be able to identify these risks and ask the right questions during design reviews.

### Research-to-production handoff

The hardest transition in ML. Research models are built to maximize offline metrics in a clean environment. Production models must:
- Handle adversarial / noisy inputs
- Serve with latency and cost constraints
- Run reliably for months without retraining
- Be explainable enough for debugging
- Be auditable for compliance

The handoff requires explicit agreement on: what does "production-ready" mean? Who owns the model in production? What's the retraining SLA? What's the rollback procedure?

TPMs own this coordination. The research team says "the model is ready." The ML engineering team asks "ready according to what criteria?" The TPM makes sure those criteria were written down before work began.

---

## Exercises

**Set 1 — Experiment tracking setup (60 min):**
Create a free Weights & Biases account. Run a minimal experiment: train a simple scikit-learn model (use any tabular dataset — iris, breast cancer, or anything you have) and log: training loss, evaluation accuracy, the hyperparameters used, and the trained model artifact.
Take a screenshot of your W&B run page. Save notes on what the interface shows to `docs/reading/WANDB-EXERCISE.md`.

**Set 2 — ML lifecycle diagram (45 min):**
Draw the full ML lifecycle for the **causal forest component** of the experimentation platform. Include:
- Where does training data come from?
- What triggers retraining? (schedule, drift threshold, manual trigger?)
- What evaluation criteria must pass before the model can be promoted to production?
- Who approves promotion? (ML team, TPM sign-off, automated gate?)
- What's the rollback procedure if the new model performs worse in production?
Save to `docs/reading/ML-LIFECYCLE-DIAGRAM.md`.

**Set 3 — Read the Sculley paper (45 min):**
Read [Hidden Technical Debt in ML Systems](https://papers.nips.cc/paper/2015/file/86df7dcfd896fcaf2674f757a2463eba-Paper.pdf). Write a 5-bullet summary. Then: which 3 of the debt types are the experimentation platform most at risk for, and why?
Save to `docs/reading/ML-DEBT-ANALYSIS.md`.

**Set 4 — Model deployment workflow (45 min):**
Design a model deployment workflow for the causal forest. Write a step-by-step process answering:
- How does a new model version move from training to staging to production?
- What automated checks run before promotion? (e.g., accuracy above X, latency under Y ms)
- What percentage of traffic gets the canary version? For how long?
- What triggers a rollback? Who can initiate it?
Save to `docs/reading/MODEL-DEPLOYMENT-WORKFLOW.md`.

---

## Checks — you understand this when you can:
- [ ] Trace an ML model through the full lifecycle from data collection to production monitoring
- [ ] Explain what W&B or MLflow is used for and what problem they solve
- [ ] Explain training-serving skew and how a feature store addresses it
- [ ] Identify 3 types of ML technical debt from the Sculley paper and give a concrete example of each
- [ ] Explain the difference between data drift and concept drift
- [ ] Design a shadow or canary deployment for a model update

---

## Artifacts to commit
- [ ] `docs/reading/WANDB-EXERCISE.md`
- [ ] `docs/reading/ML-LIFECYCLE-DIAGRAM.md`
- [ ] `docs/reading/ML-DEBT-ANALYSIS.md`
- [ ] `docs/reading/MODEL-DEPLOYMENT-WORKFLOW.md`
- [ ] Platform artifact: `docs/projects/experimentation_platform/TRAINING-PIPELINE-DESIGN.md`
- [ ] Glossary entries: MLOps, experiment tracking, model registry, feature store, training-serving skew, data drift, concept drift, canary deployment, shadow deployment, pipeline orchestration
- [ ] Log entry in `docs/LOG.md`

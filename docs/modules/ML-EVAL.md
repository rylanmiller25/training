# Module: Predictive ML Evaluation Basics

**Phase:** 4  
**Slug:** `ml-eval`  
**Status:** not started  

---

## What it is / how to think about it

Predictive ML is about building models that output a prediction from structured inputs — spam/not-spam, churn probability, recommended items. Understanding evaluation tells you when a model is actually useful vs when it just looks good on paper.

**Mental model:** A model is a black box that takes inputs and outputs predictions. Evaluation is asking: how often is it right? How often does it miss? Are the errors costly? These questions have different answers depending on whether you care more about precision or recall, false positives or false negatives.

---

## Prerequisites
- SQL module (data intuition)

---

## Best resources

**Primary:**
1. [Scikit-learn: Model evaluation](https://scikit-learn.org/stable/modules/model_evaluation.html) — authoritative reference
2. [Google ML Crash Course](https://developers.google.com/machine-learning/crash-course) — free, visual, covers all basics

**Supporting:**
- [Confusion Matrix explained – Towards Data Science](https://towardsdatascience.com/understanding-confusion-matrix-a9ad42dcfd62)
- [ROC/AUC explained – Jay Alammar](https://jalammar.github.io/visual-information-theory/)

**YouTube:**
- [Confusion Matrix, Precision, Recall – StatQuest](https://www.youtube.com/watch?v=Kdsp6soqA7o) (12 min — best visual explanation)
- [ROC and AUC – StatQuest](https://www.youtube.com/watch?v=4jRBRDbJemM) (16 min)

---

## Core concepts to cover

### The confusion matrix
For binary classification (positive/negative):

|  | Predicted Positive | Predicted Negative |
|--|--|--|
| **Actual Positive** | True Positive (TP) | False Negative (FN) |
| **Actual Negative** | False Positive (FP) | True Negative (TN) |

### Key metrics
- **Accuracy:** (TP + TN) / total — misleading on imbalanced data
- **Precision:** TP / (TP + FP) — of things labeled positive, how many actually were?
- **Recall (Sensitivity):** TP / (TP + FN) — of all actual positives, how many did we catch?
- **F1 Score:** harmonic mean of precision and recall — useful when you care about both
- **Specificity:** TN / (TN + FP) — of all actual negatives, how many did we correctly label?

### Precision vs recall tradeoff
- Raising your decision threshold increases precision, decreases recall
- Lowering it increases recall, decreases precision
- **Which to optimize:** depends on cost of errors
  - Medical diagnosis: prefer high recall (missing a disease is worse than a false alarm)
  - Spam filter: prefer high precision (deleting a real email is worse than missing spam)

### ROC curve + AUC
- Plot: True Positive Rate (recall) vs False Positive Rate at all thresholds
- AUC (Area Under Curve): 0.5 = random; 1.0 = perfect; > 0.8 = good for most tasks
- Better than accuracy for imbalanced classes
- Use: compare models regardless of threshold choice

### Overfitting and generalization
- **Overfitting:** model performs well on training data but poorly on new data (memorized, didn't learn)
- **Underfitting:** model too simple; performs poorly on both training and test data
- **Train/val/test split:** train model on training set; tune on validation; evaluate on test (never touch test during development)
- **Cross-validation:** split data into k folds; train on k-1, validate on 1, rotate; average results

### Data leakage
- When information from the future or target leaks into training features
- Example: including "days until churn" as a feature to predict churn
- Example: normalizing data before train/test split (test stats leak into training)
- Causes misleadingly high eval metrics; model fails in production
- Prevention: always split before any data transformation

### Calibration
- A well-calibrated model that says "80% probability" is right 80% of the time
- Poorly calibrated: model says 80% but is right only 50% of the time
- Important for: probability-based decisions (pricing, medical risk, fraud)
- Check with reliability diagrams or calibration curves

### Class imbalance
- When one class is much rarer (e.g. fraud: 0.1% of transactions)
- Accuracy is useless (predicting "not fraud" always gives 99.9% accuracy)
- Solutions: oversample the minority class (SMOTE), undersample majority, use class weights, evaluate with precision-recall instead of ROC

---

### Causal forests and treatment effect estimation

Standard predictive ML answers: given these inputs, what will the outcome be? Causal inference asks a different question: given these inputs, how much does a treatment *change* the outcome?

This distinction is central to Panel. Predicting whether a user will convert is predictive ML. Estimating whether the $99 plan *causes* more conversion than the $49 plan — and whether that effect is larger for technical founders than non-technical ones — is causal inference.

**The key concept — heterogeneous treatment effects (HTE):**
A treatment effect is heterogeneous when it varies across individuals. The average treatment effect (ATE) hides this. A causal forest estimates individual-level treatment effects and reveals where the treatment works and where it doesn't — the core capability behind Panel's Pro tier.

**How causal forests work:**
A causal forest is an ensemble of causal trees. Each tree splits users into subgroups where treatment effects are internally similar, then estimates the effect within each leaf. Unlike a standard random forest (which minimizes prediction error), a causal forest minimizes treatment effect estimation error.

Key design property — **honest estimation:** the data used to determine tree structure is kept separate from the data used to estimate effects within each leaf. This prevents overfitting and produces valid confidence intervals. Without honesty, the confidence intervals would be too narrow and Panel would overstate result reliability.

**EconML — the library you'll use:**
Microsoft's EconML implements causal forests via `CausalForestDML`. The "DML" stands for Double Machine Learning — it uses two internal models to partial out the effect of covariates on both the outcome and the treatment before estimating the causal effect.

```python
from econml.dml import CausalForestDML
from sklearn.ensemble import GradientBoostingClassifier

model = CausalForestDML(
    model_y=GradientBoostingClassifier(),  # predicts outcome from covariates
    model_t=GradientBoostingClassifier(),  # predicts treatment from covariates
    n_estimators=100,
    min_samples_leaf=10,
    n_jobs=-1  # parallelize across all CPU cores
)
model.fit(Y, T, X=X)

te = model.effect(X)              # individual treatment effect estimates
lb, ub = model.effect_interval(X) # 95% confidence intervals per user
```

Where: `Y` = outcome (converted: 0/1), `T` = treatment assignment (0=control, 1=treatment), `X` = user covariates (plan tier, acquisition channel, session count, etc.)

**Evaluating causal forest outputs:**
Standard ML metrics (precision, recall, AUC) don't apply here. You never observe the counterfactual — you can't know what would have happened to a user under the other treatment. The evaluation methods for causal forests are different:

- **Qini curves (uplift curves):** Sort users by predicted treatment effect (high to low). Apply treatment to the top K% of users and measure cumulative outcome lift vs. random targeting. A model with good HTE estimation concentrates lift at the top — the curve rises steeply before flattening. A random model produces a straight line.
- **AUTOC (Area Under the Targeting Operator Characteristic):** Summarizes the Qini curve in a single number. Analogous to AUC for classification, but for causal targeting quality.
- **Calibration of confidence intervals:** Do the intervals actually contain the true effect the right percentage of the time? Panel's reliability language ("reliable" vs. "too uncertain to act on") depends on whether the intervals are trustworthy, not just wide.
- **Synthetic data validation:** Fit a causal forest on data where you *know* the true treatment effects (because you generated them). Measure recovery error. This is how you verify the model works before deploying it in Panel.

**What a poorly performing causal forest looks like:**
- Qini curve barely beats the random targeting line → the model isn't finding real heterogeneity; the interaction-terms method is probably sufficient
- Confidence intervals too narrow → honesty setting may be misconfigured; Panel would overstate reliability
- Wide intervals on small subgroups → working as intended; surface this as "too uncertain to act on" in the interpretation layer

---

## Exercises

**Set 1 — Confusion matrix practice (20 min):**
Given: 100 cancer screenings. 10 have cancer. Model flags 12 as positive: 8 true positives, 4 false positives.
Calculate: TP, FP, FN, TN, accuracy, precision, recall, F1.
In this context: is a false negative or false positive more costly? What threshold adjustment would you recommend?
Save to `docs/reading/ML-EVAL-EXERCISES.md`.

**Set 2 — Interpret model metrics (30 min):**
A spam filter model reports: accuracy 99%, precision 60%, recall 20%.
- Is this model useful? Why or why not?
- What does recall 20% mean in plain English?
- What would you change to improve recall?
Append to `docs/reading/ML-EVAL-EXERCISES.md`.

**Set 3 — Spot the leakage (20 min):**
Identify the leakage in each scenario:
1. Predicting hospital readmission; features include "discharge diagnosis code" assigned after readmission decision
2. Predicting stock price direction; features include "next day's news sentiment"
3. Predicting customer churn; train/test split done after feature normalization using full dataset
Append to `docs/reading/ML-EVAL-EXERCISES.md`.

**Set 4 — Run a real evaluation (45 min):**
Using Google Colab (free GPU) and scikit-learn:
1. Load the breast cancer dataset (`sklearn.datasets.load_breast_cancer`)
2. Train a logistic regression and a random forest
3. Compare: accuracy, precision, recall, F1, AUC
4. Plot the ROC curve for both models
5. Which would you deploy? Why?
Save notebook to `docs/projects/ml-eval-notebook.ipynb`.

**Set 5 — Run EconML on synthetic experiment data (60 min):**
This exercise validates that you can fit a causal forest and interpret its outputs before relying on it in Panel.

Using Google Colab and EconML (`pip install econml`):
1. Generate synthetic experiment data with known heterogeneous treatment effects:
   - 2,000 users; binary treatment (control/treatment)
   - 3 covariates: `plan_tier` (0=free, 1=pro), `session_count` (continuous), `acquisition_channel` (0=organic, 1=paid)
   - True treatment effect: `0.15` for pro users, `0.03` for free users (so you know the ground truth)
   - Add noise to the outcome
2. Fit a `CausalForestDML` model on the synthetic data
3. Extract individual treatment effect estimates and confidence intervals
4. Compare estimated effects for pro vs. free users to the known ground truth — does the model recover the heterogeneity?
5. Plot a Qini curve: sort users by predicted effect (high to low), compute cumulative lift vs. random targeting, plot both lines
6. What does the shape of the Qini curve tell you about whether the model found real heterogeneity?

Save notebook to `docs/projects/causal-forest-notebook.ipynb`.

**Set 6 — Evaluate reliability signals (30 min):**
Panel's AI interpretation layer uses confidence interval width to decide whether to say "reliable" or "too uncertain to act on." 

Using your fitted model from Set 5:
1. Look at the distribution of confidence interval widths across users. What is the median width? The 90th percentile?
2. Set a threshold: if the interval width is greater than X, label the subgroup result as "unreliable." Choose X and justify it.
3. What percentage of users fall below the reliability threshold?
4. Write two sentences of Panel-style interpretation: one for a reliable subgroup result, one for an unreliable one.

Append to `docs/projects/causal-forest-notebook.ipynb`.

---

## Checks — you understand this when you can:
- [ ] Fill in a confusion matrix from TP/FP/FN/TN and calculate precision and recall
- [ ] Explain when to optimize for precision vs recall (give a real example)
- [ ] Explain what AUC measures and why it's preferred over accuracy on imbalanced data
- [ ] Explain data leakage and give a realistic example
- [ ] Explain what calibration means and why it matters
- [ ] Explain why 99% accuracy can be a meaningless metric
- [ ] Explain the difference between predictive ML and causal inference in one sentence
- [ ] Explain what honest estimation is in a causal forest and why it matters for Panel's reliability signals
- [ ] Explain what a Qini curve shows and how to interpret its shape
- [ ] Set up and fit a CausalForestDML model from EconML on tabular data

---

## Artifacts to commit
- [ ] `docs/reading/ML-EVAL-EXERCISES.md`
- [ ] `docs/projects/ml-eval-notebook.ipynb`
- [ ] `docs/projects/causal-forest-notebook.ipynb`
- [ ] Glossary entries: precision, recall, F1, AUC, ROC, confusion matrix, overfitting, data leakage, calibration, class imbalance, heterogeneous treatment effect, honest estimation, Qini curve, AUTOC, CausalForestDML
- [ ] Log entry in `docs/LOG.md`

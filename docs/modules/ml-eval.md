# Module: Predictive ML Evaluation Basics

**Phase:** 4 (Weeks 23–36)  
**Slug:** `ml-eval`  
**Status:** not started  
**Estimated time:** 5–6 hours

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

## Exercises

**Set 1 — Confusion matrix practice (20 min):**
Given: 100 cancer screenings. 10 have cancer. Model flags 12 as positive: 8 true positives, 4 false positives.
Calculate: TP, FP, FN, TN, accuracy, precision, recall, F1.
In this context: is a false negative or false positive more costly? What threshold adjustment would you recommend?
Save to `docs/reading/ml-eval-exercises.md`.

**Set 2 — Interpret model metrics (30 min):**
A spam filter model reports: accuracy 99%, precision 60%, recall 20%.
- Is this model useful? Why or why not?
- What does recall 20% mean in plain English?
- What would you change to improve recall?
Append to `docs/reading/ml-eval-exercises.md`.

**Set 3 — Spot the leakage (20 min):**
Identify the leakage in each scenario:
1. Predicting hospital readmission; features include "discharge diagnosis code" assigned after readmission decision
2. Predicting stock price direction; features include "next day's news sentiment"
3. Predicting customer churn; train/test split done after feature normalization using full dataset
Append to `docs/reading/ml-eval-exercises.md`.

**Set 4 — Run a real evaluation (45 min):**
Using Google Colab (free GPU) and scikit-learn:
1. Load the breast cancer dataset (`sklearn.datasets.load_breast_cancer`)
2. Train a logistic regression and a random forest
3. Compare: accuracy, precision, recall, F1, AUC
4. Plot the ROC curve for both models
5. Which would you deploy? Why?
Save notebook to `docs/projects/ml-eval-notebook.ipynb`.

---

## Checks — you understand this when you can:
- [ ] Fill in a confusion matrix from TP/FP/FN/TN and calculate precision and recall
- [ ] Explain when to optimize for precision vs recall (give a real example)
- [ ] Explain what AUC measures and why it's preferred over accuracy on imbalanced data
- [ ] Explain data leakage and give a realistic example
- [ ] Explain what calibration means and why it matters
- [ ] Explain why 99% accuracy can be a meaningless metric

---

## Artifacts to commit
- [ ] `docs/reading/ml-eval-exercises.md`
- [ ] `docs/projects/ml-eval-notebook.ipynb`
- [ ] Glossary entries: precision, recall, F1, AUC, ROC, confusion matrix, overfitting, data leakage, calibration, class imbalance
- [ ] Log entry in `docs/log.md`

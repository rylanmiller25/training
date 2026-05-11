# Experiment Metric Design — Panel

**Exercise:** Set 1 from `docs/modules/EXPERIMENTATION.md`  
**Status:** Complete

---

## Panel's North Star metric

**Experiments reaching a reliable, actionable result — per active customer, per month.**

"Reliable" means: significance reached, or the experiment ran its full window without SRM, and the result was accompanied by an honest interpretation. Panel has done its job when a customer gets a result they can actually act on — not just when an experiment runs.

This is distinct from:
- Experiments launched (activity, not value)
- Revenue (a consequence of value, not the value itself)
- Results viewed (a user could view an unreliable result and be misled)

---

## Primary metrics for a typical customer experiment

Panel's customers describe their experiment in natural language. Panel parses the intent and maps it to the right event and metric combination — customers never select from a dropdown. The following are the primary metrics Panel supports:

| Metric | What it measures | Typical experiment type |
|---|---|---|
| **Conversion rate** | Share of users who completed the target action (e.g. upgraded from free to paid) | Pricing, positioning |
| **Retention rate** | Share of users still active after a defined window | Retention, onboarding |
| **Revenue per user** | Average revenue generated per experiment participant | Pricing |
| **Feature adoption rate** | Share of users who used the feature being tested | Product, onboarding |
| **Time to value** | Time from assignment to first meaningful product action | Onboarding |
| **Expansion revenue** | Additional revenue from upgrades, seat additions, or tier changes | Pricing, retention |

The outcome window (how long after assignment an event counts) is configured per experiment — there is no fixed 30-day constraint. A pricing experiment might have a 30-day window; a retention experiment might have a 90-day window.

All metrics are derived from events the customer tracks through Panel's SDK. Every metric above is computable from the `events` table given the right event name and optional property (e.g. `revenue` on the `upgrade_to_paid` event).

---

## Guardrail metrics

Guardrail metrics are floors, not targets. Panel monitors them automatically throughout the experiment. If any guardrail crosses its threshold, the experiment stops — regardless of what the primary metric is doing.

Thresholds are set before the experiment launches and cannot be changed mid-run. Panel provides sensible defaults; customers can override any threshold during experiment setup.

### 1. Churn rate

**What it guards against:** A treatment that improves conversion or revenue but causes users to cancel at a higher rate — winning short-term at the expense of retention.

**Default threshold:** Stop if treatment churn rate exceeds control churn rate by more than **2 percentage points**.

---

### 2. Engagement rate

**What it guards against:** A treatment that keeps users subscribed but makes them less active — "still has an account" and "still getting value" are different things. Engagement is the leading signal; churn is the lagging signal. Catching an engagement drop early prevents a future churn spike.

**Default threshold:** Stop if treatment engagement rate drops more than **15% relative to control**.

---

### 3. Revenue per user

**What it guards against:** For experiments not directly about pricing, a treatment that improves the primary metric while silently depressing revenue — e.g., an onboarding flow that improves completion rate but attracts lower-value users.

**Default threshold:** Stop if treatment revenue per user drops more than **10% relative to control**.

---

## Design note — configurable thresholds

Default thresholds are set by Panel and shown clearly to the customer before launch, with plain-English explanations. Customers can adjust any threshold during experiment setup — a high-churn product might want a tighter churn guardrail, a riskier pricing test might want a wider revenue guardrail.

The threshold values live in the `config` jsonb column on the `experiments` table alongside other statistical config (significance threshold, target power, MDE). This makes them part of the experiment definition — visible, adjustable before launch, and locked once the experiment is running.

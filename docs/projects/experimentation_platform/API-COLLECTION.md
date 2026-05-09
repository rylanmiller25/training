# Panel — Postman Collection

**Status:** Spec-first (server not yet built)  
**Last updated:** 2026-05-09  
**Paired with:** `API-DESIGN.md`

---

## What this is

This document describes the Postman collection for testing the Panel API. The collection is organized by experiment lifecycle — the order you'd actually run requests when verifying that Panel works end-to-end. Use it during development to test each endpoint as it's built, and as a regression suite when making changes.

---

## Setup

### Environment variables

Create a Postman environment called `Panel - Local` (for local development) and `Panel - Production` (for the live API). Set the following variables in each:

| Variable | Description | Example |
|---|---|---|
| `base_url` | API base URL | `http://localhost:3000/v1` (local) or `https://api.panel.com/v1` (prod) |
| `api_key` | Your Panel API key from the dashboard | `pk_live_abc123...` |
| `project_id` | The Panel project you're working in | `proj_xyz789` |
| `experiment_id` | Set this after running the Create Experiment request | `exp_a1b2c3` |
| `user_id` | A test user ID for SDK requests | `user_test_001` |

**How to use:** Every request references these as `{{base_url}}`, `{{api_key}}`, etc. Switch between environments to test locally vs. production without touching individual requests.

**Auth header:** Add the following to the collection-level authorization so every request inherits it automatically:
```
Authorization: Bearer {{api_key}}
```

---

## Collection structure

```
Panel API
├── 1. Setup
│   ├── Parse Experiment Intent
│   ├── Run Pre-Experiment Simulation
│   ├── Create Experiment
│   └── Launch Experiment
├── 2. Results
│   ├── Get ATE Results
│   └── Get HTE Results
├── 3. SDK
│   ├── Get Variant (Assign User)
│   ├── Track Event
│   └── Track Events (Batch)
└── 4. Utilities
    ├── Get Experiment
    ├── List Experiments
    └── Stop Experiment
```

---

## Folder 1: Setup

Run these in order. Each request builds on the previous one.

---

### Parse Experiment Intent

Tests the natural language parsing step. Paste in a plain-English description and verify Panel correctly identifies the experiment type, variants, outcome metric, and subgroups.

**Method:** `POST`  
**URL:** `{{base_url}}/experiments/parse`  
**Body (raw JSON):**
```json
{
  "intent": "We're testing a $49 vs $99 pricing page. The outcome is whether someone upgrades from free to paid within 30 days. I want to know if the price change works differently for technical founders vs. non-technical founders."
}
```

**What a successful response looks like:**
- Status `200`
- `parsed.experimentType` is populated
- `parsed.analysisType` is either `"ate"` or `"hte"`
- `clarificationNeeded` is `false` (or `true` with a sensible question if intent was ambiguous)

**Things to test:**
- Clear intent → should parse without clarification
- Ambiguous intent ("I want to know if this works") → should return `clarificationNeeded: true` with one follow-up question
- Missing outcome metric → should ask for clarification, not guess

---

### Run Pre-Experiment Simulation

Tests the power analysis endpoint. Verify Panel correctly estimates whether a given traffic level is sufficient to detect an effect.

**Method:** `POST`  
**URL:** `{{base_url}}/simulate`  
**Body (raw JSON):**
```json
{
  "expectedDailyUsers": 150,
  "baselineConversionRate": 0.08,
  "minimumDetectableEffect": 0.03,
  "subgroups": [
    { "name": "technical_founders", "expectedShare": 0.6 },
    { "name": "non_technical_founders", "expectedShare": 0.4 }
  ]
}
```

**What a successful response looks like:**
- Status `200`
- `overallTest.reliable` is `true` or `false` with a clear reason
- `recommendation` is one of `run_as_designed`, `wait`, or `redesign`
- `recommendationExplanation` is plain English, not a statistical formula

**Things to test:**
- Low traffic (e.g., 10 daily users) → should return `reliable: false` and recommend waiting
- No subgroups → should return just the overall test result
- Very large MDE → should return a short time-to-result

---

### Create Experiment

Creates a new experiment. After running this, copy the returned `experimentId` into the `experiment_id` environment variable — all subsequent requests use it.

**Method:** `POST`  
**URL:** `{{base_url}}/experiments`  
**Body (raw JSON):**
```json
{
  "name": "Pricing page test — Q2",
  "type": "pricing_sensitivity",
  "variants": [
    { "key": "control", "label": "$49 plan", "weight": 0.5 },
    { "key": "treatment", "label": "$99 plan", "weight": 0.5 }
  ],
  "outcomeMetric": "upgrade_to_paid",
  "outcomeWindow": 2592000,
  "subgroups": ["founder_type"],
  "analysisType": "hte",
  "config": {
    "significanceThreshold": 0.05,
    "targetPower": 0.8,
    "minimumDetectableEffect": 0.05
  }
}
```

**What a successful response looks like:**
- Status `201`
- `experimentId` is present — copy this into `{{experiment_id}}`
- `status` is `"draft"`
- `generatedSdkCode` contains pre-filled assignment and tracking code
- `preExperimentAssessment` includes a plain-English recommendation

**Things to test:**
- Variant weights that don't sum to 1.0 → should return `422`
- Missing `outcomeMetric` → should return `400`
- Duplicate experiment name → decide: error or allow?

---

### Launch Experiment

Changes the experiment status from `draft` to `running`. After this, the SDK assignment endpoint will start returning variants.

**Method:** `POST`  
**URL:** `{{base_url}}/experiments/{{experiment_id}}/launch`  
**Body:** None

**What a successful response looks like:**
- Status `200`
- `status` is `"running"`
- `launchedAt` is a valid timestamp

**Things to test:**
- Launch a draft experiment → should succeed
- Launch an already-running experiment → should return `409`
- Launch with an invalid experiment ID → should return `404`

---

## Folder 2: Results

Run these after the experiment has been running and has collected data. In development, seed the database with test assignment and event data before testing these.

---

### Get ATE Results

Returns the overall average treatment effect with confidence interval and significance.

**Method:** `GET`  
**URL:** `{{base_url}}/experiments/{{experiment_id}}/results`  
**Body:** None

**What a successful response looks like:**
- Status `200`
- `srmDetected` is `false` (if `true`, the results are unreliable — investigate before proceeding)
- `ate.confidenceInterval` has two values (lower and upper bound)
- `ate.significant` is `true` or `false`
- `interpretation` is a plain-English sentence, not a p-value

**Things to test:**
- Experiment with sufficient data → should return a reliable result
- Experiment with insufficient data → should return wide confidence intervals and `significant: false`
- SRM scenario (seed unequal assignment) → should return `srmDetected: true`

---

### Get HTE Results

Returns treatment effects broken down by pre-specified subgroups.

**Method:** `GET`  
**URL:** `{{base_url}}/experiments/{{experiment_id}}/results/hte`  
**Body:** None

**What a successful response looks like:**
- Status `200`
- `subgroups` array has one entry per pre-specified subgroup
- Each entry has its own `ate`, `confidenceInterval`, and `reliable` flag
- `interpretation` for each subgroup is calibrated — uncertain results use hedged language, reliable results use direct language

**Things to test:**
- Subgroup with sufficient data → `reliable: true`, direct interpretation language
- Subgroup with insufficient data → `reliable: false`, hedged interpretation language
- Experiment with no pre-specified subgroups → should return `400` or empty array

---

## Folder 3: SDK

These simulate what the customer's product calls. Use `{{user_id}}` and `{{experiment_id}}` throughout.

---

### Get Variant (Assign User)

Assigns a user to a variant. The same user should always get the same variant (deterministic).

**Method:** `POST`  
**URL:** `{{base_url}}/assign`  
**Body (raw JSON):**
```json
{
  "experimentId": "{{experiment_id}}",
  "userId": "{{user_id}}",
  "attributes": {
    "founderType": "technical",
    "companySize": 12,
    "planTier": "free"
  }
}
```

**What a successful response looks like:**
- Status `200`
- `variant` is one of the experiment's variant keys (`"control"` or `"treatment"`)
- Same user ID always returns the same variant

**Things to test:**
- Same `userId` called 3 times → should return the same variant each time
- `attributes` omitted entirely → should still return a variant (attributes are optional)
- Experiment not yet launched → decide: return an error or a default variant?
- Invalid `experimentId` → should return `404`

---

### Track Event

Records that a user completed the outcome being measured.

**Method:** `POST`  
**URL:** `{{base_url}}/events`  
**Body (raw JSON):**
```json
{
  "userId": "{{user_id}}",
  "event": "upgrade_to_paid",
  "timestamp": "2026-05-09T15:32:00Z",
  "properties": {
    "planChosen": "pro",
    "revenue": 99
  }
}
```

**What a successful response looks like:**
- Status `200`
- `received: true`
- Response is fast — this endpoint should not block

**Things to test:**
- Valid event → should return `received: true` immediately
- `timestamp` omitted → should default to server time
- `properties` omitted → should still succeed
- Unknown `userId` (user never assigned) → decide: accept and store, or reject?

---

### Track Events (Batch)

Sends multiple events in one request. Used by the SDK when buffering events client-side.

**Method:** `POST`  
**URL:** `{{base_url}}/events/batch`  
**Body (raw JSON):**
```json
{
  "events": [
    {
      "userId": "{{user_id}}",
      "event": "upgrade_to_paid",
      "timestamp": "2026-05-09T15:32:00Z"
    },
    {
      "userId": "user_test_002",
      "event": "upgrade_to_paid",
      "timestamp": "2026-05-09T15:33:00Z"
    }
  ]
}
```

**What a successful response looks like:**
- Status `200`
- All events accepted

**Things to test:**
- Batch of 2 events → should succeed
- One valid event + one malformed event → decide: reject all, or accept valid and report errors?
- Empty events array → should return `400`

---

## Folder 4: Utilities

Supporting requests for managing experiments. Use as needed rather than in a fixed sequence.

---

### Get Experiment

Fetches the full configuration and status of an experiment.

**Method:** `GET`  
**URL:** `{{base_url}}/experiments/{{experiment_id}}`

**What to check:** Status reflects current state, all config fields are present.

---

### List Experiments

Returns all experiments in the project.

**Method:** `GET`  
**URL:** `{{base_url}}/experiments?status=running&limit=20`

**Things to test:** Filter by status, verify pagination works with `offset`.

---

### Stop Experiment

Stops a running experiment.

**Method:** `POST`  
**URL:** `{{base_url}}/experiments/{{experiment_id}}/stop`  
**Body (raw JSON):**
```json
{
  "reason": "significance_reached"
}
```

**Things to test:**
- Stop a running experiment → should succeed
- Stop an already-stopped experiment → should return `409`

---

## End-to-end test sequence

To verify Panel works from start to finish, run requests in this order:

1. Parse Experiment Intent
2. Run Pre-Experiment Simulation
3. Create Experiment → copy `experimentId` to `{{experiment_id}}`
4. Launch Experiment
5. Get Variant (run 3–5 times with different `userId` values)
6. Track Event (for the same user IDs)
7. Get ATE Results
8. Get HTE Results
9. Stop Experiment

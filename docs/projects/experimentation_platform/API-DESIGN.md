# Panel — API Design

**Status:** Draft  
**Last updated:** 2026-05-09

---

## Philosophy

The API reflects Panel's core design principle: the platform does the work, the customer does the minimum. Setup should be so easy that a non-technical founder can configure an experiment through a chat interface, and a technical engineer can integrate the SDK in under 10 minutes.

There are two distinct API consumers with different needs:

**Platform API** — called by Panel's own frontend. Handles experiment creation (including natural language parsing), configuration, simulation, results, and interpretation. Can be rich and expressive; only called from the Panel UI.

**Customer SDK API** — called by the customer's product via the SDK. Handles variant assignment and event tracking. Must be extremely simple, fast, and reliable. Called on every user action in the customer's product, potentially millions of times per day.

---

## Setup paths

Every customer goes through the same journey. The platform does as much as possible at each step:

**1. Natural language intent** — the customer describes what they want to learn via the chatbox. Panel identifies what type of experiment they need.

**2. Experiment type selection** — Panel presents the matching experiment type(s) with a plain-language explanation of what each does, what it's best for, and what the defaults are. The customer selects one.

**3. Platform configuration** — Panel generates the full experiment configuration: variant split, outcome metric, significance threshold, subgroup pre-specification. Defaults are shown clearly with plain-language explanations. The customer can accept defaults or override any setting.

**4. Generated integration code** — after configuration, Panel generates the exact two lines of SDK code the customer's engineer needs. Pre-filled with the experiment ID, event name, and variant keys. The engineer copies and pastes — nothing to figure out.

**5. Manual integration (optional)** — for engineers who prefer to wire up the SDK themselves, full API documentation and SDK reference is available.

---

## Base URL

```
https://api.panel.com/v1
```

---

## Authentication

All requests require an API key passed as a header:

```
Authorization: Bearer YOUR_API_KEY
```

API keys are scoped to a project. Customers generate them from the Panel dashboard. The customer-side SDK key (used for assignment and event tracking) is separate from the platform key (used for experiment management) — different permission scopes.

---

## Platform API

These endpoints are called by the Panel frontend. They handle the full experiment lifecycle.

---

### Parse experiment intent

Converts natural language input into a structured experiment configuration. This is the first step in the setup flow — the customer describes what they want to learn, and Panel returns a parsed config for them to review before anything is created.

```
POST /experiments/parse
```

**Request body:**
```json
{
  "intent": "We're testing a $49 vs $99 pricing page. The outcome is whether someone upgrades from free to paid within 30 days. I want to know if the price change works differently for technical founders vs. non-technical founders."
}
```

**Response:**
```json
{
  "parsed": {
    "experimentType": "pricing_sensitivity",
    "treatment": "$99 pricing page",
    "control": "$49 pricing page",
    "outcomeMetric": "upgrade_to_paid",
    "outcomeWindow": "30 days",
    "subgroups": ["founder_type"],
    "analysisType": "hte"
  },
  "clarificationNeeded": false,
  "clarificationQuestion": null,
  "confidence": "high"
}
```

If the intent is ambiguous, `clarificationNeeded` is `true` and `clarificationQuestion` contains the single follow-up question Panel asks.

---

### Create experiment

Creates an experiment from a confirmed parsed configuration. Called after the customer reviews and approves the parsed intent.

```
POST /experiments
```

**Request body:**
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

**Response:**
```json
{
  "experimentId": "exp_a1b2c3",
  "status": "draft",
  "generatedSdkCode": {
    "assignment": "const variant = await panel.getVariant('exp_a1b2c3', { userId });",
    "tracking": "await panel.track(userId, 'upgrade_to_paid');"
  },
  "preExperimentAssessment": {
    "overallResultsReliableIn": "3 weeks",
    "subgroupReliability": {
      "technical_founders": "reliable with 200+ users",
      "non_technical_founders": "may be underpowered — recommend 150+ users"
    },
    "recommendation": "run_as_designed"
  }
}
```

The `generatedSdkCode` field contains the pre-filled integration code the customer copies into their product.

---

### Launch experiment

```
POST /experiments/{experimentId}/launch
```

No request body required. Changes experiment status from `draft` to `running`.

**Response:**
```json
{
  "experimentId": "exp_a1b2c3",
  "status": "running",
  "launchedAt": "2026-05-09T14:00:00Z"
}
```

---

### Stop experiment

```
POST /experiments/{experimentId}/stop
```

**Request body:**
```json
{
  "reason": "significance_reached"
}
```

---

### Get experiment

```
GET /experiments/{experimentId}
```

Returns full experiment configuration and current status.

---

### List experiments

```
GET /experiments
```

**Query parameters:**
- `status` — filter by `draft`, `running`, `stopped`, `complete`
- `limit` — default 20, max 100
- `offset` — for pagination

---

### Pre-experiment simulation

Runs a power analysis given expected traffic and returns what the experiment can and cannot reliably detect. Can be called before an experiment is created — available to anyone, including users who haven't launched an experiment yet.

```
POST /simulate
```

**Request body:**
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

**Response:**
```json
{
  "overallTest": {
    "requiredSampleSize": 1800,
    "estimatedDaysToResult": 12,
    "reliable": true
  },
  "subgroupTests": {
    "technical_founders": {
      "requiredSampleSize": 1100,
      "estimatedDaysToResult": 12,
      "reliable": true
    },
    "non_technical_founders": {
      "requiredSampleSize": 740,
      "estimatedDaysToResult": 21,
      "reliable": "marginal"
    }
  },
  "recommendation": "run_as_designed",
  "recommendationExplanation": "Your overall result will be reliable in about 12 days. The technical founder subgroup is well-powered. The non-technical founder subgroup is marginal — consider running 2 extra weeks if this comparison matters."
}
```

---

### Get results

Returns the overall average treatment effect and statistical summary for a running or completed experiment.

```
GET /experiments/{experimentId}/results
```

**Response:**
```json
{
  "experimentId": "exp_a1b2c3",
  "status": "running",
  "sampleSize": { "control": 842, "treatment": 856 },
  "srmDetected": false,
  "ate": {
    "estimate": 0.034,
    "confidenceInterval": [0.011, 0.057],
    "pValue": 0.004,
    "significant": true
  },
  "interpretation": "The $99 plan drove a 3.4 percentage point increase in 30-day upgrades compared to the $49 plan. This result is reliable — you have enough data to act on it."
}
```

---

### Get HTE results

Returns heterogeneous treatment effects broken down by pre-specified subgroups.

```
GET /experiments/{experimentId}/results/hte
```

**Response:**
```json
{
  "experimentId": "exp_a1b2c3",
  "subgroups": [
    {
      "name": "technical_founders",
      "sampleSize": { "control": 498, "treatment": 512 },
      "ate": {
        "estimate": 0.061,
        "confidenceInterval": [0.031, 0.091],
        "pValue": 0.001,
        "reliable": true
      },
      "interpretation": "Technical founders converted at 6.1 percentage points higher under the $99 plan. This difference is reliable — you have enough data to act on it."
    },
    {
      "name": "non_technical_founders",
      "sampleSize": { "control": 344, "treatment": 344 },
      "ate": {
        "estimate": -0.008,
        "confidenceInterval": [-0.041, 0.025],
        "pValue": 0.63,
        "reliable": false
      },
      "interpretation": "There's no reliable difference for non-technical founders at the $99 price point. Your data is too thin in this segment to draw a conclusion — don't make a pricing decision based on this yet."
    }
  ]
}
```

---

## Customer SDK API

These endpoints are called by the Panel SDK running inside the customer's product. They must be fast (target P99 < 50ms for assignment) and reliable.

---

### Get variant

Assigns a user to a variant for a given experiment. Deterministic — the same user always gets the same variant. Returns immediately from a cached assignment table; does not run statistical computation at request time.

```
POST /assign
```

**Request body:**
```json
{
  "experimentId": "exp_a1b2c3",
  "userId": "user_xyz789",
  "attributes": {
    "founderType": "technical",
    "companySize": 12,
    "planTier": "free"
  }
}
```

All fields in `attributes` are optional. Panel auto-detects device type, country, acquisition channel, and browser from request headers — no customer input required for those dimensions.

**Response:**
```json
{
  "variant": "treatment",
  "experimentId": "exp_a1b2c3"
}
```

---

### Track event

Records that a user completed an outcome event. Lightweight — Panel processes asynchronously.

```
POST /events
```

**Request body:**
```json
{
  "userId": "user_xyz789",
  "event": "upgrade_to_paid",
  "timestamp": "2026-05-09T15:32:00Z",
  "properties": {
    "planChosen": "pro",
    "revenue": 99
  }
}
```

`timestamp` defaults to server time if omitted. `properties` is optional.

**Response:**
```json
{ "received": true }
```

---

### Track events (batch)

For high-volume scenarios — sends multiple events in a single request.

```
POST /events/batch
```

**Request body:**
```json
{
  "events": [
    {
      "userId": "user_xyz789",
      "event": "upgrade_to_paid",
      "timestamp": "2026-05-09T15:32:00Z"
    },
    {
      "userId": "user_abc123",
      "event": "upgrade_to_paid",
      "timestamp": "2026-05-09T15:33:00Z"
    }
  ]
}
```

---

### Auto-detected user attributes

Panel automatically enriches every assignment call with the following attributes derived from request headers — no customer input required:

| Attribute | Source | Example |
|---|---|---|
| `device` | User-Agent | `mobile`, `desktop`, `tablet` |
| `browser` | User-Agent | `chrome`, `safari`, `firefox` |
| `os` | User-Agent | `ios`, `android`, `macos`, `windows` |
| `country` | IP address (GeoIP) | `US`, `GB`, `DE` |
| `region` | IP address (GeoIP) | `California`, `London` |
| `acquisitionChannel` | Referer header | `organic`, `paid`, `referral`, `direct` |
| `newUser` | Panel cookie | `true`, `false` |

These are available as subgroup dimensions for HTE analysis without any additional setup.

---

## Third-party integrations

For customers already tracking users in external analytics tools, Panel can pull user attributes automatically rather than requiring them to pass attributes in the SDK call.

**Supported integrations (planned):**
- **Segment** — pulls user traits from Segment profiles on assignment
- **PostHog** — pulls person properties from PostHog on assignment

When an integration is connected, the `attributes` field in the assign call becomes optional for any attribute already tracked externally.

---

## Error codes

| Code | Meaning |
|---|---|
| `400` | Bad request — malformed JSON or missing required field |
| `401` | Unauthorized — missing or invalid API key |
| `403` | Forbidden — API key doesn't have permission for this operation |
| `404` | Not found — experiment ID doesn't exist |
| `409` | Conflict — experiment already in this state (e.g., launching an already-running experiment) |
| `422` | Unprocessable — request is valid JSON but semantically wrong (e.g., variant weights don't sum to 1.0) |
| `429` | Rate limited — slow down |
| `500` | Server error — something went wrong on Panel's side |

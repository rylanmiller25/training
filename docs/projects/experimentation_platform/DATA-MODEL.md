# Panel — Data Model

**Status:** Draft  
**Last updated:** 2026-05-09

---

## Design principles

- **Multi-tenant by `project_id`:** Every table carries a `project_id`. One customer's data is never accessible to another. All queries are scoped to a project.
- **Runs are discrete:** An experiment can be run multiple times. Each run has its own assignments, events, and computed results. Timestamps make it possible to filter by run or combine across runs.
- **Users are lightweight:** Panel stores a user record per project — just an ID and any known attributes — not a full user account. These are the customer's end users, not Panel accounts.
- **Events are hybrid-schema:** Fixed columns for fields Panel always queries (user, event name, timestamp). A JSONB `properties` column for customer-specific fields that vary by event type.
- **Results are stored, not computed live:** Results are computed at the end of a run (or on demand) and written to the database with a timestamp. Filtering by run or timestamp lets customers analyze one run or combine across runs.

---

## Tables

### `projects`

A project belongs to a customer organization. All other data is scoped to a project.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `organization_id` | `uuid` | The customer organization that owns this project |
| `name` | `text` | Human-readable project name |
| `api_key_hash` | `text` | Hashed API key for SDK authentication |
| `created_at` | `timestamptz` | |

---

### `organizations`

A Panel customer account. One organization can have multiple projects.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `name` | `text` | Company name |
| `plan` | `text` | `free`, `starter`, `pro`, `enterprise` |
| `created_at` | `timestamptz` | |

---

### `experiments`

The experiment definition — what is being tested, how, and with what configuration. An experiment is a template; the actual data lives in runs.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `project_id` | `uuid` | FK → `projects.id` |
| `name` | `text` | Human-readable name |
| `type` | `text` | `pricing_sensitivity`, `onboarding_flow`, `positioning_message`, `retention_intervention`, etc. |
| `analysis_type` | `text` | `ate` or `hte` |
| `outcome_metric` | `text` | The event name being measured (e.g. `upgrade_to_paid`) |
| `outcome_window_seconds` | `int` | How long after assignment an outcome counts |
| `subgroups` | `text[]` | Pre-specified subgroup attribute names (e.g. `["founder_type", "plan_tier"]`) |
| `config` | `jsonb` | Statistical config: significance threshold, target power, MDE |
| `status` | `text` | `draft`, `running`, `paused`, `complete` |
| `created_at` | `timestamptz` | |
| `updated_at` | `timestamptz` | |

---

### `variants`

The conditions within an experiment (control and one or more treatments).

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `experiment_id` | `uuid` | FK → `experiments.id` |
| `project_id` | `uuid` | FK → `projects.id` |
| `key` | `text` | Short identifier used in the SDK (e.g. `control`, `treatment`) |
| `label` | `text` | Human-readable label (e.g. `$49 plan`, `$99 plan`) |
| `weight` | `float` | Traffic allocation, 0–1. All variants in an experiment must sum to 1.0 |

---

### `experiment_runs`

A discrete execution of an experiment. Each time a customer launches an experiment, a new run is created. Assignments and events are tied to a run, not directly to an experiment. This allows multiple runs of the same experiment while keeping data cleanly separated.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `experiment_id` | `uuid` | FK → `experiments.id` |
| `project_id` | `uuid` | FK → `projects.id` |
| `status` | `text` | `running`, `stopped`, `complete` |
| `started_at` | `timestamptz` | When the run was launched |
| `stopped_at` | `timestamptz` | When the run ended (null if still running) |
| `stop_reason` | `text` | `significance_reached`, `manual_stop`, `scheduled_end`, null |

---

### `users`

A lightweight record for each unique user Panel has seen within a project. These are the customer's end users — not Panel accounts. Created on first assignment.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `project_id` | `uuid` | FK → `projects.id` |
| `external_id` | `text` | The user ID passed in by the customer's product |
| `attributes` | `jsonb` | Known user attributes: `{ "founderType": "technical", "planTier": "free", "companySize": 12 }` |
| `auto_detected` | `jsonb` | Attributes Panel inferred automatically: `{ "device": "mobile", "country": "US", "acquisitionChannel": "organic" }` |
| `first_seen_at` | `timestamptz` | |
| `updated_at` | `timestamptz` | Updated when new attributes are passed in |

**Unique constraint:** `(project_id, external_id)` — one record per user per project.

---

### `assignments`

Records which variant each user was assigned to in a given run. Created when `POST /assign` is called. Deterministic — the same user always gets the same variant for a given run.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `run_id` | `uuid` | FK → `experiment_runs.id` |
| `experiment_id` | `uuid` | FK → `experiments.id` |
| `project_id` | `uuid` | FK → `projects.id` |
| `user_id` | `uuid` | FK → `users.id` |
| `variant_id` | `uuid` | FK → `variants.id` |
| `assigned_at` | `timestamptz` | |

**Unique constraint:** `(run_id, user_id)` — a user is assigned to exactly one variant per run.

---

### `events`

Records outcome events tracked by the customer's product via `POST /events`. One row per event occurrence.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `project_id` | `uuid` | FK → `projects.id` |
| `user_id` | `uuid` | FK → `users.id` |
| `event_name` | `text` | e.g. `upgrade_to_paid`, `churned`, `completed_onboarding` |
| `occurred_at` | `timestamptz` | Customer-supplied timestamp; defaults to server time if omitted |
| `received_at` | `timestamptz` | Server time Panel received the event |
| `properties` | `jsonb` | Flexible customer-supplied properties: `{ "planChosen": "pro", "revenue": 99 }` |

**Note:** Events are not tied directly to a run or assignment at ingestion time. The results computation layer joins events to assignments using the `outcome_window_seconds` from the experiment config.

---

### `results`

Stores computed experiment results. Written at the end of a run or when a customer requests a recomputation. One row per run per result type.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `run_id` | `uuid` | FK → `experiment_runs.id` |
| `experiment_id` | `uuid` | FK → `experiments.id` |
| `project_id` | `uuid` | FK → `projects.id` |
| `result_type` | `text` | `ate`, `hte`, `wtp_curve`, `uplift_scores` |
| `computed_at` | `timestamptz` | When this result was calculated |
| `sample_size` | `jsonb` | `{ "control": 842, "treatment": 856 }` |
| `srm_detected` | `boolean` | Whether a sample ratio mismatch was detected |
| `payload` | `jsonb` | The full result: ATE estimate, confidence interval, p-value, subgroup breakdowns, etc. |
| `interpretation` | `text` | AI-generated plain-English interpretation of this result |

---

### `simulations`

Records pre-experiment power analysis runs. Stored so customers can refer back to the analysis they ran before launching.

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` | Primary key |
| `project_id` | `uuid` | FK → `projects.id` |
| `experiment_id` | `uuid` | FK → `experiments.id` (null if run before experiment was created) |
| `input` | `jsonb` | The parameters passed in: expected daily users, baseline rate, MDE, subgroups |
| `output` | `jsonb` | The full simulation result |
| `recommendation` | `text` | `run_as_designed`, `wait`, `redesign` |
| `created_at` | `timestamptz` | |

---

## Key relationships

```
organizations
  └── projects
        ├── experiments
        │     ├── variants
        │     └── experiment_runs
        │           ├── assignments (→ users, → variants)
        │           └── results
        ├── users
        ├── events (→ users)
        └── simulations (→ experiments)
```

---

## Key indexes

Performance-critical queries and the indexes that support them:

| Query | Index |
|---|---|
| Get all experiments for a project | `(project_id)` on `experiments` |
| Look up a user by external ID | `(project_id, external_id)` on `users` |
| Check if a user already has an assignment for a run | `(run_id, user_id)` on `assignments` |
| Get all events for a user within a time window | `(project_id, user_id, occurred_at)` on `events` |
| Get all events by name for a project | `(project_id, event_name)` on `events` |
| Get results for a run | `(run_id, result_type)` on `results` |

---

## Open questions

Design decisions to revisit when building:

- **Assignment collision:** if a user is assigned in run 1 and run 2 of the same experiment, do they always get the same variant, or can run 2 re-randomize?
- **Event attribution:** if a user converts 5 days after assignment but the outcome window is 30 days, the event counts. What if they convert in a different run's window?
- **User attribute versioning:** if a user's `founderType` changes between run 1 and run 2, which value does the subgroup analysis use?

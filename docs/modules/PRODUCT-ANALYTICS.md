# Module: Product Analytics + Data Instrumentation

**Phase:** 2  
**Slug:** `product-analytics`  
**Status:** not started  

---

## What it is / how to think about it

Product analytics is how you know what's actually happening in your product. Not what you think is happening — what users are literally doing, where they drop off, which features they return to, and how behavior changes over time. Data instrumentation is the engineering work that makes this possible: designing the event schema, wiring tracking into the product, and routing data to where you can analyze it.

**Mental model:** An uninstrumented product is a black box. You have users, you have revenue, you have nothing in between. Instrumentation turns the black box into a glass box — you can see every step a user takes, where they hesitate, what they skip, and what brings them back. For the experimentation platform specifically, usage data is also a strategic asset: the feedback loop between how people use the platform and how the AI interpretation layer improves is the data moat.

Build the instrumentation before you need it. Once users are in the product without tracking, you've already lost data you can never recover.

---

## Prerequisites
- `http-apis` — events are HTTP calls; you need to understand how they work
- `sql` — you'll be querying this data; the analysis lives in SQL

---

## Best resources

**Primary:**
1. [PostHog Documentation](https://posthog.com/docs) — open-source product analytics; read the "Product analytics" and "Event tracking" sections; this is the recommended stack for the platform
2. [Segment Tracking Plan Guide](https://segment.com/docs/protocols/tracking-plan/create/) — the industry standard methodology for designing event schemas before writing a line of tracking code
3. [Amplitude — Data Taxonomy Playbook](https://amplitude.com/blog/data-taxonomy-playbook) — the naming conventions and schema design patterns used at scale

**Supporting:**
- [PostHog — Self-hosting guide](https://posthog.com/docs/self-host) — running PostHog on your own infrastructure so you own the data
- [Mixpanel — Event tracking best practices](https://docs.mixpanel.com/docs/tracking-best-practices/event-tracking) — good reference for naming conventions and property design

---

## Core concepts

### Why instrument from day one

The cost of retrofitting instrumentation into a product that already has users is enormous. Events that weren't tracked during a feature's first month are gone. Funnels you can't measure, you can't improve. And for the experimentation platform specifically, delayed instrumentation means delayed data flywheel: every week without tracking user interactions with HTE results is a week of training signal you'll never get back.

Three reasons instrumentation is a day-one concern, not a later concern:
1. **Product decisions require data.** You will make better feature prioritization decisions with usage data than without it. This applies from the very first cohort of users.
2. **The data flywheel doesn't start until you track.** For the AI interpretation layer to improve over time, you need to capture which interpretations users found useful vs. which they ignored or overrode. That signal has to be tracked explicitly.
3. **Usage-based billing requires accurate metering.** If your pricing model charges by experiment volume, event count, or active user, you need that data to be accurate from day one. You can't retroactively bill for events you didn't log.

### Choosing an analytics stack

**PostHog (recommended for the platform):**
- Open-source; can be self-hosted, which means you own the data
- Covers: event tracking, user identification, funnel analysis, retention analysis, session recording, feature flags, and basic A/B testing
- The feature flag and A/B testing capabilities create an interesting overlap with what you're building — you can use PostHog to experiment on the experimentation platform itself
- Self-hosting cost: ~$50–100/month on a basic cloud server for startup-scale traffic
- Managed cloud option if self-hosting isn't worth it yet

**Segment (router/middleware):**
- Not an analytics tool — it's a routing layer that receives events and forwards them to multiple destinations (Amplitude, BigQuery, Mixpanel, etc.)
- Worth adding when you have multiple data consumers (analytics + data warehouse + CRM) and don't want to send separate tracking calls to each
- Overkill for early-stage; add it when you need to fan events out to multiple destinations

**Amplitude / Mixpanel:**
- Best-in-class visualization and behavioral analytics
- Hosted; you don't own the raw data
- Worth pairing with Segment if you want their visualization layer on top of your own data pipeline

**Self-built (BigQuery + dbt + Metabase):**
- Maximum control and flexibility
- High setup cost; worth it when data volume justifies infrastructure investment
- This is where most companies end up at scale

**For the experimentation platform:** Start with PostHog self-hosted. It gives you product analytics, session recording, and feature flags in one tool, you own the data, and the self-hosting discipline is good practice for Phase 2 skills.

### Event schema design

The event schema is the most important design decision in your analytics setup. A poorly designed schema creates debt that's painful to pay down: broken funnels, misnamed events, inconsistent properties, and analysis that can't be trusted.

**Naming conventions:**

Events follow a `[Object] [Action]` pattern in past tense:
- `Experiment Created` not `create_experiment` or `experimentCreation`
- `Result Viewed` not `view_result` or `ResultView`
- `Interpretation Dismissed` not `dismiss` or `interpretationDismissed`

Consistency is more important than perfection. Pick a convention and enforce it everywhere.

**Required properties on every event:**
- `user_id` — the identified user (or `anonymous_id` before identification)
- `timestamp` — server-side timestamp (not client-side; clocks drift)
- `session_id` — groups events within a single session
- `platform_version` — which version of the product produced this event
- `environment` — `production` / `staging` / `development`; filter out non-production in analysis

**Event-specific properties:**
- Keep properties flat (not nested objects) where possible — easier to query in SQL
- Only include properties that are known at the time of the event — don't retroactively enrich
- Booleans for binary states; enums for known option sets; free text only for user-provided content

**The tracking plan:** Before writing any tracking code, write a document that lists every event, its trigger condition, and every property it carries. This is the tracking plan. The Segment methodology formalizes this — apply it even if you don't use Segment.

### User identification

Events before a user creates an account are anonymous. Events after sign-in are identified. The analytics SDK handles the transition, but you have to tell it when it happens.

**The identify call:** When a user signs in or creates an account, call `analytics.identify(userId, traits)` where traits are user-level properties (plan tier, company size, acquisition channel, signup date). After this call, all subsequent events from that user are associated with their user ID.

**Anonymous → identified stitching:** Good analytics tools (PostHog, Segment) automatically retroactively associate pre-signup anonymous events with the identified user after the identify call. This lets you measure the full funnel including pre-signup behavior.

**Group identification:** For B2B products where multiple users share an account (a company's team on the experimentation platform), use group tracking in addition to user tracking. `analytics.group(companyId, traits)` associates events with both the user and the company.

### What to track for the experimentation platform

**Experiment lifecycle events:**
- `Experiment Setup Started` — when user begins the three-question setup flow
- `Experiment Intent Parsed` — when the LLM parses the user's description; include `parsed_correctly: boolean` (you confirm vs. the user corrects)
- `Pre-Experiment Assessment Viewed` — when user sees the power analysis output
- `Experiment Launched` — treatment, control size, primary metric, subgroup pre-specification
- `Experiment Result Viewed` — which result type (ATE, HTE, WTP curve); confidence level of the result
- `Interpretation Engaged` — user clicked/expanded an AI interpretation; which result it was attached to
- `Interpretation Dismissed` — user dismissed without engaging
- `Subgroup Drilled Into` — user explored a specific subgroup result
- `Uplift Score Viewed` — user accessed the uplift scoring feature
- `Experiment Concluded` — how the experiment ended (significance reached / stopped early / ran to completion)

**Product health events:**
- `Session Started` / `Session Ended` with duration
- `Feature Discovered` — first time a user accesses a feature (useful for measuring time-to-discovery)
- `Error Encountered` — any user-visible error, with error type and context
- `Support Initiated` — user opened help or contacted support

**AI feedback signals (the data flywheel):**
- `Interpretation Rating` — if you add explicit thumbs up/down feedback
- `Interpretation Corrected` — if a user overrides the AI's plain-English interpretation with their own
- `Recommendation Acted On` — if the user takes an action the platform recommended (e.g., redesigning the experiment based on power analysis)

### What to track for the personal website

Simpler than the platform, but worth doing:
- `Page Viewed` — which page, referrer, device type
- `Section Reached` — which sections of long-form content users scroll to (measures reading completion)
- `Project Clicked` — which portfolio project links get clicked
- `Writing Piece Opened` — which blog/writing pieces get read
- `Contact Initiated` — email link clicked, contact form submitted
- `GitHub Repo Clicked` — traffic from site to code

### Building dashboards

For the experimentation platform, four dashboards cover most needs:

1. **Activation funnel:** Setup Started → Assessment Viewed → Experiment Launched. Where do users drop off in the setup flow?

2. **Engagement:** Of launched experiments, what % reach Result Viewed? What % reach Interpretation Engaged? The interpretation engagement rate is your proxy for AI feature value.

3. **Retention:** Of users who launched an experiment in week 1, what % launched another in week 2? Week 4? This is the core retention metric.

4. **Data flywheel health:** Interpretation engagement rate over time. If the AI interpretation layer is improving (due to better prompts, better calibration), this rate should trend up.

---

## Exercises

**Set 1 — Stack selection and setup (1 hour):**
Set up PostHog self-hosted (or PostHog cloud free tier if self-hosting isn't practical yet).
- Create a project
- Install the JavaScript SDK in a test page
- Fire three test events and verify they appear in PostHog
- Set up one dashboard with a single funnel (even if it's mocked)
Save setup notes to `docs/reading/POSTHOG-SETUP-NOTES.md`.

**Set 2 — Write the tracking plan (45 min):**
Write the full tracking plan for the experimentation platform:
- List every event from the "What to track" section above
- For each event: trigger condition, required properties, any notes on implementation
- Add 3 events of your own that aren't listed above
Use the Segment tracking plan format (table with: event name, trigger, properties, notes).
Save to `docs/projects/experimentation_platform/ANALYTICS-PLAN.md`.

**Set 3 — Event schema design exercise (30 min):**
You realize you need to track how users interact with the pre-experiment simulation feature. Design the events from scratch:
- What are the 4–6 events that fully describe a user's interaction with this feature?
- What properties does each event carry?
- How do you capture whether the simulation influenced the user's decision to proceed?
Save to `docs/reading/SIMULATION-EVENT-SCHEMA.md`.

**Set 4 — Dashboard design (20 min):**
Without building anything, design two dashboards for the platform:
- What metric goes on each chart?
- What time window?
- What filter or breakdown would you apply?
- What would a "good" vs "bad" reading look like for each metric?
Save to `docs/reading/ANALYTICS-DASHBOARD-DESIGN.md`.

---

## Checks — you understand this when you can:
- [ ] Explain why instrumentation belongs on day one, not after launch
- [ ] Choose between PostHog, Segment, and Amplitude for a given product context and justify the choice
- [ ] Design an event schema for a new feature using consistent naming conventions and required properties
- [ ] Explain the anonymous → identified user stitching flow
- [ ] Write a tracking plan for a product feature (events, triggers, properties)
- [ ] Design a retention and engagement dashboard for the experimentation platform

---

## Artifacts to commit
- [ ] `docs/reading/POSTHOG-SETUP-NOTES.md`
- [ ] `docs/reading/SIMULATION-EVENT-SCHEMA.md`
- [ ] `docs/reading/ANALYTICS-DASHBOARD-DESIGN.md`
- [ ] Glossary entries: event schema, tracking plan, identify call, group tracking, funnel analysis, retention cohort, data flywheel, session recording
- [ ] Log entry in `docs/LOG.md`

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/ANALYTICS-PLAN.md`. This is the full event tracking specification for the platform — every event, every property, every trigger condition. It feeds directly into the capstone build: the platform should be instrumented from the first line of production code.

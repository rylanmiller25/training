# Module: AI PM Interview Prep

**Phase:** 6  
**Slug:** `ai-pm-interviews`  
**Status:** not started  

---

## What it is / how to think about it

Interviewing for AI PM and TPM roles is different from interviewing for traditional PM roles. The frameworks interviewers use are different. The behavioral stories they're evaluating for are different. Some rounds — a live prototyping exercise with AI tools — don't exist in traditional PM loops at all.

This module prepares you for the five distinct round types you'll encounter at companies running serious AI product organizations:

1. **Behavioral** — AI-specific STAR stories
2. **Product sense + design** — designing AI products with UI/UX fluency
3. **Product execution** — connecting model metrics to user metrics to business metrics
4. **AI system design** — drawing the full architecture on the spot
5. **Vibe coding** — a live prototyping round with AI tools

**Mental model:** Most candidates prepare well for rounds 1–3 using standard PM prep. Rounds 4–5 separate the field. The people who get offers at top AI companies have hands-on architectural fluency (round 4) and can actually build something in 45 minutes (round 5) — not just talk about it.

---

## Prerequisites
- All Phase 5 modules complete — you need the technical depth before the interview prep makes sense
- `ai-product-strategy` complete — that module gives you the strategic vocabulary for rounds 2–3
- `system-design` and `rag` complete — prerequisites for round 4

---

## Best resources

**Books (still foundational for rounds 1–2):**
- *Cracking the PM Interview* (McDowell & Bavaro) — foundational for behavioral + product sense; not AI-specific but covers the baseline
- *Decode and Conquer* (Lewis C. Lin) — the CIRCLES method and metric frameworks; adapt to AI context

**AI-specific:**
- Lenny's Newsletter — search "AI PM" in the archive; consistently high-quality interview prep content
- The *AI Product Manager Handbook* if it's been published by the time you read this — the space is moving fast

---

## The interview cycle — timeline and structure

### When to start preparing relative to this curriculum

Don't wait until you finish Phase 6. The interview prep in this module requires ~10 hours of active practice, but the broader prep — building technical depth, producing work you can speak to, having genuine opinions about AI products — is what the entire curriculum builds toward.

Rough timing:
- **Phase 4 complete:** You can start having informal conversations with PMs at AI companies. Not applying — talking. These conversations calibrate your target and sharpen your narrative.
- **Phase 5 complete:** Start applying. You have enough technical depth to hold your own in rounds 4–5.
- **This module:** Do it after Phase 5 is complete, before or alongside the capstone. Don't do it in the abstract — do it while the platform is live and you have something to demo.

The worst mistake is waiting until you feel "ready." You will not feel ready. Apply when the technical foundation is there, even if the polish isn't.

---

### The general PM interview loop

Most PM interview processes at companies of any size follow the same rough structure. The rounds vary by company but the categories are consistent.

**Stage 1: Application and resume screen** (1–2 weeks after applying)
A recruiter or sourcing tool screens for baseline fit. For AI PM roles, the signals they're looking for: prior PM experience or strong adjacent experience (engineering, data science, research), any AI/ML product work, and technical credibility markers in the background.

**Stage 2: Recruiter phone screen** (20–30 min)
Mostly logistics — role fit, timeline, comp expectations. Sometimes a light behavioral question. Be ready to explain your background in 2 minutes and answer "why this company / why AI PM."

**Stage 3: Hiring manager screen** (30–45 min)
This is the first real evaluation. Usually one behavioral question and one product question. The HM is assessing: can this person think clearly about products, and do they have the right instincts? This is also where they're deciding whether to invest the rest of the loop.

**Stage 4: Take-home or async assessment** (not universal, 1–3 days to complete)
Some companies send a written case: "Here's a product problem. Write a brief strategy doc." Some send a metrics exercise. Some skip this entirely. If assigned, treat it as a real work product — not a quick answer.

**Stage 5: The full loop** (half day or full day, typically 4–6 rounds back-to-back)
This is the main event. Rounds vary by company (see below). Most loops include:
- 1–2 behavioral rounds
- 1 product sense / design round
- 1 execution / metrics round
- 1 technical or strategy round (varies by company)
- Sometimes: a presentation or case defense

**Stage 6: Debrief, offer, negotiation** (1–2 weeks after the loop)
The hiring committee meets. If there's a debrief call with the HM, take it seriously — it sometimes means borderline and they want to hear more. Offer → negotiation → decision.

**Total elapsed time from first application to offer: 4–10 weeks.** Larger companies trend toward the longer end (more process, more scheduling delays). Startups move faster.

---

### How AI PM loops differ from standard PM loops

Most of the structure above applies. The key differences:

**A technical bar that actually tests technical depth.** Standard PM loops have a "technical" round that's mostly "can you talk to engineers." AI PM loops at serious AI companies often include a round that tests whether you understand the systems you'd be managing — model evaluation, inference infrastructure, the difference between fine-tuning and RAG, what HITL means in practice. You can't bluff this. That's why Phases 4–5 exist.

**An additional system design round.** Round 4 in this module (AI system design) is not universal, but it appears in most AI company loops. Some companies call it "technical design," some call it "product architecture." The expectation is that you can draw a real architecture — not a vague diagram — and defend the tradeoffs.

**A prototyping round at some companies.** Netflix, Figma, and others have formalized a 45-minute coding/prototyping round (Round 5 in this module). It's not universal — probably 10–20% of AI PM loops include it — but it will become more common. If you're applying to companies known for technical product work, assume this could appear.

**Stronger emphasis on evaluation and metrics thinking.** Standard PM loops ask about metrics. AI PM loops ask about metrics *across the model/user/business stack* (Round 3). They want to see that you can trace a model quality change to a user experience impact to a business outcome. This is the most common weak point for PM candidates transitioning into AI.

**Less emphasis on estimation and market sizing.** These rounds still exist, but they're lower weight than in a Google-style PM loop from five years ago. Most AI companies have moved away from "how many golf balls fit in a school bus" toward "design the evaluation framework for this AI feature."

---

### Company-by-company variation

The structure shifts depending on where you're applying:

**Large AI labs (Anthropic, OpenAI, Google DeepMind):** Highest technical bar. Expect a genuine technical design round. The behavioral questions probe for research-adjacent thinking — comfort with ambiguity, ability to work with researchers, judgment about what to build vs. what to study. At Anthropic specifically, safety judgment is a first-class signal.

**Big Tech AI divisions (Google AI, Meta GenAI, Microsoft Copilot):** Standard big-tech PM loop plus AI-specific rounds. More structured, more rounds, longer process. Google adds a Googleyness/culture round. Meta has a "drive" component. Microsoft emphasizes cross-functional leadership.

**AI-native startups (Cursor, Perplexity, Harvey, Abridge, etc.):** Faster loops, fewer rounds, higher signal per round. Often: one HM screen, one technical conversation, one product exercise or take-home, decision. The faster pace means each conversation carries more weight. Strong founder/early PM bias — they want someone who can operate with minimal process.

**Enterprise software with AI features (Salesforce, ServiceNow, HubSpot AI):** More traditional PM loop with an AI overlay. The technical bar is lower than a pure AI company, but domain knowledge matters more. Sales and customer engagement context is often probed.

---

### Scheduling and logistics

A few practical notes:

**Schedule your strongest round first if you have a choice.** You get to warm up on weaker companies before applying to your top choices. If Anthropic is your top target, do 2–3 company loops first.

**Don't let rounds expire.** If a recruiter reaches out and you're not ready, it's fine to say "I'm in the middle of another process, can we connect in 3–4 weeks?" Most good recruiters will wait. Don't ghost and come back later — it's harder to reopen.

**Ask what rounds are in the loop before you start.** A simple "can you walk me through the interview process?" in the recruiter screen tells you exactly what you're preparing for.

**The debrief window is short.** If you don't hear back within 10 business days of the loop, follow up. Silence usually means a slow committee, not rejection — but it occasionally means your packet got lost.

---

## Round 1: Behavioral — AI product stories

Standard STAR format (Situation, Task, Action, Result) doesn't transfer cleanly to AI product work. The reasons:

**Why AI STAR is different:**
- AI product outcomes are probabilistic, not deterministic. You can't say "I shipped this and exactly Y happened." You say "I designed the evaluation criteria, ran the experiment, iterated, and moved the metric from X to X+δ over 3 months." The story has more uncertainty and more process.
- The team structure is unfamiliar. Behavioral interviewers want to hear how you worked with ML engineers, data scientists, and researchers — not just designers and engineers. If your stories only include the latter, you haven't demonstrated the right collaborations.
- Safety and trade-offs are first-class concerns. A story that includes "we decided to slow the rollout because of an unexpected failure mode in the eval set" shows judgment. A story with no constraints, no safety consideration, and no evaluation loop sounds like traditional PM, not AI PM.
- The timelines are different. AI feature development often has longer cycles with more exploration. Stories that show comfort with ambiguity — "we didn't know if the approach would work until we ran the eval" — land better than stories that imply everything was planned upfront.

**The five behavioral stories you need:**

For each, write a 2–3 minute version and a 5–6 minute version. The short version is for "tell me about a time when..." The long version is for follow-up questions.

1. **Ambiguity → structure:** A situation where the problem wasn't well-defined and you had to figure out what to build before building it. AI-specific: include how you defined success criteria for the model component.

2. **Cross-functional collaboration:** Working with ML engineers, researchers, or data scientists on a product decision. The tension between what's technically feasible and what users need — and how you navigated it.

3. **Product failure + recovery:** Something didn't work — an eval showed the model wasn't reliable, a feature hurt a guardrail metric, a deployment had unexpected behavior. What did you do? AI-specific: include the evaluation/monitoring component, not just the rollback story.

4. **Shipping under uncertainty:** You had to make a product decision without complete information. AI-specific: include how you framed the acceptable uncertainty, what you monitored after launch, and when you decided you had enough signal.

5. **Impact at scale:** A story where the AI component made something possible that wasn't possible before, and you can point to a measurable outcome. This is your "here's why AI PM matters" story.

**Format for each story:**
- Situation (30 sec): context and stakes
- AI-specific constraint (15 sec): what made this an AI problem, not a generic PM problem
- Your role + action (90 sec): what you specifically did, with ML/data/research team context
- Evaluation loop (30 sec): how you knew if it was working
- Result (30 sec): measurable outcome, including uncertainty if appropriate
- Reflection (15 sec): what you'd do differently

---

## Round 2: Product sense + design — AI products

AI product sense questions come in two forms: "improve this product" and "design this product." Both require fluency in AI-specific UX and design patterns that traditional product sense doesn't cover.

### The AI-specific design vocabulary you must have:

**Confidence and uncertainty display:** When an AI is uncertain, how does the UI communicate that? Three patterns:
- *Confidence scores* (show the number) — transparent but often meaningless to users
- *Language calibration* (hedge in the copy itself) — "This looks like a conversion issue, but check whether..." vs "Your conversion rate dropped because..."
- *Verification prompts* (ask the user to confirm before acting) — appropriate when errors are costly

Knowing which pattern to use for which context is a design judgment interviewers probe for.

**Copilot vs. agent vs. augmentation choice:** You need to be able to explain why a given product design chose one architecture over another. (Covered in `ai-product-strategy`.) In a product sense question, you'll be asked to make this choice and defend it.

**Trust calibration over time:** AI products need to earn trust. First use ≠ established use. How does the UI change as trust increases? How does it change after an error? Design should include the full trust arc, not just the happy path.

**The "what happens when it's wrong" question:** Every AI feature design must account for failure. If you propose an AI feature without addressing what happens when the model is wrong, you're not done. The failure handler is part of the design.

**Surface vs. core AI:** Is the AI the product (Perplexity), a copilot layer on top of a product (Linear's AI), or invisible infrastructure (Gmail's spam filter)? Where on this spectrum is your design and why?

### Framework for AI product sense answers:

1. **Understand the user and context** (standard, but include: how technically sophisticated is the user? What's the cost of an AI error for them?)
2. **Define the job to be done** (what outcome does the user need? What's the "aha moment"?)
3. **Choose the AI architecture** (copilot, agent, or augmentation — and defend it)
4. **Design the happy path** (the interaction when the AI is right)
5. **Design the failure path** (the interaction when the AI is wrong, uncertain, or refuses)
6. **Define success metrics** (dual metrics: user performance + AI performance; see Round 3)
7. **Identify the trust arc** (how does the experience change after first use? After first error?)

---

## Round 3: Product execution — connecting the metric layers

AI PM execution rounds test whether you can reason about AI product health using three connected layers of metrics. Most candidates can discuss one layer; strong candidates connect all three.

### The three-layer metric pyramid:

**Layer 1 — Model metrics** (what the AI is doing):
- Accuracy / precision / recall on the evaluation set
- Latency (P50, P95, P99)
- Cost per inference call
- Hallucination rate / refusal rate
- Distribution shift (is production data diverging from training data?)

**Layer 2 — User metrics** (what users experience):
- Task completion rate (did the user accomplish what they came to do?)
- Correction rate (how often do users edit or reject the AI output?)
- Trust indicators (repeat usage, voluntary opt-in to AI features, time-on-task reduction)
- Error-driven churn (did a visible AI error cause a user to disengage?)

**Layer 3 — Business metrics** (what the company cares about):
- Revenue, retention, NPS (standard)
- AI-specific: feature attach rate (what % of users are using the AI feature?), AI-influenced conversion

### The connection interview question:

"Your model accuracy dropped from 91% to 87% last week. Walk me through how you'd investigate the business impact."

A strong answer traces the path: model accuracy drop (Layer 1) → what types of errors increased? → which user flows are affected? → which user metrics should be moving? (Layer 2) → what's the expected business impact given the user metric changes? (Layer 3) → how do you decide whether to roll back, fix, or tolerate?

A weak answer stays at Layer 1 ("I'd investigate why the accuracy dropped") without tracing through to user and business impact.

### The reverse direction:

"Monthly retention dropped 3 points. How would you investigate whether an AI feature is the cause?"

Trace in reverse: business metric drop (Layer 3) → which user cohorts? → which user flows? → did correction rate, task completion, or error-driven churn change? (Layer 2) → what model metrics would explain that user behavior? (Layer 1).

Both directions are tested. Practice both.

---

## Round 4: AI system design — drawing the architecture on the spot

AI system design rounds expect you to draw a full architecture — RAG pipeline, agent loop, safety + HITL integration — while talking through trade-offs. This is different from traditional system design, which focuses on scalability and data modeling.

### The three architecture templates to internalize:

**Template 1: RAG pipeline**
```
User query
  → Query embedding (embedding model)
  → Vector search (vector DB: Pinecone, pgvector, Weaviate)
  → Retrieved chunks (top-k documents)
  → Context assembly (retrieved chunks + query + system prompt)
  → LLM inference
  → Response
  → [optional] Reranking step before context assembly
  → [optional] Citation extraction from response
```
Trade-offs to discuss: chunk size, retrieval method (semantic vs. keyword hybrid), reranking cost, context window limits, staleness of the vector index.

**Template 2: Multi-agent loop**
```
User request
  → Orchestrator (LLM with tools)
    → Tool calls (search, code execution, API calls)
    → Tool results returned to orchestrator
    → Loop until task complete or max steps reached
  → Final response + reasoning trace
  → [critical] HITL checkpoint (for high-stakes actions, require user approval before execution)
  → [critical] Audit log (all tool calls, inputs, outputs)
```
Trade-offs to discuss: when to add HITL checkpoints, how to handle partial failures in multi-step chains, cost of long reasoning traces, loop termination conditions.

**Template 3: AI copilot embedded in product**
```
User action in product
  → Context extraction (relevant product state, user history)
  → Prompt construction (system prompt + context + user request)
  → LLM inference (often streaming)
  → Response displayed with confidence/uncertainty signal
  → User accepts / edits / rejects
  → Feedback logged (accept/edit/reject + edited content)
  → [optional] Fine-tuning or RLHF pipeline consumes feedback
```
Trade-offs to discuss: streaming vs. buffered response, confidence display, feedback collection without adding friction, cost of fine-tuning loop.

### Safety and guardrails — you must address this unprompted:

In any AI system design answer, proactively include:
- **Input guardrails:** Filter harmful, off-topic, or adversarial inputs before reaching the model
- **Output guardrails:** Validate outputs against a policy before showing to users
- **HITL checkpoints:** For high-stakes or irreversible actions, require human approval
- **Audit logging:** Every input, output, and tool call logged for review and debugging
- **Rollback mechanism:** How do you disable or degrade the AI feature without taking down the product?

Not mentioning safety when designing AI systems is an automatic flag for experienced interviewers.

### Practice questions:

1. Design the AI interpretation layer for an A/B testing platform. A user runs an experiment, gets results, and the platform explains what the statistics mean. Draw the full architecture including evaluation pipeline and feedback loop.

2. Design an AI-powered customer support agent for a B2B SaaS product. The agent should handle tier-1 support autonomously and escalate tier-2 cases to humans. Draw the full loop including escalation logic, HITL handoff, and how you measure whether it's working.

3. Design a coding assistant that suggests the next function as a developer types. Cover: how context is selected, how latency is kept under 300ms, how you evaluate quality, and how you handle the case where the suggestion is wrong.

---

## Round 5: Vibe coding — the 45-minute prototype

Some companies (Netflix, Figma, and others) run a formal 45-minute prototyping round. You're given a product problem and asked to build a working prototype using AI tools. The evaluation criteria are not "does this ship to production" — they're:
- Can you scope to 45 minutes and ship something functional?
- Do you use AI tools fluently (not fighting them, not ignoring them)?
- Can you make product judgment calls quickly (what to cut, what to fake, what to stub)?
- Does the prototype demonstrate the core value clearly?

### Setup to have ready:

Before any interview process starts, have a working environment configured:
- Claude Code (or Cursor) ready in a clean project directory
- A TypeScript or Python project template you can spin up in under 2 minutes
- A way to deploy in under 5 minutes (Vercel, Railway, or a local demo that screenshots well)
- Comfort running Claude Code in your terminal without looking things up

### How to approach 45 minutes:

**Minutes 0–5:** Scope aggressively. Identify the core value to demonstrate. Write down what you will NOT build. Stub everything except the happy path of the core value.

**Minutes 5–35:** Build. Use AI tools to generate boilerplate fast. Make product judgment calls in real time: "The real version would have auth; I'll hardcode a user." "The real version would call the API; I'll use realistic mock data." Talk your thinking out loud.

**Minutes 35–45:** Polish the demo path. Make sure the core user flow works end-to-end. Know what you faked and be ready to say so.

**What to say when things break:** "The interesting part here is [core concept], so let me demo that piece and explain what I'd need to fix to make this production-ready." Judges know 45 minutes is not production. They're evaluating judgment, not completion.

### Practice problems (timed):

Run each of these under 45 minutes with AI tool assistance:

1. Build a minimal A/B test setup UI: a user enters the experiment name, variants, and primary metric, and the app generates the event tracking code they need to copy into their product.

2. Build a single-page app where a user pastes a block of statistical results (ATE, CI, p-value, subgroup breakdown) and gets a plain-English interpretation generated by an LLM.

3. Build a "know before you run" simulator: a user enters expected traffic, desired effect size, and experiment duration, and the app tells them whether the experiment is well-powered.

Save a brief write-up of each prototype (what you built, what you stubbed, what you'd add) to `docs/projects/VIBE-CODING-EXERCISES.md`.

---

## Exercises

**Set 1 — Build your 5 behavioral stories (2 hours):**
Write all five AI-specific behavioral stories using the format above. Write the 2–3 minute version and the 5–6 minute version of each. Record yourself delivering each one. Listen back. Revise until you can deliver them fluently without notes.
Save to `docs/projects/AI-PM-BEHAVIORAL-STORIES.md`.

**Set 2 — Product sense: improve and design (90 min):**
Answer both of these in writing first, then say each one out loud:
1. "How would you improve the AI interpretation feature in an A/B testing tool?"
2. "Design an AI product that helps early-stage founders decide whether to pivot."
Apply the AI product sense framework. Include confidence/uncertainty display, failure path, and trust arc for each.
Save to `docs/projects/PRODUCT-SENSE-EXERCISES.md`.

**Set 3 — Metrics exercise (30 min):**
For each scenario, trace the full three-layer path:
1. "Your LLM's P95 latency increased from 800ms to 2.2 seconds. Trace to business impact."
2. "DAU dropped 8% the week after you launched an AI summarization feature. How do you investigate whether the AI feature caused it?"
Save to `docs/projects/METRICS-EXERCISE.md`.

**Set 4 — System design practice (2 hours):**
Work through all three practice questions in Round 4. For each:
- Draw the architecture (whiteboard photo, sketch, or ASCII diagram)
- Write the trade-offs you'd discuss in an interview
- Write the safety/guardrail components you'd add
Say each design out loud as if presenting to an interviewer.
Save to `docs/projects/AI-SYSTEM-DESIGN-PRACTICE.md`.

**Set 5 — Vibe coding (3 sessions × 45 min):**
Run all three practice problems under the 45-minute constraint. Use Claude Code or your preferred AI tool. After each session, write the post-mortem: what did you build, what did you stub, what would you add, what would you do differently?
Save to `docs/projects/VIBE-CODING-EXERCISES.md`.

---

## Checks — you understand this when you can:
- [ ] Deliver all 5 behavioral stories verbally without notes, with AI-specific framing in each
- [ ] Answer "improve this AI product" with a framework that includes confidence display, failure path, and trust arc
- [ ] Trace a model metric change through to user metrics and business metrics (both directions)
- [ ] Draw a RAG pipeline, multi-agent loop, or copilot architecture on a whiteboard and talk through trade-offs for 10 minutes
- [ ] Explain safety/guardrail components for any AI system design without being prompted
- [ ] Build a working prototype of a simple AI feature in under 45 minutes using AI tools

---

## Artifacts to commit
- [ ] `docs/projects/AI-PM-BEHAVIORAL-STORIES.md`
- [ ] `docs/projects/PRODUCT-SENSE-EXERCISES.md`
- [ ] `docs/projects/METRICS-EXERCISE.md`
- [ ] `docs/projects/AI-SYSTEM-DESIGN-PRACTICE.md`
- [ ] `docs/projects/VIBE-CODING-EXERCISES.md`
- [ ] Log entry in `docs/LOG.md`

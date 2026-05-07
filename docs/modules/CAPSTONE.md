# Module: Capstone — Portfolio + Synthesis

**Phase:** 6  
**Slug:** `capstone`  
**Status:** not started  

---

## What it is / how to think about it

The capstone is where everything lands. You have built the experimentation platform across the curriculum, produced platform design artifacts in every phase, and written content pieces along the way. Now you ship the platform, publish the website, and construct interview-ready narratives.

**Mental model:** This is your show-don't-tell moment. Anyone can list topics they studied. The website, the platform, and the writing are the evidence.

---

## Prerequisites
- All prior phases (Phases 1–5 substantially complete)
- Platform artifacts from each phase produced and committed
- Website content pieces from the `→ Website content` callouts in Phases 3, 4, and 5 written and committed to `docs/writing/`

---

## Primary deliverable: personal website

The personal website is the capstone artifact. It replaces the markdown portfolio doc — the website *is* the portfolio, publicly accessible and demonstrating the ability to communicate complex things to different audiences.

**What the site contains:**

**1. The platform**
- What it is, why it exists, how it works — written for a technical reader (someone who knows A/B testing and statistics)
- A second version of the same explanation for a non-technical reader (a founder who's never heard of heterogeneous treatment effects)
- Live demo or screenshots if the MVP is deployed
- Link to the GitHub repo

**2. Academic research**
- Feature your existing research with the same two-version treatment: a rigorous write-up for readers in the field and a plain-language version for those outside it
- The goal is to demonstrate that you understand your own research well enough to explain it to someone who doesn't share your background

**3. Blog / writing**
- The content pieces produced during the curriculum (`docs/writing/`) get published here
- At minimum: the platform founding story (Phase 3), the HTE explainer (Phase 4), and the AI interpretation piece (Phase 5) — each in two audience versions
- Add pieces as you continue working; this is a living section

**4. About**
- Who you are, what you've built, what you want to work on next
- Short, direct, no fluff

**The two-version principle:** Every substantive piece — the platform, your research, each blog post — gets two treatments. One for people who know the domain. One for people who don't. This demonstrates the communication skill that matters most for TPM work at a research lab: translating between technical depth and accessible clarity without losing accuracy in either direction.

---

## Platform MVP (the other primary deliverable)

By the time you reach the capstone, `src/` should contain a working MVP of the experimentation platform. Minimum viable:
- Experiment assignment service (variant assignment, event tracking)
- Results API (ATE computation, subgroup breakdown)
- AI interpretation layer (LLM-generated plain-English output for at least one result type)
- Deployed and accessible via a live URL

This is what gets featured on the website. The 22+ design artifacts produced across the curriculum are the architecture behind it.

---

## Interview-ready narratives

For 5 topics, write a 200-word narrative you could deliver verbally:
1. **"Walk me through how you'd build an AI feature from scratch"** — use case selection, prompt design, eval, HITL, monitoring
2. **"What are the most important failure modes to watch for in LLM systems?"** — hallucination, prompt injection, sycophancy, context failures
3. **"How would you evaluate whether an AI feature is working in production?"** — metrics, evals, user feedback, drift detection
4. **"How do you think about the cost/quality tradeoff in model selection?"** — tiers, cost calculation, when to use smaller models
5. **"Tell me about a technical project you worked on"** — the experimentation platform; explain the problem, your approach, what you learned

Save narratives to `docs/projects/INTERVIEW-NARRATIVES.md`. Say each one out loud. Revise until you can deliver it without reading.

---

## Suggested sequence

1. **Audit what's built.** Go through every platform artifact and every `docs/writing/` piece. What's done? What needs finishing before you can publish?

2. **Finish the platform MVP.** Get the core services working. Deploy. Get a live URL.

3. **Write what's missing.** Any `docs/writing/` pieces not yet written, write them now. Both versions of each.

4. **Build and launch the site.** (You won't do this alone — this is where you ask for help building it.) Content goes in `docs/writing/`. The site pulls from there.

5. **Write the interview narratives.** All five. Say them out loud.

6. **Final curriculum map update.** Mark every module accurately. This is your honest accounting.

7. **Final log entry.** Write a reflection in `docs/LOG.md`: what surprised you, what was harder than expected, what you'd do differently.

---

## Checks — you understand this when you can:
- [ ] The platform is deployed with a live URL
- [ ] The website is live with the platform, research, and at least 3 writing pieces — each in two versions
- [ ] Explain the platform to a technical audience in 5 minutes
- [ ] Explain the platform to a non-technical audience in 5 minutes
- [ ] Deliver any of the 5 interview narratives verbally without notes
- [ ] Point to code, artifacts, and writing as evidence for every claimed skill

---

## Artifacts to commit
- [ ] `src/` — working platform MVP with README
- [ ] Personal website — live URL committed to `docs/projects/WEBSITE.md` (1-pager with the URL, what's on it, and how it's deployed)
- [ ] `docs/projects/INTERVIEW-NARRATIVES.md`
- [ ] Final update to `docs/CURRICULUM-MAP.md` with all module statuses
- [ ] Final update to `docs/LOG.md` with reflection

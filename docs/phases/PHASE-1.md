# Phase 1 Plan: Engineering Fundamentals

**Goal:** Build the minimum technical foundation that makes everything else easier. You can't do Docker, cloud, CI/CD, or AI engineering without these.

**Modules in dependency order:**
1. `cli-linux` — everything runs in a terminal
2. `git-github` — all artifacts live in git
3. `http-apis` — cloud, AI APIs, and debugging all speak HTTP
4. `postman` — do this alongside or right after http-apis
5. `sql` — independent; can be done in parallel with 3–4
6. `experimentation` — requires SQL; do after sql

---

## Module-by-module approach

### cli-linux
**Start here. Don't skip ahead.**

1. Read the "What it is" and "Core concepts" sections first — don't just jump to exercises.
2. Work through Exercise Sets 1–3 in order (navigation → pipes → environment variables).
3. Exercise Set 4 (shell script) is the capstone — do it last, commit the result.
4. Tick checks only when you can do it without looking anything up.

Key things to internalize before moving on:
- You should feel comfortable opening a terminal and navigating without a GUI
- You should understand what `$PATH` does
- You should be able to pipe two commands together and explain what each part does

### git-github
**Don't start until you're comfortable in the terminal.**

1. Read core concepts — pay special attention to the mental model (graph of snapshots).
2. Do Exercise Set 1 in this actual repo (not a throwaway). Real stakes help it stick.
3. Exercise Set 3 (merge conflict) is the hardest and most important — don't skip it.
4. Exercise Set 4 (PR flow) — open a real PR in this repo, even if it's trivial.

Key things to internalize:
- The difference between staging, committing, and pushing
- How to read `git log --oneline --graph`
- How to undo a commit without losing work (bookmark ohshitgit.com)

### http-apis + postman
**These go together — do them back-to-back.**

For http-apis:
1. Read the status codes section carefully — memorize the classes (2xx/3xx/4xx/5xx), not every code.
2. Do Exercise Set 1 (curl) before touching Postman — curl forces you to understand what's happening.
3. Exercise Set 2 (JSONPlaceholder) — do all three request types.

Then immediately do postman:
1. Exercise Set 1 — recreate the same requests you just did in curl, now in Postman.
2. Exercise Set 2 — add a real auth header (GitHub API token).
3. Export and commit the collection.

Key things to internalize:
- You should be able to make any HTTP request from your terminal using curl
- You should understand what headers are and why Authorization matters
- You should be able to explain what a 401 vs 403 means

> **→ Platform artifacts:** Produce `docs/projects/experimentation_platform/API-DESIGN.md` (from `http-apis`) and `docs/projects/experimentation_platform/API-COLLECTION.md` (from `postman`). Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### sql
**Can be done in parallel with http-apis — no dependency between them.**

1. Start with SQLBolt (sqlbolt.com) — complete all 18 lessons before anything else.
2. Then do Mode's in-browser queries for aggregations.
3. The window functions exercise is the hardest — watch the StatQuest video first if you're stuck.
4. Write `docs/reading/SQL-ANALYSIS-NOTES.md` at the end — this forces synthesis.

Key things to internalize:
- The JOIN types — draw a Venn diagram if it helps
- Why `GROUP BY` + `HAVING` vs `WHERE` — they filter at different stages
- When you'd reach for a window function instead of a GROUP BY

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/DATA-MODEL.md`. Design the database schema for the platform: experiments, variants, assignments, events, users, outcomes. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

### experimentation
**Do after sql — experiment analysis is SQL-heavy; you need that fluency first.**

The concepts here are the foundation of everything you're building. Don't rush through this module.

1. Read Chapters 1–4 of *Trustworthy Online Controlled Experiments* (Kohavi et al.) before doing any exercises. The book is worth owning. If you don't have it, the Microsoft ExP blog and Evan Miller's site together cover most of the ground.
2. Read the Evan Miller peeking article before touching Exercise Sets 1–2 — it reframes how you think about stopping rules.
3. Exercise Set 1 (metric design) — design for the experimentation platform itself. This forces you to apply the concepts to something real.
4. Exercise Set 2 (power analysis) — don't use a calculator as a black box. Work through the formula once by hand so you understand what's driving the sample size.
5. Exercise Set 3 (evaluation SQL) — write the ATE query yourself. Don't copy a template. The delta method for ratios is the hard part.
6. Exercise Set 4 (CUPED) — understand the variance reduction math before moving to Exercise Set 5.
7. Exercise Set 5 (advanced designs) — think through the SUTVA violation in each scenario before jumping to the answer.

Key things to internalize:
- Why randomization unit must match (or be coarser than) the unit of analysis
- What SRM means and why results are untrustworthy when it occurs
- Why peeking at p-values inflates false positive rates — understand the intuition, not just the rule
- CUPED: what the covariate is removing and why variance decreases

> **→ Platform artifact:** Produce `docs/projects/experimentation_platform/EXPERIMENT-METHODOLOGY.md`. This is the statistical specification that backs every decision in the platform: how you compute ATEs, how you handle multiple comparisons in HTE, when you apply CUPED, how you detect SRM. Write it as a document you'd share with a technical PM reviewing the platform. Open [ROADMAP.md](../projects/experimentation_platform/ROADMAP.md) for what to include.

---

## Suggested sequencing

If you want a loose ordering within the phase:

```
cli-linux (complete) →
  git-github (complete) →
    http-apis + postman (complete, in parallel) →
      sql (complete, can start anytime after cli-linux) →
        experimentation (complete, requires sql)
```

Don't move to Phase 2 until all six modules are marked `complete` in `docs/CURRICULUM-MAP.md`.

---

## Phase 1 is complete when:
- [ ] All six modules marked `complete` in the curriculum map
- [ ] At least one PR opened and merged in this repo
- [ ] `docs/projects/hello-cli.sh` committed (cli-linux artifact)
- [ ] `docs/projects/phase1-postman.json` committed (postman artifact)
- [ ] `docs/reading/SQL-ANALYSIS-NOTES.md` committed
- [ ] `docs/reading/EXPERIMENT-METRIC-DESIGN.md` committed
- [ ] `docs/reading/POWER-ANALYSIS-EXERCISE.md` committed
- [ ] `docs/reading/EXPERIMENT-ANALYSIS-SQL.md` committed
- [ ] `docs/reading/CUPED-EXERCISE.md` committed
- [ ] `docs/reading/ADVANCED-DESIGN-SELECTION.md` committed
- [ ] Glossary has entries for: shell, PATH, commit, branch, pull request, HTTP, REST, status code, JWT, SQL, JOIN, window function, ATE, MDE, statistical power, Type I error, Type II error, guardrail metric, randomization unit, SUTVA, SRM, CUPED, sequential testing, delta method, multiple comparisons

**Platform artifacts from this phase:**
- [ ] `docs/projects/experimentation_platform/API-DESIGN.md` (from `http-apis`)
- [ ] `docs/projects/experimentation_platform/API-COLLECTION.md` (from `postman`)
- [ ] `docs/projects/experimentation_platform/DATA-MODEL.md` (from `sql`)
- [ ] `docs/projects/experimentation_platform/EXPERIMENT-METHODOLOGY.md` (from `experimentation`)

**Next:** Open `docs/phases/PHASE-2.md`

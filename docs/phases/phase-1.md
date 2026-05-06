# Phase 1 Plan: Engineering Fundamentals

**Goal:** Build the minimum technical foundation that makes everything else easier. You can't do Docker, cloud, CI/CD, or AI engineering without these.

**Modules in dependency order:**
1. `cli-linux` — everything runs in a terminal
2. `git-github` — all artifacts live in git
3. `http-apis` — cloud, AI APIs, and debugging all speak HTTP
4. `postman` — do this alongside or right after http-apis
5. `sql` — independent; can be done in parallel with 3–4

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

### sql
**Can be done in parallel with http-apis — no dependency between them.**

1. Start with SQLBolt (sqlbolt.com) — complete all 18 lessons before anything else.
2. Then do Mode's in-browser queries for aggregations.
3. The window functions exercise is the hardest — watch the StatQuest video first if you're stuck.
4. Write `docs/reading/sql-analysis-notes.md` at the end — this forces synthesis.

Key things to internalize:
- The JOIN types — draw a Venn diagram if it helps
- Why `GROUP BY` + `HAVING` vs `WHERE` — they filter at different stages
- When you'd reach for a window function instead of a GROUP BY

---

## Suggested sequencing

If you want a loose ordering within the phase:

```
cli-linux (complete) →
  git-github (complete) →
    http-apis + postman (complete, in parallel) →
      sql (complete, can start anytime after cli-linux)
```

Don't move to Phase 2 until all five modules are marked `complete` in `docs/curriculum-map.md`.

---

## Phase 1 is complete when:
- [ ] All five modules marked `complete` in the curriculum map
- [ ] At least one PR opened and merged in this repo
- [ ] `docs/projects/hello-cli.sh` committed (cli-linux artifact)
- [ ] `docs/projects/phase1-postman.json` committed (postman artifact)
- [ ] `docs/reading/sql-analysis-notes.md` committed
- [ ] Glossary has entries for: shell, PATH, commit, branch, pull request, HTTP, REST, status code, JWT, SQL, JOIN, window function

**Next:** Open `docs/phases/phase-2.md`

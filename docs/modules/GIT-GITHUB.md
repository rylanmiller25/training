# Module: Git + GitHub

**Phase:** 1  
**Slug:** `git-github`  
**Status:** not started  

---

## What it is / how to think about it

Git is a distributed version control system — a time machine for code. GitHub is a hosting platform that adds collaboration: pull requests, code review, issues, and CI/CD triggers.

**Mental model:** Git is a graph of snapshots (commits). A branch is just a pointer to a commit. Merging moves that pointer. You are always working on a local copy; you pull down changes and push up yours.

Key insight: Git tracks *changes to content*, not files. That's why it can detect renames, merges, and conflicts.

---

## Prerequisites
- CLI/Linux module (terminal comfort, basic navigation)

---

## Best resources

**Primary:**
1. [Pro Git book](https://git-scm.com/book/en/v2) (free online) — chapters 1–3 cover everything needed; chapter 5 covers distributed workflows
2. [GitHub Skills](https://skills.github.com/) — interactive exercises directly in GitHub repos

**Supporting:**
- [Oh Shit, Git!?!](https://ohshitgit.com/) — how to undo common mistakes (bookmark this)
- [Git cheat sheet – GitHub](https://education.github.com/git-cheat-sheet-education.pdf)
- [Dangit, Git](https://dangitgit.com/) — same as above, less profane

**YouTube:**
- [Git and GitHub for Beginners – freeCodeCamp](https://www.youtube.com/watch?v=RGOj5yH7evk) (1 hr — best single video)
- [Git Internals – How Does Git Work? – Fireship](https://www.youtube.com/watch?v=P6jD966jzlk) (10 min — excellent mental model)

---

## Core concepts to cover

### Local git workflow
```
git init
git status
git add <file> / git add -p (interactive staging)
git commit -m "message"
git log --oneline --graph
git diff / git diff --staged
```

### Branching + merging
```
git branch <name>
git checkout <branch> / git switch <branch>
git checkout -b <name>  (create + switch)
git merge <branch>
git rebase <branch>  (understand conceptually; use with care)
```

### Working with remotes
```
git remote -v
git clone <url>
git pull / git fetch + git merge
git push origin <branch>
git push -u origin <branch>  (set upstream)
```

### Undoing things (critical — bookmark ohshitgit.com)
```
git restore <file>         # discard unstaged changes
git restore --staged <file> # unstage
git reset HEAD~1           # undo last commit, keep changes
git revert <hash>          # create new "undo" commit (safe for shared branches)
git stash / git stash pop
```

### GitHub collaboration model
- Fork vs clone
- Pull request lifecycle: branch → push → open PR → review → merge
- Code review: how to leave comments, request changes, approve
- Issues: how engineers track bugs and features
- `.gitignore` — what it does and why it matters

---

## Exercises

**Set 1 — Local workflow (20 min):**
1. In this training repo: `git log --oneline` — read the commit history.
2. Create a branch: `git checkout -b practice/week1`
3. Create `docs/scratch/TEST.md`, add some text, stage, and commit.
4. `git log --oneline` — confirm your commit appears.
5. Switch back to `main`: `git switch main`. Notice `TEST.md` is gone from main.

**Set 2 — Staging intentionally (20 min):**
1. Modify two different files.
2. Use `git add -p` (interactive) to stage only one file's changes.
3. Commit. See that the second file remains unstaged.
4. Run `git diff` and `git diff --staged` — understand the difference.

**Set 3 — Merge + conflict (30 min):**
1. On `main`, create `docs/scratch/CONFLICT.md` with "line 1". Commit.
2. Create branch `feature/conflict-test`. Change "line 1" to "feature version". Commit.
3. Switch to `main`. Change "line 1" to "main version". Commit.
4. `git merge feature/conflict-test` — you'll get a conflict.
5. Open the file, resolve the conflict markers, stage, and commit.

**Set 4 — GitHub PR flow (30–45 min):**
1. Push your `practice/week1` branch to GitHub: `git push -u origin practice/week1`
2. Open a pull request on GitHub — write a description.
3. Review the diff in the GitHub UI.
4. Merge the PR using the GitHub UI.
5. Pull the updated `main` locally: `git pull origin main`.

---

## Checks — you understand this when you can:
- [X] Explain what a commit, branch, and merge are without looking anything up
- [X] Create a branch, make changes, and open a pull request
- [X] Resolve a merge conflict
- [X] Use `git log --oneline --graph` to read history
- [X] Recover from common mistakes (undo a commit, unstage a file)
- [X] Explain the difference between `fetch` and `pull`
- [X] Explain what a `.gitignore` file does

---

## Artifacts to commit
- [X] `docs/scratch/` directory with practice files
- [X] At least one PR opened and merged on GitHub (this repo)
- [X] Glossary entries: commit, branch, merge, pull request, rebase, remote

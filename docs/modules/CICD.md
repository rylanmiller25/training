# Module: CI/CD + Testing + Deployment Pipelines

**Phase:** 2  
**Slug:** `cicd`  
**Status:** not started  

---

## What it is / how to think about it

CI/CD stands for Continuous Integration / Continuous Delivery (or Deployment). It's the practice of automatically building, testing, and deploying code whenever changes are pushed to a repo — eliminating manual, error-prone release processes.

**Mental model:** Think of CI/CD as an automated assembly line. Every time you push code, the pipeline runs checks (lint, tests, build) and, if they pass, ships the code to staging or production automatically.

- **CI (Continuous Integration):** merge code frequently + run automated checks on every push
- **CD (Continuous Delivery):** automatically prepare a deployable artifact; humans approve the final push to prod
- **CD (Continuous Deployment):** automatically deploy to prod on every green build (no human gate)

---

## Prerequisites
- Git/GitHub, CLI/Linux, Docker modules

---

## Best resources

**Primary:**
1. [GitHub Actions docs – Quickstart](https://docs.github.com/en/actions/quickstart) — hands-on, use this repo
2. [CI/CD explained – Atlassian](https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment) — clear conceptual breakdown

**Supporting:**
- [GitHub Actions marketplace](https://github.com/marketplace?type=actions) — reusable action catalog
- [act](https://github.com/nektos/act) — run GitHub Actions locally for faster iteration

**YouTube:**
- [GitHub Actions Tutorial – TechWorld with Nana](https://www.youtube.com/watch?v=R8_veQiYBjI) (32 min — best single intro)
- [CI/CD in 5 minutes – Fireship](https://www.youtube.com/watch?v=scEDHsr3APg) (6 min — mental model)
- [Testing JavaScript – Jack Herrington](https://www.youtube.com/watch?v=Jv2uxzhPFl4) (25 min — Jest basics)

---

## Core concepts to cover

### Testing basics
- **Unit tests:** test one function in isolation; fast; mock dependencies
- **Integration tests:** test how components work together (e.g. service + real DB)
- **End-to-end (E2E) tests:** simulate a real user flow through the full stack
- **Test pyramid:** many unit → fewer integration → few E2E (speed vs confidence tradeoff)
- **Code coverage:** % of lines executed by tests (useful metric; not the only metric)
- **TDD (Test-Driven Development):** write failing test first, then code to make it pass

### GitHub Actions anatomy
```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "18"
      - run: npm ci
      - run: npm test
      - run: npm run build
```

### Key GitHub Actions concepts
- **Trigger (`on:`)**: push, pull_request, schedule, workflow_dispatch (manual)
- **Jobs:** parallel units of work; each gets a fresh runner
- **Steps:** sequential commands within a job
- **`uses:`** — reference a pre-built action (e.g. `actions/checkout@v4`)
- **`run:`** — execute a shell command
- **Secrets:** `${{ secrets.MY_API_KEY }}` — store credentials safely in repo settings
- **Environments:** dev, staging, prod — with protection rules and approvals
- **Matrix builds:** test across multiple versions
```yaml
strategy:
  matrix:
    node: [18, 20, 22]
```

### Deployment pipeline patterns
1. **Build → Test → Deploy to staging → Manual approve → Deploy to prod**
2. **Feature flags:** deploy dark (code ships but feature is off); toggle per user/cohort
3. **Blue/green deployment:** run two prod environments; switch traffic; rollback by switching back
4. **Canary deployment:** send 5% of traffic to new version; watch metrics; ramp up or rollback

### Branch protection rules (GitHub)
- Require status checks to pass before merging
- Require at least 1 approving review
- Prevent force-pushes to main
- These enforce the pipeline as a gate on every PR

---

## Exercises

**Set 1 — First GitHub Action (30 min):**
In this training repo, create `.github/workflows/ci.yml`:
1. Trigger on push and pull_request to main
2. One job: echo "Hello from CI" and list files with `ls -la docs/`
3. Push — check the Actions tab on GitHub. Watch it run.
4. Introduce a syntax error and push again — see it fail.

**Set 2 — Writing tests (45 min):**
Create a small TypeScript utility in `docs/projects/utils/`:
1. `math.ts` — export functions: `add(a, b)`, `divide(a, b)` (throws on divide by zero)
2. `math.test.ts` — tests using Vitest or Jest:
   - `add(2, 3)` returns 5
   - `divide(10, 2)` returns 5
   - `divide(5, 0)` throws an error
3. Run tests locally: `npx vitest` or `npx jest`

**Set 3 — CI with tests (20 min):**
Update your `.github/workflows/ci.yml` to:
1. Set up Node 18
2. Run `npm install` (or `npm ci`)
3. Run the test suite
4. Push — confirm tests run and pass in GitHub Actions

**Set 4 — Understand a real pipeline (20 min):**
Find an open-source project on GitHub that uses GitHub Actions. (Examples: `vitejs/vite`, `prisma/prisma`, `expressjs/express`)
1. Read its `.github/workflows/*.yml` files
2. Write a 5-bullet summary in `docs/reading/CICD-REAL-PIPELINE-NOTES.md`:
   - What triggers the pipeline?
   - What jobs run?
   - Are there matrix builds?
   - What gets deployed and where?
   - What would break if CI was removed?

---

## Integration with n8n
GitHub Actions handles code-path automation (build, test, deploy). n8n handles everything else — event-driven business workflows that engineers shouldn't need to touch. A mature team uses both:
- GitHub Actions: `push → test → deploy`
- n8n: `deploy succeeded → notify Slack → update Linear → trigger QA workflow`

When you finish this module, go straight to the `n8n` module to see the other half of the automation picture.

---

## Checks — you understand this when you can:
- [ ] Explain the difference between CI and CD
- [ ] Write a GitHub Actions workflow from scratch
- [ ] Explain the test pyramid and when to use each test type
- [ ] Write unit tests for a simple function including an error case
- [ ] Explain what branch protection rules do and why they matter
- [ ] Explain blue/green vs canary deployments and the tradeoff

---

## Artifacts to commit
- [ ] `.github/workflows/ci.yml` — working GitHub Actions pipeline
- [ ] `docs/projects/utils/math.ts` + `math.test.ts`
- [ ] `docs/reading/CICD-REAL-PIPELINE-NOTES.md`
- [ ] Glossary entries: CI, CD, unit test, integration test, E2E test, pipeline, branch protection, canary deployment
- [ ] Log entry in `docs/LOG.md`

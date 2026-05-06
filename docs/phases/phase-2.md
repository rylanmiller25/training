# Phase 2 Plan: Shipping Software

**Goal:** Understand how software actually gets built, packaged, deployed, and operated at a basic level. These are the tools and patterns behind every production system.

**Modules:**
1. `docker` — containers are the delivery unit for everything
2. `cloud` — where things run
3. `cicd` — how changes get from code to production
4. `system-design` — how to reason about architecture
5. `security` — how to not get owned

The first three have a loose dependency (docker → cloud → cicd is a natural order). System design and security are independent and can be done in any position.

---

## Module-by-module approach

### docker
**Start here. Build something tangible.**

1. Read the mental model first: image vs container, like a class vs an instance.
2. Exercise Set 1 (pull and run) — before you build anything, just run pre-existing images. `docker run hello-world` → `ubuntu bash` → `nginx`.
3. Exercise Set 2 (build your own image) — this is the core exercise. Don't skip it. The Dockerfile you write here is the template for everything you'll do with AI APIs in Phase 5.
4. Exercise Set 3 (Compose) — multi-container apps. This is how production apps run.
5. Exercise Set 4 (layer caching) — a 15-minute experiment that will save you hours of frustration later.

Key things to internalize:
- Why layer order matters in a Dockerfile
- The difference between a volume and a bind mount
- How `docker compose up` differs from running containers manually

### cloud
**After docker — cloud is where containers live.**

1. Read the conceptual sections before anything else. Understand IaaS/PaaS/SaaS.
2. Exercise Set 1 (conceptual mapping) — do this without Google first, then check.
3. Exercise Set 2 (cost estimation) — spend real time here. Pricing intuition is rare and valuable.
4. Exercise Set 3 (deploy something) — get something live. Use Railway or Render free tier. The goal is a real URL that works.
5. Exercise Set 4 (serverless function) — Vercel or Netlify. See how different the mental model is from a VM.

Key things to internalize:
- The specific AWS service for each of: file storage, running a container, triggered function, managed Postgres
- Why data egress costs money and ingress is free
- What a VPC and security group do

### cicd
**After git-github and docker — CI/CD connects them.**

1. Read the testing section before the GitHub Actions section. Tests are the reason CI matters.
2. Exercise Set 1 (first GitHub Action) — get something running in GitHub Actions, even if it's just `echo "hello"`. Watch it run in the browser.
3. Exercise Set 2 (write tests) — the TypeScript math functions. Simple, but forces you to understand test structure.
4. Exercise Set 3 (CI with tests) — combine them. Your tests should run on every push.
5. Exercise Set 4 (read a real pipeline) — pick an open-source project and read its workflow files. This is more valuable than it sounds.

Key things to internalize:
- The difference between a unit test and an integration test
- What branch protection rules do and why they matter
- The difference between continuous delivery and continuous deployment

### system-design
**Can be done any time in Phase 2 — no hard dependency.**

1. Read the "request lifecycle" section first — you need this mental model before anything else.
2. Exercise Set 1 (diagram a system) — draw on paper. Don't skip because it feels low-tech.
3. Exercise Set 2 (tradeoff analysis) — the point isn't to get a "right" answer. It's to practice reasoning about tradeoffs.
4. Exercise Set 3 (read a real design doc) — pick one of the linked articles and read it properly, not skimming.
5. Exercise Set 4 (URL shortener design) — classic intro problem. Write it out fully even if it feels simple.

Key things to internalize:
- Cache-aside caching and the invalidation problem
- When to use a message queue vs a direct API call
- CAP theorem in one sentence

### security
**Do this last in Phase 2 — it builds on HTTP, SQL, and cloud.**

1. Read the OWASP Top 10 first. All of them. Then do Exercise Set 1.
2. Exercise Set 2 (JWT decoder) — actually decode a token at jwt.io. Understand why you can't fake one.
3. Exercise Set 3 (find a misconfiguration) — check this repo and your other projects for `.env` in git history.
4. Exercise Set 4 (OAuth flow diagram) — draw it out. This will come up in interviews.

Key things to internalize:
- The difference between authentication and authorization
- Why parameterized queries prevent SQL injection
- The OAuth 2.0 Authorization Code flow step by step

---

## Phase 2 is complete when:
- [ ] All five modules marked `complete` in the curriculum map
- [ ] `docs/projects/docker-hello/` committed with Dockerfile + docker-compose.yml
- [ ] `.github/workflows/ci.yml` committed and running in GitHub Actions
- [ ] `docs/projects/utils/math.ts` + `math.test.ts` committed
- [ ] `docs/reading/system-design-tradeoffs.md` committed
- [ ] `docs/reading/url-shortener-design.md` committed
- [ ] `docs/reading/owasp-scenarios.md` committed
- [ ] Glossary has entries for: container, image, Docker Compose, VPC, serverless, CI/CD, unit test, sharding, CAP theorem, SQL injection, JWT

**Next:** Open `docs/phases/phase-3.md` and `docs/phases/phase-4.md` — these can run in parallel.

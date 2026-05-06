# Module: n8n — Workflow Automation

**Phase:** 2 — integrated tool module  
**Slug:** `n8n`  
**Status:** not started

---

## What it is / how to think about it

n8n is an open-source workflow automation platform that lets you connect apps, APIs, and services with a visual canvas — while still supporting custom JavaScript/Python code for anything complex. Think of it as a programmable glue layer between systems.

**Mental model:** n8n is a flowchart that runs. Each node is a step: receive a webhook, call an API, transform data, send a Slack message. You wire nodes together and the workflow executes in order. It sits between pure code (too heavy for simple automations) and consumer tools like Zapier (too limited for technical users).

Why it matters: real products are full of workflows — "when a form is submitted, save to database, send confirmation email, notify Slack." n8n is where you build and understand those patterns. It also has native AI nodes, making it directly applicable to Phase 5.

---

## Prerequisites
- HTTP + APIs module (every node is an HTTP call or webhook)
- Git/GitHub module (to self-host or use n8n cloud)

---

## Best resources

**Primary:**
1. [n8n official docs](https://docs.n8n.io/) — start with the quickstart and concepts section
2. [n8n workflow templates library](https://n8n.io/workflows/) — 900+ real workflows to learn from; browse before building

**Supporting:**
- [n8n community forum](https://community.n8n.io/) — active; search before asking
- [n8n GitHub](https://github.com/n8n-io/n8n) — read the README; understand the self-host setup

**YouTube:**
- [n8n crash course – Leon van Zyl](https://www.youtube.com/watch?v=1MwSoB0gnM4) (1 hr — best structured intro)
- [n8n AI workflows – Leon van Zyl](https://www.youtube.com/watch?v=eBqlkRMkEL4) (45 min — AI-specific patterns)

---

## Core concepts to cover

### The n8n model
- **Workflow:** a directed graph of nodes
- **Node:** a single step — trigger, action, transform, or conditional
- **Trigger node:** starts the workflow (webhook, cron, email, form, app event)
- **Action node:** does something (send email, call API, write to database, post to Slack)
- **Item:** the unit of data flowing through the workflow (like a row or event)
- **Expressions:** `{{ $json.fieldName }}` — JavaScript-like syntax to reference data from upstream nodes

### Trigger types
- **Webhook:** HTTP POST to a generated URL → starts the workflow
- **Schedule (cron):** run on a timer
- **App trigger:** an event in a connected app (e.g. new GitHub issue, new Notion page)
- **Manual:** click "Execute" in the UI (for testing)

### Key node types
- **HTTP Request:** call any REST API (like curl, but visual)
- **Code:** write JavaScript or Python inline
- **If / Switch:** conditional branching
- **Set:** add or transform fields on the item
- **Merge:** combine data from multiple branches
- **AI Agent (native):** connect an LLM with tools; n8n handles the loop
- **400+ integration nodes:** Slack, Gmail, Google Sheets, Notion, GitHub, Stripe, Supabase, Linear, Airtable…

### n8n + AI
n8n has first-class AI support:
- **AI Agent node:** give an LLM a set of tools (other n8n nodes as tools); it reasons and acts
- **LLM Chain node:** single-shot prompt with template variables
- **Memory nodes:** give the AI conversation history or vector store access
- **Tool nodes:** wrap any HTTP request, database query, or n8n node as an AI-callable tool
- This makes n8n an alternative to LangChain for teams that want visual pipelines over code

### Self-hosting vs cloud
- **n8n Cloud:** managed; free tier (limited executions); fastest to start
- **Self-hosted:** Docker-compose (one command); free; full control; data stays on your machine
- Use self-hosted for anything involving sensitive credentials or data

---

## Exercises

**Set 1 — First workflow (30 min):**
Sign up for n8n Cloud (free tier) or self-host with Docker:
```bash
docker run -it --rm --name n8n -p 5678:5678 n8nio/n8n
```
Build a workflow:
1. Trigger: manual
2. HTTP Request node → GET `https://jsonplaceholder.typicode.com/posts/1`
3. Set node → extract `title` and `body` fields
4. View the output
Execute it. Inspect the data at each step.

**Set 2 — Webhook trigger (30 min):**
Build a workflow:
1. Trigger: Webhook (copy the generated URL)
2. Set node → add a field: `received_at: {{ $now }}`
3. Respond to Webhook node → return JSON `{"status": "ok", "data": {{ $json }}}`
Test it: `curl -X POST <your-webhook-url> -H "Content-Type: application/json" -d '{"message": "hello"}'`
This is the pattern behind every form submission, payment webhook, and app integration.

**Set 3 — Multi-step automation (45 min):**
Build a workflow that:
1. Triggers on a webhook (or schedule)
2. Calls the GitHub API to get the 5 most recent commits in this training repo
3. Formats them as a bullet list
4. Posts the list to a Slack channel (or saves to a file if no Slack)
This connects HTTP + APIs, auth headers, data transformation, and an integration node.

**Set 4 — AI agent workflow (45 min):**
Build a workflow with n8n's AI Agent node:
1. Trigger: webhook (receives a user question)
2. AI Agent node:
   - Model: pick any available (Claude or GPT-4)
   - Tools: add an HTTP Request tool that searches Wikipedia, and a Code tool that does simple math
3. Respond to webhook with the agent's answer
Ask it a question that requires using one of the tools. Watch the reasoning steps in the execution log.
Save the exported workflow JSON to `docs/projects/n8n-ai-agent-workflow.json`.

**Set 5 — Explore the template library (20 min):**
Browse [n8n.io/workflows](https://n8n.io/workflows). Find 3 workflows that:
- Solve a problem you recognize
- Use an integration you've worked with (GitHub, Notion, Slack)
- Involve AI

Import one into your n8n instance. Run it. Read every node.
Write observations in `docs/reading/N8N-TEMPLATE-NOTES.md`.

---

## Integration points with the rest of the curriculum

- **CI/CD (cicd module):** n8n as an event-driven complement to GitHub Actions — use webhooks to trigger n8n workflows from GitHub events (new PR, merged commit, failed test)
- **AI telemetry (ai-telemetry module):** n8n to build monitoring pipelines — poll your AI feature's quality metrics, alert on drift, route failures to a review queue
- **HITL (hitl module):** n8n to build human review queues — when AI output score is low, create a Linear ticket and route to a reviewer
- **Keystroke (keystroke module):** Keystroke is TypeScript-native and code-first; n8n is visual-first. Understand both as complementary tools for different contexts

---

## Checks — you understand this when you can:
- [ ] Explain what a webhook trigger is and build one that receives and responds to a POST request
- [ ] Chain 3+ nodes together with data flowing between them using expressions
- [ ] Explain when you'd use n8n vs writing the automation in code
- [ ] Build an AI agent workflow that uses at least 2 tools
- [ ] Explain the difference between self-hosted n8n and n8n Cloud

---

## Artifacts to commit
- [ ] `docs/projects/n8n-ai-agent-workflow.json` — exported workflow
- [ ] `docs/reading/N8N-TEMPLATE-NOTES.md`
- [ ] Glossary entries: n8n, workflow automation, webhook trigger, node, expression
- [ ] Log entry in `docs/LOG.md`

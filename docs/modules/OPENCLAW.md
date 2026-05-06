# Module: OpenClaw — Local Autonomous AI Agent

**Phase:** 5  
**Slug:** `openclaw`  
**Status:** not started

---

## What it is / how to think about it

OpenClaw is an open-source, privacy-first personal AI agent that runs entirely on your own machine and is accessible via messaging platforms (Telegram, Discord, Signal, WhatsApp). It can browse the web, read and write files, execute shell commands, and run web automation — 24/7, without sending your data to external servers.

**Mental model:** OpenClaw is a local server that connects your messaging app to an AI agent with real computer access. You send a message on Telegram; it executes a task on your machine (or a cloud VM you own) and sends back the result. It's the closest thing to a personal AI that genuinely acts in the world.

Why it's in the curriculum: OpenClaw is an excellent hands-on subject for studying autonomous agent behavior — both its capabilities and its failure modes. Red-teaming, HITL design, and telemetry all become more concrete when you're running and observing a real agent, not theorizing about one.

---

## Prerequisites
- LLM Failures module (Phase 4) — understand what can go wrong before giving an agent real computer access
- Red-teaming module (Phase 5) — attack patterns are directly applicable
- HITL module (Phase 5) — you'll design review gates for OpenClaw actions

---

## Best resources

**Primary:**
1. [OpenClaw GitHub](https://github.com/openclaw/openclaw) — installation, architecture, and AgentSkills documentation
2. [OpenClaw.ai](https://openclaw.ai/) — official site; setup guides and skill catalog

**Supporting:**
- [Telegram Bot API docs](https://core.telegram.org/bots/api) — needed to configure the messaging interface
- [AgentSkills documentation](https://github.com/openclaw/openclaw) — catalog of 100+ built-in skills

---

## Core concepts to cover

### How OpenClaw works
1. You send a message via Telegram (or another supported platform)
2. The message hits the OpenClaw server running on your machine
3. The LLM (local or API-based) interprets the request and selects skills to use
4. Skills execute: shell commands run, files are read/written, URLs are fetched
5. The result is sent back to your messaging app

### AgentSkills
The 100+ built-in skills are the key abstraction. Each skill is a capability the agent can invoke:
- **Shell execution:** run arbitrary commands on the host machine
- **File management:** read, write, list, move files
- **Web automation:** browse URLs, fill forms, extract content
- **Web search:** search and retrieve results
- **Code execution:** run Python or JavaScript inline

This is architecturally similar to the tool-use pattern in LangChain and Keystroke — the agent decides which skill to invoke based on the user's request.

### Privacy architecture
- LLM can run locally (Ollama + Llama/Mistral) or via API (OpenAI, Anthropic)
- All data stays on your machine unless you use an external API model
- Credentials and file contents never leave the host
- This makes it usable for sensitive personal workflows

### Safety considerations (critical)
OpenClaw has real access to your machine. Before running:
- Run in a sandboxed environment (Docker container or VM) — not on your primary machine until you understand what it's doing
- Review what shell commands it's allowed to execute
- Set up a test environment with no sensitive files or credentials
- Understand: this is a local red-team target as much as a useful tool

### Connecting to external services
OpenClaw can integrate with external APIs via its HTTP skill:
- Query your own APIs
- Post to webhooks (triggering n8n or Keystroke workflows)
- Read from data sources

---

## Exercises

**Set 1 — Setup in a safe environment (45 min):**
Install OpenClaw in a Docker container or a fresh VM (not your primary machine):
```bash
# Basic Docker setup (check OpenClaw docs for current command)
docker run -it openclaw/openclaw
```
Connect it to a Telegram bot (create one via BotFather — takes 5 min).
Send your first message. Confirm it responds.
Document your setup steps in `docs/projects/OPENCLAW-SETUP.md`.

**Set 2 — Skill exploration (30 min):**
Using your running OpenClaw instance, test 5 different skill types:
1. Ask it to list files in its home directory
2. Ask it to fetch and summarize a URL
3. Ask it to do a web search and return the top 3 results
4. Ask it to write a short script and run it
5. Ask it to do something multi-step (e.g. search for something, fetch the top result, summarize it)
For each: does it do what you expected? What was surprising?
Write observations in `docs/reading/OPENCLAW-SKILL-OBSERVATIONS.md`.

**Set 3 — Red-team it (45 min):**
Apply the red-teaming framework from the `red-teaming` module:
1. Attempt prompt injection via your Telegram message
2. Try to get it to run a command you didn't explicitly request
3. Test what happens with an ambiguous or underspecified request (does it ask for clarification or guess?)
4. Test what happens when a skill fails — does it report the error clearly?
5. Attempt to get it to leak information about its configuration
Document every attempt and outcome in `docs/projects/OPENCLAW-RED-TEAM.md`.

**Set 4 — Design HITL guardrails (30 min):**
Based on your red-team findings, design a set of review gates for an OpenClaw deployment:
- Which skill categories should require confirmation before execution? (e.g. file deletion, shell commands)
- How would you implement a "dry run" mode that shows what it would do without doing it?
- What would a confirmation message look like in Telegram?
- How would you log all actions for later review?
Save to `docs/reading/OPENCLAW-HITL-DESIGN.md`. This is directly applicable to the HITL module's design principles.

**Set 5 — Connect to your automation stack (30 min):**
Configure OpenClaw to trigger an n8n webhook:
1. Create a simple n8n workflow with a webhook trigger
2. Ask OpenClaw (via Telegram) to call that webhook with a payload
3. Confirm the n8n workflow fires and processes the data
This connects three tools: OpenClaw (agent), n8n (workflow), and your own API endpoint.
Document in `docs/projects/OPENCLAW-N8N-INTEGRATION.md`.

---

## Integration points with the rest of the curriculum

- **Red-teaming:** OpenClaw is one of the best hands-on targets for adversarial testing — it has real system access, making the stakes feel concrete
- **HITL design:** designing confirmation gates for OpenClaw is a realistic HITL design exercise
- **AI telemetry:** logging all OpenClaw executions is a natural telemetry exercise — what would you track?
- **n8n:** OpenClaw can trigger n8n workflows via webhooks; n8n can call OpenClaw back; they're complementary
- **LLM failures:** observe failures firsthand — when does the agent misinterpret, loop, or use the wrong skill?
- **Capstone:** an OpenClaw-based personal assistant agent (customized with skills relevant to your workflow) is a viable capstone demo

---

## Checks — you understand this when you can:
- [ ] Set up OpenClaw in a sandboxed environment and connect it to a messaging platform
- [ ] Describe the AgentSkills architecture and how it maps to the tool-use pattern
- [ ] Conduct a structured red-team session against a running agent and document findings
- [ ] Design a HITL review system for a specific category of agent actions
- [ ] Explain the privacy tradeoffs between local LLM vs API LLM for OpenClaw

---

## Artifacts to commit
- [ ] `docs/projects/OPENCLAW-SETUP.md`
- [ ] `docs/reading/OPENCLAW-SKILL-OBSERVATIONS.md`
- [ ] `docs/projects/OPENCLAW-RED-TEAM.md`
- [ ] `docs/reading/OPENCLAW-HITL-DESIGN.md`
- [ ] `docs/projects/OPENCLAW-N8N-INTEGRATION.md`
- [ ] Glossary entries: OpenClaw, AgentSkill, local agent, sandboxed execution, Telegram bot
- [ ] Log entry in `docs/LOG.md`

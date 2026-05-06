# Module: Keystroke — Production AI Agent Platform

**Phase:** 5  
**Slug:** `keystroke`  
**Status:** not started

---

## What it is / how to think about it

Keystroke is a managed platform for building and deploying TypeScript-based AI agents and workflows. It's designed to be the production environment where you take the patterns from LangChain, RAG, and prompt engineering modules and ship them as real, running agents — with MCP server support, 100+ integrations, persistent storage, webhooks, cron triggers, and spend controls built in.

**Mental model:** If LangChain is a library you import into your own app, Keystroke is the infrastructure layer on top of it. You write your agent logic in TypeScript; Keystroke handles execution, retries, credential management, team sharing, and connecting to external services. Think of it like Vercel for AI agents.

Particularly relevant for this training program: Keystroke exposes agents as MCP servers, meaning the agents you build are directly usable inside Claude Code and Cursor — closing the loop between what you're learning and the tools you're using to learn.

---

## Prerequisites
- Prompt Engineering, LangChain, RAG modules (Phase 5)
- CI/CD module (Phase 2) — helpful for understanding deployment patterns
- n8n module (Phase 2) — useful contrast: n8n is visual-first; Keystroke is code-first

---

## Best resources

**Primary:**
1. [Keystroke.ai docs](https://www.keystroke.ai/) — official platform docs and getting started guides
2. [Keystroke template library](https://www.keystroke.ai/) — browse existing agents and workflows to understand the patterns

**Supporting:**
- [MCP (Model Context Protocol) overview – Anthropic](https://docs.anthropic.com/en/docs/build-with-claude/mcp) — understand how Keystroke exposes agents as MCP servers
- [Anthropic Claude Code docs](https://docs.anthropic.com/en/docs/claude-code) — how to connect Keystroke agents as MCP tools in Claude Code

---

## Core concepts to cover

### The Keystroke model
- **Agent:** a TypeScript program with a system prompt, tools, and memory; runs on Keystroke's infrastructure
- **Workflow:** a TypeScript script that executes steps in order (like n8n, but in code)
- **Skill:** a reusable function that agents and workflows can call (browse web, read file, query DB)
- **Trigger:** what starts a workflow — webhook, cron, Slack message, GitHub event, manual
- **Integration:** a connected external service (Slack, Notion, GitHub, Linear, Gmail, Stripe…)
- **MCP server:** Keystroke can expose your agent as an MCP server, making it callable from Claude Code, Cursor, and ChatGPT

### What Keystroke provides out of the box
- **Persistent file system:** agents can read/write files across runs
- **SQLite database:** lightweight persistent storage per agent
- **Memory system:** structured key-value memory that persists between conversations
- **Web search + browser automation:** built-in skills; no need to wire up external APIs
- **Sandbox environments:** safe execution context; agent can run shell commands
- **Durable execution:** automatic retries, replay on failure
- **Spend controls:** per-agent model budgets; usage tracking; API key scoping
- **RBAC:** team and organization sharing with role-based permissions

### TypeScript agent pattern
```typescript
// A Keystroke agent (conceptual structure)
export default {
  name: "research-agent",
  description: "Researches a topic and summarizes findings",
  systemPrompt: `You are a research assistant. Use your tools to find 
    information, then synthesize a clear summary.`,
  tools: [webSearch, fetchUrl, saveToMemory],
  model: "claude-sonnet-4-6",
};
```

### MCP integration with Claude Code
Keystroke can expose any agent or workflow as an MCP server endpoint. Once configured:
- Claude Code can call your Keystroke agents as tools
- Your agents can call Claude Code back via the API
- This creates a loop: Claude Code → Keystroke agent → external services → response back to Claude Code

### Keystroke vs alternatives
| | Keystroke | n8n | LangChain | Raw SDK |
|--|--|--|--|--|
| Primary interface | TypeScript code | Visual canvas | Python/TS library | Python/TS library |
| Hosting | Managed | Self-hosted or cloud | You manage | You manage |
| AI-first | Yes | Partial | Yes | Yes |
| MCP support | Yes | No | No | Via Anthropic SDK |
| 100+ integrations | Yes | Yes (400+) | Via tools | Manual |
| Best for | Production AI agents | Business automation | Custom pipelines | Full control |

---

## Exercises

**Set 1 — First agent (45 min):**
Sign up for Keystroke. Create a new agent:
1. System prompt: "You are a research assistant. When given a topic, search the web and return a 3-bullet summary."
2. Add the web search skill
3. Test it in the Keystroke UI with 3 different topics
4. Observe: how does it decide when to use the tool vs answer from memory?

**Set 2 — Workflow with integrations (45 min):**
Build a workflow that:
1. Triggers on a webhook (or manual run)
2. Accepts a GitHub repo URL as input
3. Fetches the README from the GitHub API
4. Passes it to an LLM to generate a 5-bullet "what this repo does" summary
5. Posts the summary to a Slack channel (or saves to a file)
This is a realistic internal tooling pattern.

**Set 3 — Persistent memory agent (45 min):**
Build an agent that:
1. Accepts a topic or question
2. Checks its memory for prior research on that topic
3. If found: returns the cached summary and asks if you want to update it
4. If not found: searches the web, summarizes, and saves to memory
5. On subsequent runs with the same topic, it should use the cache
This is the pattern behind knowledge management agents.

**Set 4 — MCP server setup (30 min):**
Configure a Keystroke agent as an MCP server and connect it to Claude Code:
1. In Keystroke, expose your research agent as an MCP endpoint
2. In Claude Code, add the MCP server configuration
3. From a Claude Code session, invoke the agent as a tool
4. Verify it runs end-to-end
Document the setup steps in `docs/projects/keystroke-mcp-setup.md`. This is a working integration you can keep using.

**Set 5 — Red-team your agent (30 min):**
Use the red-teaming techniques from the `red-teaming` module against your own Keystroke agent:
1. Attempt a prompt injection via the input
2. Try to get the agent to make unintended tool calls
3. Test behavior on edge-case inputs (empty, very long, adversarial)
4. Add guardrails to the system prompt based on what you find
Document findings in `docs/projects/keystroke-red-team.md`.

---

## Integration points with the rest of the curriculum

- **Capstone:** Keystroke is an excellent platform for your capstone demo — build and deploy a real agent rather than a local script
- **n8n:** where n8n handles business automation workflows visually, Keystroke handles AI agent logic in TypeScript — use both; they complement each other
- **LangChain:** Keystroke provides the infrastructure layer that LangChain lacks (hosting, retries, credential management, team sharing)
- **AI telemetry:** Keystroke's built-in execution logs and spend tracking are a form of telemetry — supplement with custom logging if needed
- **HITL:** Build HITL review flows in Keystroke — low-confidence agent outputs create a Linear ticket and pause execution until reviewed

---

## Checks — you understand this when you can:
- [ ] Build and deploy a working Keystroke agent with at least one tool
- [ ] Explain what Keystroke provides that you'd have to build yourself with raw SDK
- [ ] Connect a Keystroke agent as an MCP server in Claude Code
- [ ] Build an agent with persistent memory that behaves differently on repeat inputs
- [ ] Articulate when you'd use Keystroke vs n8n vs writing a LangChain pipeline

---

## Artifacts to commit
- [ ] `docs/projects/keystroke-mcp-setup.md` — MCP server connection steps
- [ ] `docs/projects/keystroke-red-team.md` — red-team findings
- [ ] Glossary entries: Keystroke, MCP server, durable execution, persistent memory, agent skill, spend controls
- [ ] Log entry in `docs/log.md`

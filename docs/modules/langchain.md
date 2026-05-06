# Module: LangChain / LangGraph Patterns

**Phase:** 5  
**Slug:** `langchain`  
**Status:** not started  

---

## What it is / how to think about it

LangChain is a framework for composing LLM applications; LangGraph is its extension for stateful, multi-step agent workflows. They provide abstractions for: chains (sequences of LLM calls), tools (functions the LLM can invoke), memory (persistence across turns), and agents (LLMs that decide their own next steps).

**Caution:** LangChain adds abstraction overhead. Use it when its patterns genuinely reduce complexity — not as a default. Many production systems use the Anthropic/OpenAI SDK directly for simple use cases.

**Mental model:** LangChain is like a plumbing framework for LLM apps. It provides pre-built connectors (document loaders, vector stores, LLM clients) and pipes (chains, agents). Understand the patterns it implements, not just the API — you'll recognize them in any framework.

---

## Prerequisites
- Prompt Engineering, RAG, Embeddings modules

---

## Best resources

**Primary:**
1. [LangChain Expression Language (LCEL) docs](https://python.langchain.com/docs/expression_language/) — the current, idiomatic way to use LangChain
2. [LangGraph docs](https://langchain-ai.github.io/langgraph/) — for multi-agent and stateful workflows

**Supporting:**
- [LangChain cookbook](https://github.com/langchain-ai/langchain/tree/master/cookbook) — real examples
- [LangSmith docs](https://docs.smith.langchain.com/) — tracing and evaluation integration

**YouTube:**
- [LangChain explained – Greg Kamradt](https://www.youtube.com/watch?v=_v_fgW2SkkQ) (20 min — practical patterns)
- [LangGraph tutorial – LangChain](https://www.youtube.com/watch?v=pbAd8O1Lvm4) (30 min)

---

## Core concepts

### LCEL (LangChain Expression Language)
The pipe `|` chains components together:
```python
from langchain_anthropic import ChatAnthropic
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

prompt = ChatPromptTemplate.from_template("Summarize: {text}")
model = ChatAnthropic(model="claude-sonnet-4-6")
parser = StrOutputParser()

chain = prompt | model | parser
result = chain.invoke({"text": "..."})
```

### Retrieval chain (RAG pattern)
```python
from langchain_core.runnables import RunnablePassthrough

retriever = vectorstore.as_retriever(search_kwargs={"k": 4})
rag_chain = (
    {"context": retriever, "question": RunnablePassthrough()}
    | prompt
    | model
    | parser
)
```

### Tool use / function calling
```python
from langchain_core.tools import tool

@tool
def search_docs(query: str) -> str:
    """Search internal documentation."""
    return retriever.invoke(query)

model_with_tools = model.bind_tools([search_docs])
```

### LangGraph: stateful agents
- **Nodes:** functions that take state and return updated state
- **Edges:** define which node runs next (conditional or fixed)
- **State:** typed dict that flows through the graph
- **Cycles:** graphs can loop — agent decides when to stop

```python
from langgraph.graph import StateGraph, END

def agent_node(state):
    # call model, decide next action
    return {"messages": [...]}

def tool_node(state):
    # execute tool
    return {"messages": [...]}

graph = StateGraph(State)
graph.add_node("agent", agent_node)
graph.add_node("tools", tool_node)
graph.add_conditional_edges("agent", should_use_tool, {"yes": "tools", "no": END})
graph.add_edge("tools", "agent")
```

### When to use LangChain vs raw SDK
| Use LangChain when: | Use raw SDK when: |
|---------------------|------------------|
| Building RAG with multiple retrievers | Single LLM call |
| Complex multi-step agents | Simple chat applications |
| Need built-in tracing (LangSmith) | Full control over prompts |
| Rapid prototyping | Production where you need minimal deps |

### Key patterns (framework-agnostic)
- **Router:** LLM classifies intent → routes to different chains
- **ReAct (Reason + Act):** LLM reasons about what to do, executes a tool, observes result, repeats
- **Plan + execute:** LLM makes a plan upfront; then executes steps
- **Reflection:** LLM critiques its own output; revises

---

## Exercises

**Set 1 — Basic LCEL chain (30 min):**
Build a chain that:
1. Takes a topic as input
2. Generates 5 bullet points about it
3. Then summarizes those bullet points in one sentence
Chain two LLM calls together using LCEL. Save to `docs/projects/langchain-basic/`.

**Set 2 — RAG with LangChain (45 min):**
Rebuild your RAG project from the RAG module using LangChain:
1. Use `RecursiveCharacterTextSplitter` for chunking
2. Use a LangChain vector store (Chroma or in-memory)
3. Build a retrieval chain using LCEL
4. Compare to your hand-rolled version: what did LangChain simplify? What did it obscure?
Save to `docs/projects/langchain-rag/`.

**Set 3 — Simple ReAct agent (45 min):**
Build an agent with 2 tools:
1. `get_weather(city: str)` — returns fake weather data
2. `get_time(timezone: str)` — returns current time
Use LangGraph or LangChain's `create_react_agent`. Ask it: "What's the weather in Tokyo right now, and what time is it there?"
Observe the tool calls and reasoning steps. Save to `docs/projects/langchain-agent/`.

**Set 4 — Critique the abstraction (20 min):**
Compare the LangChain version of your RAG system with the hand-rolled version.
- How many lines did LangChain save?
- What did you lose visibility into?
- If the retrieval was broken, which version would be easier to debug?
- When would you reach for LangChain vs raw SDK in a production codebase?
Save to `docs/reading/langchain-tradeoffs.md`.

---

## After this module: Keystroke
LangChain gives you the patterns (chains, agents, tools, memory). Keystroke gives you the infrastructure to run those patterns in production — hosting, retries, credential management, team sharing, and MCP exposure. After finishing LangChain, go to the `keystroke` module to see where these patterns land in a real deployment environment.

---

## Checks — you understand this when you can:
- [ ] Build a multi-step LCEL chain
- [ ] Build a basic RAG pipeline using LangChain
- [ ] Explain what a LangGraph node, edge, and state are
- [ ] Explain the ReAct pattern and implement a simple ReAct agent
- [ ] Articulate when to use LangChain vs raw SDK and why

---

## Artifacts to commit
- [ ] `docs/projects/langchain-basic/`
- [ ] `docs/projects/langchain-rag/`
- [ ] `docs/projects/langchain-agent/`
- [ ] `docs/reading/langchain-tradeoffs.md`
- [ ] Glossary entries: LCEL, LangGraph, ReAct, chain, tool, agent, router
- [ ] Log entry in `docs/log.md`

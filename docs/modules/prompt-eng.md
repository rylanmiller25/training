# Module: Prompt Engineering

**Phase:** 5  
**Slug:** `prompt-eng`  
**Status:** not started  

---

## What it is / how to think about it

Prompt engineering is the systematic practice of designing inputs to language models to reliably produce useful outputs. It's not just "writing better prompts" — it's a discipline with techniques, tradeoffs, and evaluation loops.

**Mental model:** A prompt is a program. Like code, it has bugs (ambiguous instructions), edge cases (unusual inputs), and performance characteristics (some formulations are faster/cheaper/more reliable). Treat prompts as code: version them, test them, and review them.

---

## Prerequisites
- Transformers, LLM Failures, LLM Eval modules

---

## Best resources

**Primary:**
1. [Anthropic Prompt Library + Guide](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview) — official, current, production-tested
2. [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering) — complementary perspective

**Supporting:**
- [Prompt Injection Defenses – Simon Willison](https://simonwillison.net/2023/Apr/25/dual-llm-pattern/) — practical defense patterns
- [DSPy](https://dspy-docs.vercel.app/) — framework for programmatic prompt optimization

**YouTube:**
- [Prompt Engineering – Andrew Ng / DeepLearning.ai](https://www.youtube.com/watch?v=_ZvnD73m40o) (1 hr — best structured course)
- [Advanced Prompting – Andrej Karpathy](https://www.youtube.com/watch?v=bZQun8Y4L2A) (30 min — practical techniques)

---

## Core techniques

### Clarity + specificity
- Be explicit about: task, format, length, tone, persona, what to avoid
- Bad: "Summarize this" → Good: "Summarize this in 3 bullet points, each under 20 words, for a technical PM audience"
- Specify output format: JSON schema, markdown, bullet list, etc.

### Role / persona
```
You are a senior software engineer reviewing a pull request for security vulnerabilities.
Your audience is a junior engineer who wrote the code. Be specific and constructive.
```

### Few-shot examples
- Provide 2–5 input/output examples before the actual task
- The model learns the pattern from examples rather than from instructions alone
- Especially powerful for format adherence and style matching
- Keep examples diverse — don't accidentally teach the wrong pattern

### Chain-of-thought (CoT)
- "Think step by step" — dramatically improves reasoning on complex tasks
- Forces the model to show intermediate steps before answering
- **Zero-shot CoT:** just add "Let's think step by step" to the prompt
- **Few-shot CoT:** provide examples that include reasoning steps, not just final answers
- Costs more tokens but significantly improves accuracy on math, logic, multi-step tasks

### Structured outputs
- Ask for JSON, YAML, or a specific schema
- Reduces parsing effort; enables downstream validation
- Use schema in the prompt: "Return your answer as JSON matching this schema: {...}"
- Most APIs now have a `response_format: json_object` mode or tool use for guaranteed JSON

### Constitutional prompting
- Include guiding principles in the system prompt
- "Before answering, check: Is this accurate? Is this helpful? Is this safe?"
- Reduces certain failure modes; doesn't eliminate them

### Decomposition
- Break complex tasks into smaller subtasks
- Chain prompts: first extract, then summarize, then format
- Easier to debug and evaluate each step independently

### System vs user prompt design
- **System prompt:** sets persistent instructions, persona, constraints, context
- **User prompt:** the specific task for this turn
- Keep system prompts focused — don't put everything in them
- Treat system prompt as the product layer; user prompt as the runtime input

### Prompts as code
- Version control your prompts (Git)
- Test with a suite of inputs; don't just test the happy path
- A/B test prompt changes before rolling out
- Log prompt + output + user feedback for continuous improvement

---

## Exercises

**Set 1 — Prompt debugging (30 min):**
Start with a bad prompt for a task (e.g. "Write an email" or "Summarize this document").
Iteratively improve it by adding: role, format, length, tone, constraints, examples.
Record each version and the output quality. Save to `docs/projects/prompt-debugging.md`.

**Set 2 — Few-shot design (30 min):**
Design a few-shot prompt for: classifying customer support tickets into 5 categories.
1. Write 3 examples (input ticket → output category)
2. Test with 5 new tickets
3. Does it work consistently? What edge cases break it?
Save prompt + results to `docs/projects/few-shot-classifier.md`.

**Set 3 — Chain-of-thought experiment (20 min):**
Ask the same multi-step reasoning question:
- Without CoT
- With "Think step by step"
- With few-shot CoT examples
Compare accuracy and output quality. Save to `docs/reading/cot-experiment.md`.

**Set 4 — Structured output pipeline (45 min):**
Build a prompt that:
1. Takes a raw job description as input
2. Extracts: title, required skills (array), nice-to-have skills (array), seniority level, remote/onsite
3. Returns valid JSON matching a defined schema
4. Handle edge cases: missing fields should be null, not omitted
Save prompt + TypeScript validation code to `docs/projects/structured-output-pipeline/`.

---

## Checks — you understand this when you can:
- [ ] Write a prompt that specifies role, task, format, and constraints
- [ ] Explain what few-shot prompting is and design a 3-shot example set
- [ ] Explain chain-of-thought and when it helps (vs doesn't help)
- [ ] Build a prompt that reliably returns structured JSON
- [ ] Explain why prompts should be version-controlled and tested
- [ ] Identify 3 common prompt bugs and how to fix them

---

## Artifacts to commit
- [ ] `docs/projects/prompt-debugging.md`
- [ ] `docs/projects/few-shot-classifier.md`
- [ ] `docs/reading/cot-experiment.md`
- [ ] `docs/projects/structured-output-pipeline/`
- [ ] Glossary entries: few-shot, zero-shot, chain-of-thought, system prompt, structured output, constitutional prompting
- [ ] Log entry in `docs/log.md`

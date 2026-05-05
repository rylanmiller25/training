# Module: Inference Optimization

**Phase:** 4 (Weeks 23–36)  
**Slug:** `inference-opt`  
**Status:** not started  
**Estimated time:** 4–5 hours

---

## What it is / how to think about it

Inference optimization is about making LLM serving fast, cheap, and scalable in production. You don't need to implement these — but as a PM or engineer building AI features, you need to understand why latency varies, when to use streaming, and what knobs control cost vs speed.

**Mental model:** Inference is like a restaurant kitchen. The model is the chef; tokens are dishes. Throughput is dishes-per-hour; latency is time to first dish. Batching is cooking multiple orders at once. Caching is reusing prep work. Each technique trades something for something else.

---

## Prerequisites
- Transformers module

---

## Best resources

**Primary:**
1. [LLM Inference – Hamel Husain blog](https://hamel.dev/blog/posts/inference/) — practical, product-focused
2. [Anthropic API docs – caching + streaming](https://docs.anthropic.com/en/api/getting-started) — production API reference

**Supporting:**
- [vLLM paper summary](https://blog.vllm.ai/2023/06/20/vllm.html) — PagedAttention for efficient batching
- [LLM cost calculator – together.ai](https://www.together.ai/pricing) — get intuition for pricing across models

**YouTube:**
- [How LLM inference works – Andrej Karpathy](https://www.youtube.com/watch?v=zjkBMFhNj_g) (1 hr — optional deep dive; watch first 20 min for intuition)
- [AI inference explained – Fireship](https://www.youtube.com/watch?v=Mn_9W1nCFLo) (8 min)

---

## Core concepts to cover

### Latency components
- **TTFT (Time to First Token):** time from request sent to first token received. Affects perceived responsiveness.
- **TBT (Time Between Tokens):** how fast tokens stream after the first. Affects reading experience.
- **Total latency:** TTFT + (TBT × output tokens). Affects synchronous use cases.
- **Prompt processing:** compute scales with prompt length (prefill stage)
- **Token generation:** sequential, autoregressive — can't easily parallelize

### Throughput vs latency tradeoff
- **Throughput:** tokens/second across all requests (server metric)
- **Latency:** seconds to complete one request (user metric)
- Increasing batch size improves throughput but increases latency per request
- Design choice: optimize for throughput (batch processing) or latency (real-time UX)?

### Streaming
- Send tokens to the client as they're generated instead of waiting for the full response
- Dramatically improves perceived responsiveness (user sees output immediately)
- Required for long responses; users abandon if they have to wait 10+ seconds
- Implementation: Server-Sent Events (SSE) or WebSockets on the backend

### Caching strategies
- **KV cache (key-value cache):** stores attention computation for the input tokens so they don't need to be recomputed on each generation step. Standard in all inference engines.
- **Prompt caching:** if the same prefix appears across many requests (e.g. a long system prompt), cache the computed KV state for that prefix. Supported by Anthropic and OpenAI.
  - Anthropic: tokens in cache cost 10% of normal input price; cache write costs 25% more
  - Best for: long system prompts, static context, document processing
- **Semantic caching:** store results for semantically similar queries; return cached result without calling the model. Risk: different questions may be semantically close but require different answers.

### Quantization
- Reduce model weights from 32-bit or 16-bit floats to 8-bit or 4-bit integers
- Result: smaller model, faster inference, lower memory — at some quality cost
- INT8 quantization: ~2x memory savings, minimal quality loss
- INT4: 4x savings, noticeable quality degradation on complex tasks
- Tools: GPTQ, AWQ, llama.cpp (for running local models)

### Batching
- Process multiple requests through the model simultaneously
- **Static batching:** batch requests until a timeout, then process together
- **Continuous batching (dynamic batching):** insert new requests mid-generation; much more efficient for variable-length outputs (vLLM uses this)
- **Speculation decoding:** use a small fast model to draft tokens; verify with large model; speeds up generation if draft is often correct

### Model size and cost tradeoffs
- Larger models: better quality, higher latency, more expensive
- Smaller models: faster, cheaper, lower quality on hard tasks
- **Model selection heuristic:** use the smallest model that meets your quality bar
- Cost is typically per-token (input + output); output tokens cost more than input (generation is slower)

### Context length and cost
- Longer context = higher cost (O(n) for input processing; attention is O(n²) in practice though many optimizations exist)
- Every token in the context is charged; long system prompts are expensive at scale
- Consider: can you shorten your system prompt? Can you use caching to amortize the cost?

---

## Exercises

**Set 1 — Latency measurement (20 min):**
Using the Anthropic or OpenAI API:
1. Send the same request 5 times; record TTFT and total time
2. Try a short prompt (10 tokens) vs long prompt (2000 tokens). Compare TTFT.
3. Try a request with short output (50 tokens) vs long output (500 tokens). Compare total time.
Save observations to `docs/reading/latency-measurements.md`.

**Set 2 — Streaming implementation (30 min):**
Implement a simple streaming response in TypeScript using the Anthropic SDK:
```typescript
const stream = await anthropic.messages.stream({...});
for await (const chunk of stream) {
  process.stdout.write(chunk.delta?.text ?? "");
}
```
Save to `docs/projects/streaming-demo.ts`.

**Set 3 — Prompt caching experiment (20 min):**
1. Write a long system prompt (2000+ tokens).
2. Make the same API call twice with that system prompt.
3. Check if the second call uses cached tokens (look at usage response).
4. Calculate cost difference: 2000 tokens × ($3/1M for Claude claude-sonnet-4-6 input) vs cached rate ($0.30/1M).
Save to `docs/reading/prompt-caching-notes.md`.

**Set 4 — Cost estimation (20 min):**
For a hypothetical AI feature:
- System prompt: 1000 tokens (sent with every request)
- Average user message: 200 tokens
- Average model response: 500 tokens
- Volume: 10,000 requests/day
Calculate monthly cost for Claude claude-sonnet-4-6 (check current pricing on anthropic.com).
How much could prompt caching save?
Save to `docs/reading/inference-cost-estimate.md`.

---

## Checks — you understand this when you can:
- [ ] Explain TTFT vs throughput and which matters more for a chat UI vs batch processing
- [ ] Explain how streaming works and why it improves perceived performance
- [ ] Explain prompt caching and when to use it
- [ ] Explain quantization and the quality/speed tradeoff
- [ ] Estimate the cost of a simple AI feature given prompt length and volume
- [ ] Explain why output tokens cost more than input tokens

---

## Artifacts to commit
- [ ] `docs/projects/streaming-demo.ts`
- [ ] `docs/reading/latency-measurements.md`
- [ ] `docs/reading/prompt-caching-notes.md`
- [ ] `docs/reading/inference-cost-estimate.md`
- [ ] Glossary entries: TTFT, throughput, streaming, KV cache, prompt caching, quantization, batching, speculation decoding
- [ ] Log entry in `docs/log.md`

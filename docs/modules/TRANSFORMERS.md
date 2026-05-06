# Module: Transformer Intuition

**Phase:** 4  
**Slug:** `transformers`  
**Status:** not started  

---

## What it is / how to think about it

The transformer is the neural network architecture behind every major language model (GPT-4, Claude, Gemini, Llama). You don't need to implement one, but you need enough intuition to reason about its capabilities and limits: why it has a context window, why it hallucinates, why order matters, and why attention is the core mechanism.

**Mental model:** A transformer processes a sequence of tokens by allowing every token to "attend" to every other token — weighing which relationships are most relevant for the current prediction. This is radically different from older architectures (RNNs) that processed tokens one at a time.

---

## Prerequisites
- No hard prereqs. Comfort with very basic math (vectors, probability) helps but isn't required.

---

## Best resources

**Primary:**
1. [Attention is All You Need – illustrated guide by Jay Alammar](https://jalammar.github.io/illustrated-transformer/) — best visual explanation; read this first
2. [3Blue1Brown – Neural Networks series](https://www.youtube.com/playlist?list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi) — videos 5–7 on attention and transformers

**Supporting:**
- [The Illustrated GPT-2 – Jay Alammar](https://jalammar.github.io/illustrated-gpt2/) — follow-up on how transformers became LLMs
- [Andrej Karpathy – makemore + nanoGPT](https://github.com/karpathy/nanoGPT) — if you want to see code
- [Anthropic's research blog](https://www.anthropic.com/research) — mechanistic interpretability papers for deeper dives

**YouTube:**
- [But what is a neural network? – 3Blue1Brown](https://www.youtube.com/watch?v=aircAruvnKk) (19 min — start here if new to neural nets)
- [Attention in transformers – 3Blue1Brown](https://www.youtube.com/watch?v=eMlx5fFNoYc) (27 min — best video on the mechanism)
- [Transformers explained – Andrej Karpathy "Let's build GPT"](https://www.youtube.com/watch?v=kCc8FmEb1nY) (2 hrs — optional deep dive, builds from scratch)

---

## Core concepts to cover

### What is a token?
- Text is split into subword units (tokens) before the model sees it
- ~0.75 words per token on average for English; varies by language
- Numbers, punctuation, code, non-English text are tokenized differently
- **Consequence:** the model never sees words, only token IDs; this affects counting, spelling, arithmetic
- Try it: [Tiktokenizer](https://tiktokenizer.vercel.app/)

### The attention mechanism (intuition)
- For each token, attention computes a weighted sum of all other tokens' representations
- "Soft" lookup: instead of picking one token to attend to, it distributes attention across all
- **Query, Key, Value (Q, K, V):** Q = "what am I looking for?", K = "what do I have to offer?", V = "what I send if selected"
- Multi-head attention: run multiple attention computations in parallel, each focusing on different relationships

### The full transformer (conceptual)
1. **Input embedding:** tokens → vectors
2. **Positional encoding:** add position information (order matters)
3. **N × transformer blocks:** each block has multi-head attention + feed-forward layer + layer norm
4. **Output head:** project to vocabulary size → probability distribution over next token

### Context window
- Maximum number of tokens the model can process in one forward pass
- Everything outside the context window is invisible to the model — no "memory" beyond it
- Longer context = more expensive (attention is O(n²) in sequence length)
- Current models: 8K–1M+ tokens depending on model

### Temperature and sampling
- The model outputs a probability distribution over the next token
- **Temperature:** scales the distribution. Low temp (< 0.5) = more deterministic. High temp (> 1) = more random.
- **Top-p (nucleus sampling):** sample from the smallest set of tokens that sum to p% of probability mass
- **Greedy decoding:** always pick the highest probability token (deterministic; often repetitive)

### Why LLMs work (and why they're surprising)
- Trained to predict the next token on massive text corpora
- Emergent capabilities: tasks like chain-of-thought reasoning, translation, coding emerge without being directly trained
- Scaling laws: performance improves predictably with more data, more compute, more parameters

### Key limits to internalize
- **Context window limit:** can't reason over arbitrarily long documents
- **No persistent memory:** each conversation starts fresh (unless given tools or retrieval)
- **Training data cutoff:** doesn't know events after training ended
- **Hallucination:** will generate plausible-sounding text even when it doesn't "know" the answer
- **Sensitivity to phrasing:** same question worded differently can get different answers
- **Token arithmetic failures:** poor at counting, character-level operations, precise math (these require tools)

---

## Exercises

**Set 1 — Tokenization exploration (20 min):**
Go to [Tiktokenizer](https://tiktokenizer.vercel.app/) (GPT-4 tokenizer).
1. Tokenize: "Hello, world!" — how many tokens?
2. Tokenize: "Supercalifragilisticexpialidocious" — how is it split?
3. Tokenize a code snippet (10 lines of Python) — how many tokens?
4. Tokenize text in another language (French, Chinese) — how does token count compare to English?
Write observations in `docs/reading/TOKENIZATION-NOTES.md`.

**Set 2 — Context window experiments (30 min):**
Using Claude or ChatGPT:
1. Paste a very long document. Ask a question that requires reading near the end. Does it answer correctly?
2. Start a conversation, then much later refer back to something said early on. Does it recall accurately?
3. Intentionally fill up most of the context with irrelevant text, then ask a question. Notice any degradation?
Write observations in `docs/reading/CONTEXT-WINDOW-EXPERIMENTS.md`.

**Set 3 — Temperature experiments (20 min):**
Using a model with temperature control (Claude API or OpenAI Playground):
1. Ask: "Give me a one-word answer: what color is the sky?" at temp 0.0 and temp 1.5. Compare.
2. Ask: "Write an opening line for a novel" 5 times at temp 0.2 and 5 times at temp 1.0. Compare variance.
Write observations in `docs/reading/TEMPERATURE-EXPERIMENTS.md`.

**Set 4 — Concept map (30 min):**
Draw (or write in structured markdown) a concept map showing:
- Token → embedding → attention → transformer block → output
- How context window connects to memory limits
- How temperature connects to sampling
Save to `docs/reading/TRANSFORMER-CONCEPT-MAP.md`.

---

## Checks — you understand this when you can:
- [ ] Explain what a token is and why tokenization affects model behavior
- [ ] Explain attention at an intuitive level (Q/K/V, weighted sum)
- [ ] Explain what a context window is and what happens at its limit
- [ ] Explain temperature and its effect on outputs
- [ ] List 4 fundamental limits of transformer-based LLMs
- [ ] Explain why LLMs can do tasks they weren't explicitly trained on (emergence)

---

## Artifacts to commit
- [ ] `docs/reading/TOKENIZATION-NOTES.md`
- [ ] `docs/reading/CONTEXT-WINDOW-EXPERIMENTS.md`
- [ ] `docs/reading/TEMPERATURE-EXPERIMENTS.md`
- [ ] `docs/reading/TRANSFORMER-CONCEPT-MAP.md`
- [ ] Glossary entries: token, transformer, attention, context window, temperature, embedding, hallucination, scaling laws
- [ ] Log entry in `docs/LOG.md`

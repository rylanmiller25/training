# Module: RAG (Retrieval-Augmented Generation)

**Phase:** 5  
**Slug:** `rag`  
**Status:** not started  

---

## What it is / how to think about it

RAG combines a retrieval system with a language model: instead of relying on what the model memorized during training, you retrieve relevant documents at query time and inject them into the context. This grounds the model in current, authoritative information.

**Mental model:** RAG is an open-book exam vs a closed-book exam. Without RAG, the LLM is working entirely from memory. With RAG, it can look up the answer in a provided document — but it still needs to reason well about what it finds.

---

## Prerequisites
- Embeddings, Prompt Engineering, LLM Failures modules

---

## Best resources

**Primary:**
1. [RAG explained – Pinecone](https://www.pinecone.io/learn/retrieval-augmented-generation/) — practical, includes architecture diagrams
2. [Ragas documentation](https://docs.ragas.io/) — RAG evaluation framework; read the metrics section

**Supporting:**
- [LlamaIndex docs](https://docs.llamaindex.ai/) — leading RAG framework; read the "concepts" section
- [Advanced RAG techniques – Weaviate](https://weaviate.io/blog/advanced-rag) — covers chunking, hybrid search, reranking
- [Lost in the Middle paper](https://arxiv.org/abs/2307.03172) — why retrieval position in context matters

**YouTube:**
- [RAG from scratch – LangChain](https://www.youtube.com/playlist?list=PLfaIDFEXuae2LXbO1_PKyVJiQ23ZztA0x) (playlist — 15 short videos)
- [Advanced RAG – AI Jason](https://www.youtube.com/watch?v=sVcwVQRHIc8) (25 min)

---

## Core concepts to cover

### The basic RAG pipeline
1. **Indexing (offline):**
   - Load documents
   - Chunk into segments (e.g. 512 tokens with 50-token overlap)
   - Embed each chunk
   - Store in vector database
2. **Retrieval (at query time):**
   - Embed the user query
   - Find top-k most similar chunks by cosine similarity
   - Return chunks as context
3. **Generation:**
   - Inject retrieved chunks into the prompt
   - LLM generates a response grounded in the retrieved context

### Chunking strategies
- **Fixed-size:** split by token count (simple; may cut mid-sentence)
- **Sentence/paragraph:** split at natural boundaries (better coherence)
- **Semantic chunking:** split when topic changes (more complex; often better)
- **Overlap:** include last N tokens of previous chunk to preserve context across boundaries
- **Chunk size tradeoff:** small chunks = precise retrieval; large chunks = more context per chunk

### Retrieval strategies
- **Dense retrieval:** embedding similarity (semantic search) — good for paraphrase matching
- **Sparse retrieval (BM25/TF-IDF):** keyword matching — good for exact terms, product names, jargon
- **Hybrid search:** combine both; typically best in practice
- **Reranking:** use a cross-encoder model to re-score top-k candidates after initial retrieval (improves precision)

### Where RAG fails
- **Retrieval failure:** relevant content exists but isn't retrieved (bad chunking, bad embedding, mismatch in phrasing)
- **Context window stuffing:** too many chunks degrade generation quality
- **Lost in the middle:** model ignores chunks placed in the middle of a long context
- **Faithfulness failure:** model generates content not supported by retrieved context (still hallucinating)
- **Query-document mismatch:** queries are short and conversational; documents are long and formal — semantic similarity may miss relevant content

### RAG evaluation metrics (Ragas)
- **Faithfulness:** is the generated answer supported by the retrieved context?
- **Answer relevance:** does the answer actually address the question?
- **Context precision:** are the retrieved chunks relevant? (precision)
- **Context recall:** did retrieval miss relevant chunks? (recall)

### Advanced patterns
- **HyDE (Hypothetical Document Embeddings):** generate a hypothetical document answering the query; embed that; use it for retrieval (helps query-document mismatch)
- **Query expansion:** rewrite the query multiple ways; retrieve for each; merge results
- **Parent-child chunking:** store small chunks for retrieval precision; return larger parent chunk for context
- **Metadata filtering:** filter by date, author, category before semantic search
- **Self-RAG:** model decides when to retrieve (vs answer from memory)

---

## Exercises

**Set 1 — Basic RAG pipeline (60–90 min):**
Build a minimal RAG system in TypeScript or Python:
1. Load 10+ text documents (or chunks from a PDF/web page)
2. Embed with an embedding model
3. Store in memory (simple array; use ChromaDB or pgvector for bonus)
4. Accept a query, embed it, find top-3 chunks by cosine similarity
5. Pass chunks + query to an LLM; return grounded answer
Save to `docs/projects/basic-rag/`.

**Set 2 — Chunking experiment (30 min):**
Take a long document (e.g. a Wikipedia article or product documentation).
Chunk it 3 ways: 256 tokens, 1024 tokens, by paragraph.
For each, ask the same 5 questions and compare retrieval quality.
Which chunking strategy retrieves the most relevant content?
Save to `docs/reading/chunking-experiment.md`.

**Set 3 — Faithfulness eval (30 min):**
Using your RAG system from Set 1:
1. Ask 10 questions
2. For each, manually check: does the answer follow from the retrieved context?
3. How often does the model "hallucinate" beyond what the context supports?
Save findings to `docs/reading/rag-faithfulness-eval.md`.

**Set 4 — Design a production RAG system (45 min):**
For a hypothetical internal knowledge base (500 docs, updated weekly):
- What chunking strategy?
- Dense, sparse, or hybrid retrieval?
- How many chunks to retrieve (k)?
- How would you handle questions outside the knowledge base?
- How would you evaluate quality at scale?
- What monitoring would you set up?
Save to `docs/reading/rag-system-design.md`.

---

## Checks — you understand this when you can:
- [ ] Describe the 3-stage RAG pipeline (index, retrieve, generate)
- [ ] Explain 3 chunking strategies and their tradeoffs
- [ ] Explain the difference between dense, sparse, and hybrid retrieval
- [ ] Explain faithfulness and why RAG doesn't eliminate hallucination
- [ ] Explain the "lost in the middle" problem and its implication for RAG
- [ ] Design a RAG system for a realistic use case

---

## Artifacts to commit
- [ ] `docs/projects/basic-rag/`
- [ ] `docs/reading/chunking-experiment.md`
- [ ] `docs/reading/rag-faithfulness-eval.md`
- [ ] `docs/reading/rag-system-design.md`
- [ ] Glossary entries: RAG, chunking, dense retrieval, BM25, reranking, faithfulness, HyDE, hybrid search
- [ ] Log entry in `docs/log.md`

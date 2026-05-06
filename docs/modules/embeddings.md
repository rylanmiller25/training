# Module: Embeddings + Multimodal Models

**Phase:** 4  
**Slug:** `embeddings`  
**Status:** not started  

---

## What it is / how to think about it

Embeddings are dense vector representations of data — text, images, audio — that capture semantic meaning. Things that are semantically similar have vectors that are close together in high-dimensional space. This is the mathematical foundation for semantic search, RAG, and recommendation systems.

**Mental model:** Imagine a library where every book is placed on a shelf not alphabetically, but by *meaning*. Books about cats are near books about dogs; books about Python programming are near books about JavaScript. Embeddings are that spatial arrangement, applied to any data type, in hundreds of dimensions.

---

## Prerequisites
- Transformers module

---

## Best resources

**Primary:**
1. [What are embeddings? – Simon Willison](https://simonwillison.net/2023/Oct/23/embeddings/) — best practical intro
2. [The Illustrated Word2Vec – Jay Alammar](https://jalammar.github.io/illustrated-word2vec/) — classic visual walkthrough

**Supporting:**
- [OpenAI embeddings guide](https://platform.openai.com/docs/guides/embeddings) — practical API usage
- [Pinecone: What are vector databases?](https://www.pinecone.io/learn/vector-database/) — how embeddings are stored and queried at scale

**YouTube:**
- [Embeddings explained – Computerphile](https://www.youtube.com/watch?v=viZrOnJclY0) (15 min)
- [Multimodal AI – Andrej Karpathy](https://www.youtube.com/watch?v=bZQun8Y4L2A) (1 hr — deep technical; watch in sections)

---

## Core concepts to cover

### What embeddings are
- A vector (list of floats, e.g. 1536 dimensions) representing the meaning of a piece of text
- Produced by an embedding model (e.g. `text-embedding-3-small` from OpenAI, or open models like `nomic-embed`)
- Distance in vector space = semantic similarity
- **Cosine similarity:** most common distance metric; measures angle between vectors (1 = identical, -1 = opposite)

### How embeddings are used
- **Semantic search:** embed query → find nearest document embeddings
- **RAG (Retrieval-Augmented Generation):** retrieve relevant chunks by embedding similarity; inject into LLM context
- **Recommendation:** find items similar to what a user has liked
- **Clustering:** group documents by topic without labels
- **Anomaly detection:** find data points far from the cluster

### Vector databases
- Store, index, and query embeddings at scale
- **Approximate Nearest Neighbor (ANN):** finds the ~closest vectors without exhaustively checking all (much faster)
- Popular options: Pinecone, Weaviate, Qdrant, pgvector (Postgres extension), ChromaDB
- **Hybrid search:** combine vector (semantic) search with keyword (BM25/TF-IDF) search for best results

### Embedding models
- **Text:** OpenAI `text-embedding-3-small/large`, Cohere `embed-v3`, open models via Hugging Face
- **Multimodal:** CLIP (image + text in same vector space); can search images with text queries
- **Quality factors:** dimensionality, training data, task-specific tuning (retrieval vs classification)
- **Cost:** embedding is cheap vs generation; store embeddings once, query many times

### Multimodal models
- **What:** models that process multiple modalities (text + images, text + audio, text + video)
- **Vision-language models (VLMs):** GPT-4V, Claude claude-sonnet-4-6, Gemini 1.5 Pro — can see images and answer questions
- **CLIP:** joint embedding space for text and images; enables text→image search
- **Stable Diffusion / DALL-E / Midjourney:** text-to-image generation (different from understanding)
- **Whisper:** speech-to-text (audio → text)

### Practical considerations
- **Chunking:** for long documents, split into chunks before embedding; chunk size affects retrieval quality
- **Embedding drift:** if you change the embedding model, you must re-embed all stored documents
- **Dimensionality:** higher dimension = more expressive but more storage and slower search
- **Normalization:** most distance metrics require normalized vectors; embed models often return normalized by default

---

## Exercises

**Set 1 — Cosine similarity intuition (20 min):**
Without code, predict which pairs are closest in embedding space:
- ("dog", "cat") vs ("dog", "automobile")
- ("I love Python programming", "Python is my favorite language") vs ("I love Python programming", "Snakes are reptiles")
- ("Paris is the capital of France", "France's capital city is Paris") vs ("Paris is the capital of France", "Berlin is the capital of Germany")
Write your predictions, then verify using an embedding API or playground.

**Set 2 — Generate and compare embeddings (45 min):**
Using the OpenAI API or a free alternative (Hugging Face `sentence-transformers`):
1. Embed 10 sentences on 3 different topics (e.g. cooking, programming, sports)
2. Compute cosine similarity between all pairs
3. Do semantically similar sentences have higher similarity scores?
4. Find the most surprising similarity result
Save code + results to `docs/projects/embedding-experiment.md`.

**Set 3 — Simple semantic search (45 min):**
Build a minimal semantic search in TypeScript or Python:
1. Create an array of 20 facts/sentences
2. Embed all of them; store in memory
3. Accept a query string, embed it, find the 3 nearest by cosine similarity
4. Print the top 3 results
Save to `docs/projects/semantic-search/`.

**Set 4 — Multimodal experiment (20 min):**
Using Claude claude-sonnet-4-6 or GPT-4V:
1. Upload an image and ask it to describe what it sees
2. Ask a reasoning question about the image content
3. Test a chart or diagram — can it read and interpret data visualizations?
Write observations about capabilities and failures in `docs/reading/multimodal-experiment.md`.

---

## Checks — you understand this when you can:
- [ ] Explain what an embedding is and what cosine similarity measures
- [ ] Explain how semantic search uses embeddings
- [ ] Describe 3 practical applications of embeddings
- [ ] Explain what a vector database does and name 2 options
- [ ] Explain what chunking is and why it matters for RAG
- [ ] Explain what a multimodal model can do that a text-only model cannot

---

## Artifacts to commit
- [ ] `docs/projects/embedding-experiment.md`
- [ ] `docs/projects/semantic-search/`
- [ ] `docs/reading/multimodal-experiment.md`
- [ ] Glossary entries: embedding, cosine similarity, vector database, semantic search, ANN, CLIP, multimodal, chunking
- [ ] Log entry in `docs/log.md`

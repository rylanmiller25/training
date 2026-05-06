# Module: Hugging Face Ecosystem

**Phase:** 5  
**Slug:** `huggingface`  
**Status:** not started  

---

## What it is / how to think about it

Hugging Face is the GitHub of AI — a hub for models, datasets, and spaces (deployable demos). It's where the open-source AI community shares work, and where many production teams source base models for fine-tuning. Understanding the ecosystem lets you evaluate open models, find datasets, and run experiments without building from scratch.

**Mental model:** Think of it as npm for AI. Models are packages you import. Datasets are test fixtures. Spaces are deployed demos. The Hub is the registry.

---

## Prerequisites
- Embeddings, Model Selection modules

---

## Best resources

**Primary:**
1. [Hugging Face docs – Getting started](https://huggingface.co/docs) — start with the Hub, then Transformers
2. [Hugging Face course](https://huggingface.co/course) — free, interactive, covers NLP fundamentals + the ecosystem

**Supporting:**
- [MTEB Leaderboard](https://huggingface.co/spaces/mteb/leaderboard) — ranking of embedding models
- [Open LLM Leaderboard](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) — ranking of open-source LLMs

**YouTube:**
- [Hugging Face in 15 minutes – Sentdex](https://www.youtube.com/watch?v=QEaBAZQCtwE) (15 min)
- [Fine-tuning LLMs – Andrej Karpathy](https://www.youtube.com/watch?v=kCc8FmEb1nY) (2 hrs — optional deep dive)

---

## Core concepts

### The Hub
- **Models:** 500K+ models across tasks (text generation, classification, embeddings, image, audio, video)
- **Datasets:** curated training/eval datasets; download with `datasets` library
- **Spaces:** hosted Gradio or Streamlit apps; live demos of models
- Model cards: documentation for each model (training data, intended use, limitations, eval results)

### Key libraries
- **`transformers`:** load and run models locally; supports PyTorch and TensorFlow
- **`datasets`:** load public or private datasets
- **`tokenizers`:** fast tokenization (powers `transformers`)
- **`peft`:** parameter-efficient fine-tuning (LoRA, QLoRA)
- **`accelerate`:** distributed training and inference

### Loading a model (conceptual)
```python
from transformers import pipeline

# Sentiment analysis
classifier = pipeline("text-classification", model="distilbert-base-uncased-finetuned-sst-2-english")
result = classifier("I love this product!")

# Text generation (small model for demo)
generator = pipeline("text-generation", model="gpt2")
result = generator("Once upon a time", max_length=50)

# Embeddings
from sentence_transformers import SentenceTransformer
model = SentenceTransformer("nomic-ai/nomic-embed-text-v1")
embeddings = model.encode(["Hello world", "Hi there"])
```

### Inference Endpoints
- Deploy any Hub model as a private API endpoint in one click
- Auto-scaling; pay per request or per hour
- Alternative to running inference locally without exposing the model publicly

### Spaces
- Live demos built with Gradio or Streamlit, hosted for free
- Great for: sharing prototypes, testing models interactively, showcasing projects
- Can be made private or require a token

### Finding the right model
1. Go to huggingface.co/models
2. Filter by task type (text-generation, text-classification, sentence-similarity, etc.)
3. Sort by downloads or likes; check the model card
4. Look for: training data, known limitations, license (MIT, Apache 2.0, Llama license, etc.)
5. Check the MTEB or Open LLM Leaderboard for ranked comparisons

### Licenses to know
- **MIT / Apache 2.0:** permissive; commercial use allowed
- **Llama community license:** permitted for commercial use under 700M MAU; requires attribution
- **Research-only (CC BY-NC):** no commercial use
- Always check before using in a product

---

## Exercises

**Set 1 — Explore the Hub (20 min):**
1. Go to huggingface.co/models, filter for "sentence-similarity"
2. Find the top 3 embedding models by downloads; read their model cards
3. Find a dataset for: sentiment analysis, question answering, code generation
4. Open a Space — find a live demo that's interesting; note what model it uses
Write findings in `docs/reading/huggingface-exploration.md`.

**Set 2 — Run a model locally (30 min):**
Using Google Colab (free GPU) or local Python:
```python
from sentence_transformers import SentenceTransformer
import numpy as np

model = SentenceTransformer("all-MiniLM-L6-v2")
sentences = ["I love machine learning", "ML is fascinating", "I enjoy cooking pasta"]
embeddings = model.encode(sentences)

# Compute cosine similarity
from sklearn.metrics.pairwise import cosine_similarity
print(cosine_similarity(embeddings))
```
Run this; interpret the similarity matrix. Which sentences are most similar?
Save results + code to `docs/projects/huggingface-embeddings.py`.

**Set 3 — Open LLM Leaderboard analysis (20 min):**
Go to the Open LLM Leaderboard (huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard).
- Which model has the highest average score?
- What's the best model under 7B parameters?
- Compare Llama 3 vs Mistral on a specific benchmark
- What would you choose for an on-premise deployment where data can't leave your server?
Save analysis to `docs/reading/open-llm-leaderboard-notes.md`.

**Set 4 — Deploy a Space (30 min):**
Create a free Hugging Face account. Build a simple Gradio Space:
1. Create `app.py` using Gradio that takes text input and returns its sentiment
2. Use `pipeline("text-classification")` with a small model
3. Deploy to Hugging Face Spaces (free hosting)
4. Share the link; record it in `docs/projects/hf-space-demo.md`

---

## Checks — you understand this when you can:
- [ ] Find an appropriate model on the Hub for a given task
- [ ] Read a model card and evaluate fit for your use case (license, training data, limitations)
- [ ] Load and run a sentence embedding model locally
- [ ] Explain the difference between Inference Endpoints and Spaces
- [ ] Explain what license restrictions to check before using a model commercially

---

## Artifacts to commit
- [ ] `docs/reading/huggingface-exploration.md`
- [ ] `docs/projects/huggingface-embeddings.py`
- [ ] `docs/reading/open-llm-leaderboard-notes.md`
- [ ] `docs/projects/hf-space-demo.md`
- [ ] Glossary entries: model card, Gradio, Inference Endpoint, LoRA, PEFT, MTEB, open LLM leaderboard
- [ ] Log entry in `docs/log.md`

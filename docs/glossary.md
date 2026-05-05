# Glossary

Running list of terms. Add entries as you encounter new concepts. Format: **term** — definition (one sentence; add a phase/module tag).

---

## A

**API (Application Programming Interface)** — A defined contract for how two software systems communicate, typically over HTTP. [Phase 1 / http-apis]

**Authentication (authn)** — Verifying who you are (e.g., login with password or token). [Phase 2 / security]

**Authorization (authz)** — Verifying what you are allowed to do after identity is confirmed. [Phase 2 / security]

## B

**Batch inference** — Running a model on many inputs at once, optimizing for throughput over latency. [Phase 4 / inference-opt]

## C

**CI/CD (Continuous Integration / Continuous Delivery)** — Automated pipelines that build, test, and deploy code on every commit. [Phase 2 / cicd]

**Container** — A lightweight, isolated runtime environment that packages code with its dependencies (Docker is the dominant tool). [Phase 2 / docker]

**Context window** — The maximum amount of text (tokens) a language model can process in a single forward pass. [Phase 4 / llm-failures]

## D

**Deployment pipeline** — The automated sequence of steps (build → test → stage → prod) that ships code to users. [Phase 2 / cicd]

## E

**Embedding** — A dense numeric vector representing text, images, or other data in a way that captures semantic similarity. [Phase 4 / embeddings]

**Eval (evaluation)** — Systematic measurement of a model or system's performance against defined criteria. [Phase 4 / llm-eval]

## G

**Git** — A distributed version control system for tracking code changes and coordinating among contributors. [Phase 1 / git-github]

## H

**Hallucination** — When a language model generates plausible-sounding but factually incorrect content. [Phase 4 / llm-failures]

**HTTP (HyperText Transfer Protocol)** — The request/response protocol underlying most web and API communication. [Phase 1 / http-apis]

**HITL (Human-in-the-Loop)** — A system design pattern where humans review or correct model outputs at defined checkpoints. [Phase 5 / hitl]

## I

**Idempotent** — An operation that produces the same result whether run once or many times (important for HTTP PUT/DELETE). [Phase 1 / http-apis]

## J

**JWT (JSON Web Token)** — A compact, signed token format used for stateless authentication. [Phase 2 / security]

## L

**Latency** — The time between a request being made and a response being received. [Phase 4 / inference-opt]

**LLM (Large Language Model)** — A neural network trained on large text corpora to predict and generate text. [Phase 4 / transformers]

## M

**Merge conflict** — When two branches modify the same lines of code and Git cannot automatically reconcile the differences. [Phase 1 / git-github]

## O

**OAuth** — An authorization framework that allows third-party services to access user data without exposing credentials. [Phase 2 / security]

## P

**PR (Pull Request)** — A GitHub construct for proposing, reviewing, and merging code changes from a branch. [Phase 1 / git-github]

**Prompt injection** — An attack where malicious user input hijacks an LLM's instructions. [Phase 5 / red-teaming]

## R

**RAG (Retrieval-Augmented Generation)** — Augmenting LLM responses with dynamically retrieved external context. [Phase 5 / rag]

**REST (Representational State Transfer)** — An architectural style for APIs using HTTP verbs (GET, POST, PUT, DELETE) and stateless requests. [Phase 1 / http-apis]

**RLHF (Reinforcement Learning from Human Feedback)** — Training technique that fine-tunes models using human preference signals. [Phase 4 / rl-rlhf]

## S

**Serverless** — Cloud execution model where functions run on demand without managing servers (e.g., AWS Lambda). [Phase 2 / cloud]

**SQL (Structured Query Language)** — Language for querying and manipulating relational databases. [Phase 1 / sql]

**Status code** — Three-digit HTTP response code indicating success (2xx), redirect (3xx), client error (4xx), or server error (5xx). [Phase 1 / http-apis]

## T

**Token** — The atomic unit of text a language model processes (roughly 0.75 words on average for English). [Phase 4 / transformers]

**Transformer** — The neural network architecture (attention-based) underlying most modern LLMs. [Phase 4 / transformers]

## V

**Version control** — System for tracking changes to files over time, enabling collaboration and rollback. [Phase 1 / git-github]

---

*Add terms here as you encounter them. Reference the relevant module slug.*

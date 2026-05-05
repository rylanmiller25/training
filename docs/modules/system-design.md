# Module: System Design Basics

**Phase:** 2 (Weeks 7–12)  
**Slug:** `system-design`  
**Status:** not started  
**Estimated time:** 8–10 hours

---

## What it is / how to think about it

System design is the practice of deciding how to structure a software system — what components exist, how they talk to each other, and what tradeoffs you accept. It's the vocabulary engineers use to discuss architecture.

**Mental model:** Think of it like urban planning. You don't just build one giant building — you decide where roads go, where water comes from, how power is distributed, and how to handle growth. Every architectural decision trades something (consistency vs availability, cost vs speed, simplicity vs scale).

Goal for this module: build intuition for the most common patterns, not become an expert system designer. You need enough to read design docs, ask good questions, and make informed product decisions.

---

## Prerequisites
- CLI/Linux, HTTP + APIs, Docker, Cloud modules

---

## Best resources

**Primary:**
1. [System Design Primer – GitHub](https://github.com/donnemartin/system-design-primer) — the canonical free resource; start with the README
2. [ByteByteGo newsletter](https://blog.bytebytego.com/) — visual system design explanations, one topic per week

**Supporting:**
- [Designing Data-Intensive Applications (DDIA) – Kleppmann](https://dataintensive.net/) — the bible of data systems; dense but worth reading chapters 1, 2, 5 eventually
- [High Scalability blog](http://highscalability.com/) — real architecture teardowns

**YouTube:**
- [System Design Interview – A Step-By-Step Guide – ByteByteGo](https://www.youtube.com/watch?v=i7twT3x5yv8) (18 min — framework overview)
- [Database Sharding – ByteByteGo](https://www.youtube.com/watch?v=5faMjKuB9bc) (8 min)
- [Message Queues – Fireship](https://www.youtube.com/watch?v=oUJbuFMyFs8) (10 min)

---

## Core concepts to cover

### The request lifecycle
Client → DNS → Load Balancer → Web Server → App Server → Database/Cache → Response
Understanding each hop: where latency lives, where failures happen, where you scale.

### Databases
- **Relational (SQL):** strong consistency, ACID transactions, great for structured data with relations
- **NoSQL (document, key-value, column, graph):** flexible schema, horizontal scale, eventual consistency
- **When to use which:** relational by default; NoSQL when schema is unknown, data is unstructured, or you need extreme write scale
- **Indexes:** dramatically speed up reads on large tables; slow down writes slightly
- **Sharding:** splitting a database horizontally (by user ID range, hash, etc.) to distribute load
- **Replication:** copies of data across multiple nodes; primary handles writes, replicas handle reads

### Caching
- **Why:** reads are much more frequent than writes; many reads fetch the same data
- **Cache-aside (lazy loading):** app checks cache first; on miss, reads DB and populates cache
- **Write-through:** write to cache and DB simultaneously; cache always has fresh data
- **Cache invalidation:** the hardest problem — when do you expire/update cached data?
- **Tools:** Redis (in-memory key-value), Memcached, CDN edge caching
- **TTL (Time to Live):** how long a cached value stays before expiring

### Sync vs async communication
- **Synchronous (request/response):** client waits for response; simple but creates coupling
- **Asynchronous (message queues):** producer sends to queue; consumer processes at its own pace
- **When async:** long-running tasks (video encoding, emails, reports), spiky traffic, decoupling services
- **Tools:** Redis Pub/Sub, RabbitMQ, AWS SQS, Kafka (for high-throughput event streams)

### Load balancing
- Distributes traffic across multiple server instances
- **Round-robin:** send to each server in turn
- **Least-connections:** send to server with fewest active connections
- **Sticky sessions:** route a user's requests to the same server (needed for server-side state)
- **Horizontal scaling:** add more servers; **vertical scaling:** make one server bigger

### CAP theorem (intuition only)
A distributed system can guarantee at most 2 of: **Consistency** (all nodes see same data), **Availability** (every request gets a response), **Partition tolerance** (system works despite network failures).
- In practice: partition tolerance is non-negotiable in real distributed systems
- So the real tradeoff is **consistency vs availability** — choose based on your domain

### API design for scale
- **Rate limiting:** cap requests per user/IP to prevent abuse
- **Pagination:** don't return all records; use cursor or offset pagination
- **Idempotency keys:** make POST requests safe to retry (payments critical)
- **Webhooks vs polling:** webhooks push events to you; polling pulls on a schedule

---

## Exercises

**Set 1 — Diagram a system (30 min):**
Draw (paper or any tool) the components of a system you use: Twitter/X, Instagram, or Notion.
Include: client, CDN, load balancer, app servers, databases, cache, object storage.
No need to be precise — goal is to practice thinking in components.
Take a photo or export and save to `docs/reading/system-diagram.png`.

**Set 2 — Tradeoff analysis (30 min):**
For each scenario, decide: SQL or NoSQL? Cache or no cache? Sync or async? Write your reasoning.
1. A social network storing user posts, comments, and likes
2. A real-time chat app with millions of concurrent users
3. An e-commerce checkout that charges credit cards
4. A log aggregation system ingesting 1M events/second
Save to `docs/reading/system-design-tradeoffs.md`.

**Set 3 — Read a real design doc (30 min):**
Read one of these:
- [How Discord Stores Billions of Messages](https://discord.com/blog/how-discord-stores-billions-of-messages)
- [Scaling Slack](https://slack.engineering/flannel-an-application-level-edge-cache-to-make-slack-scale/)
- [Airbnb's microservices migration](https://medium.com/airbnb-engineering/loosely-coupling-airbnb-reservation-microservices-with-platform-and-service-meshes-8a45a23db44c)
Write a 5-bullet summary: what problem did they have, what solution they chose, and what tradeoff they accepted. Save to `docs/reading/system-design-case-study.md`.

**Set 4 — Design a URL shortener (45 min):**
Classic intro design problem. Write a doc `docs/reading/url-shortener-design.md` addressing:
- What does the system do? (read the spec clearly first)
- What are the scale requirements? (reads/writes per second, storage size)
- What components do you need?
- How do you generate short codes?
- Where does the redirect mapping live? How do you cache it?
- What breaks at 10x traffic? 100x?

---

## Checks — you understand this when you can:
- [ ] Trace a web request from browser to database and back, naming each component
- [ ] Explain the difference between SQL and NoSQL and when you'd pick each
- [ ] Explain cache-aside caching and the invalidation problem
- [ ] Explain what a message queue is and give a real use case
- [ ] Explain horizontal vs vertical scaling
- [ ] Explain CAP theorem in one sentence without jargon
- [ ] Design a simple system (URL shortener, paste bin) and explain key decisions

---

## Artifacts to commit
- [ ] `docs/reading/system-design-tradeoffs.md`
- [ ] `docs/reading/system-design-case-study.md`
- [ ] `docs/reading/url-shortener-design.md`
- [ ] Glossary entries: sharding, replication, cache, CAP theorem, message queue, load balancer, rate limiting, idempotency
- [ ] Log entry in `docs/log.md`

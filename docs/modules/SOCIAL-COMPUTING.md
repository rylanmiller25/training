# Module: Social Computing

**Phase:** 6  
**Slug:** `social-computing`  
**Status:** not started  

---

## What it is / how to think about it

Social computing studies how computing systems and human social behavior co-evolve — how platform design shapes communities, how groups produce knowledge, how reputation systems create or destroy trust, and how collective intelligence emerges from individual actions.

**Mental model:** A social computing system is an experiment in incentive design. Every design choice — what to upvote, how to display reputation, whether posts are anonymous — is a hypothesis about how those incentives will shape behavior. The history of social computing is largely a history of those hypotheses succeeding and failing in unexpected ways.

---

## Prerequisites
- PRDs, Privacy/Compliance modules (Phase 3)
- HCI + Research Areas module (Phase 6)

---

## Best resources

**Primary:**
1. [Networks, Crowds, and Markets — Kleinberg & Tardos](https://www.cs.cornell.edu/home/kleinber/networks-book/) — free online; the definitive textbook on network structure, game theory in social systems, and collective behavior
2. [CSCW Conference Proceedings](https://cscw.acm.org/) — Computer-Supported Cooperative Work; the premier research venue for social computing; browse recent best paper awards

**Supporting:**
- [The Wisdom of Crowds — James Surowiecki](https://www.penguinrandomhouse.com/books/175380/the-wisdom-of-crowds-by-james-surowiecki/) — foundational book on when groups outperform individuals
- [Jure Leskovec — Social and Information Network Analysis (Stanford)](http://cs.stanford.edu/people/jure/pubs/agmfit-icdm12.pdf) — lecture notes and slides
- [Hacker News Guidelines](https://news.ycombinator.com/newsguidelines.html) — a simple, real-world content moderation policy worth studying closely

**YouTube:**
- [Social Networks — Stanford CS224W lecture series](https://www.youtube.com/playlist?list=PLoROMvodv4rPLKxIpqhjhPgdQy7imNkDn) (multiple lectures; watch lectures 1–3 to start)
- [The Social Dilemma — Netflix documentary](https://www.netflix.com/title/81254224) (90 min; biased but useful as a provocation)

---

## Core concepts

### Collective intelligence
- Groups can solve problems that individuals cannot — but only under the right conditions
- Conditions for the "wisdom of crowds": diversity of opinion, independence, decentralization, aggregation
- Counter-examples: groupthink, echo chambers, information cascades where early signals dominate
- Examples: Wikipedia, prediction markets, open source, Stack Overflow, PageRank

### Crowdsourcing and human computation
- Tasks that are easy for humans but hard for machines, distributed at scale
- Amazon Mechanical Turk: micro-task marketplace; used for data labeling, surveys, content moderation
- CAPTCHA: turning a security problem into crowdsourced OCR/image recognition
- Citizen science: distributed scientific data collection (Foldit, Galaxy Zoo)
- Quality control: how do you catch bad actors and low-effort responses at scale?

### Social network analysis
- Graph representation: nodes (users), edges (follows, messages, co-authorship)
- Key metrics: degree (connections), betweenness centrality (bridge nodes), clustering coefficient (clique-ness)
- Small worlds: most real social networks have short average path lengths (six degrees)
- Homophily: people connect to similar others; creates filter bubbles
- Weak ties: Granovetter's insight that weak ties (acquaintances) carry more novel information than strong ties (close friends)

### Reputation systems
- Core function: create trust between strangers at scale
- eBay seller ratings, Airbnb host reviews, GitHub stars, HN karma, Uber driver scores
- Design challenges: cold start (new users have no reputation), gaming (fake reviews), recency (old bad behavior shouldn't define you forever), inflation (everyone eventually gets 4.8 stars)
- Reputation portability: why don't reputations transfer between platforms? (network effects, incentive to lock users in)

### Content moderation at scale
- Who decides what's acceptable? Platform rules, community norms, legal requirements, algorithmic filtering
- Moderation approaches: centralized (platform decides), distributed (community votes), hybrid (flagging + review)
- Reddit's model: subreddit-level community moderation — scales well, creates inconsistency
- Tradeoffs: free speech vs. safety, consistency vs. context-sensitivity, speed vs. accuracy
- AI-assisted moderation: high volume requires automation; false positives and appeals systems

### Platform design and behavior
- Every UI decision is a behavior choice: infinite scroll → longer sessions (and more exhaustion)
- Variable reward schedules (like slot machines): intermittent feedback (likes, notifications) creates compulsive checking
- Algorithmic amplification: engagement-optimized feeds surface outrage because outrage drives clicks
- Counter-examples: platforms that prioritize different signals (Hacker News: votes decay with time; Mastodon: no algorithmic feed)

### Privacy in social systems
- Social data is uniquely sensitive: it reveals relationships, locations, political views, health status — often without explicit disclosure
- Re-identification risk: "anonymous" data + social graph can identify individuals (AOL search data, Netflix prize dataset)
- Data minimization in social systems: design for the minimum social graph necessary for the feature

---

## Exercises

**Set 1 — Network analysis (45 min):**
Read Chapters 1–2 of Kleinberg & Tardos (free online). Then:
1. Map a small real network you're part of (your GitHub followers, a Slack community, a friend group) — draw it, even roughly
2. Identify: who has high betweenness centrality? What weak ties connect different clusters?
3. What would happen to the network if the most central node left?
Save to `docs/reading/SOCIAL-NETWORK-ANALYSIS.md`.

**Set 2 — Reputation system design (30 min):**
Design a reputation system for one of:
- A marketplace for AI consulting services
- A peer review system for ML model evaluations
- A crowdsourcing platform for dataset labeling

Cover: what signals feed the score, how to handle cold start, how to prevent gaming, how to display it to build appropriate trust.
Save to `docs/reading/REPUTATION-SYSTEM-DESIGN.md`.

**Set 3 — Platform analysis (30 min):**
Pick one platform: Hacker News, Reddit, Twitter/X, Discord, or Wikipedia.
Analyze:
- What are the core incentive mechanisms (voting, reputation, visibility)?
- What behaviors do those incentives produce (intended and unintended)?
- What moderation model does it use?
- What would you change and why?
Save to `docs/reading/PLATFORM-ANALYSIS.md`.

**Set 4 — Read a CSCW paper (30 min):**
Go to the [CSCW 2024 proceedings](https://dl.acm.org/conference/cscw). Find a paper on a topic you care about (content moderation, crowdsourcing, online communities, reputation). Read the abstract, intro, and findings.
- What was the research question?
- What method did they use?
- What did they find that surprised you?
- How would this change a product you've used?
Save to `docs/reading/CSCW-PAPER-NOTES.md`.

---

## Checks — you understand this when you can:
- [ ] Explain the 4 conditions for the "wisdom of crowds" and give a failure example for each
- [ ] Define betweenness centrality and explain why bridge nodes matter
- [ ] Design a reputation system and identify its cold-start failure mode
- [ ] Explain how variable reward schedules work and name a platform that uses them deliberately
- [ ] Describe 2 privacy risks specific to social graph data

---

## Artifacts to commit
- [ ] `docs/reading/SOCIAL-NETWORK-ANALYSIS.md`
- [ ] `docs/reading/REPUTATION-SYSTEM-DESIGN.md`
- [ ] `docs/reading/PLATFORM-ANALYSIS.md`
- [ ] `docs/reading/CSCW-PAPER-NOTES.md`
- [ ] Glossary entries: collective intelligence, crowdsourcing, homophily, betweenness centrality, reputation system, content moderation, variable reward schedule
- [ ] Log entry in `docs/LOG.md`

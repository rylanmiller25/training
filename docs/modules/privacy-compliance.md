# Module: Privacy + Compliance

**Phase:** 3 (Weeks 13–22)  
**Slug:** `privacy-compliance`  
**Status:** not started  
**Estimated time:** 4–5 hours

---

## What it is / how to think about it

Privacy regulations define what data you can collect, how you must store and protect it, and what rights users have over it. For PMs and engineers, this isn't just legal overhead — it shapes product design, data architecture, and what features you can ship.

**Mental model:** Privacy is a product constraint like performance or security. Build it in from the start (privacy-by-design) or you'll spend 10x more retrofitting it later.

---

## Prerequisites
- HTTP + APIs, Security modules

---

## Best resources

**Primary:**
1. [GDPR overview – GDPR.eu](https://gdpr.eu/what-is-gdpr/) — plain-language summary of the regulation
2. [CCPA overview – California AG](https://oag.ca.gov/privacy/ccpa) — official summary

**Supporting:**
- [Privacy by Design – Ann Cavoukian (summary)](https://www.ipc.on.ca/wp-content/uploads/resources/7foundationalprinciples.pdf) — 7-principle framework
- [IAPP Glossary](https://iapp.org/resources/glossary/) — authoritative privacy terms
- [DPA (Data Processing Agreement) template – Termly](https://termly.io/resources/templates/data-processing-agreement-template/) — understand what vendors sign

**YouTube:**
- [GDPR explained in 10 minutes](https://www.youtube.com/watch?v=Assdm6fIHlE) (10 min)
- [CCPA for Developers – Twilio Segment](https://www.youtube.com/watch?v=Lhf8dNqS3hE) (20 min)

---

## Core concepts to cover

### GDPR (General Data Protection Regulation) — EU
**Who it applies to:** any company processing data of EU residents (regardless of where company is based)

**6 lawful bases for processing data:**
1. Consent — freely given, specific, informed, unambiguous
2. Contract — processing necessary to fulfill a contract
3. Legal obligation
4. Vital interests
5. Public task
6. Legitimate interests (most flexible; requires balancing test)

**Key user rights:**
- Right to access (get a copy of your data)
- Right to erasure ("right to be forgotten")
- Right to rectification (correct inaccurate data)
- Right to data portability (export in machine-readable format)
- Right to object (stop certain processing)
- Right not to be subject to automated decision-making

**Key obligations:**
- Data minimization: collect only what you need
- Purpose limitation: only use data for stated purpose
- Storage limitation: don't keep data longer than needed
- 72-hour breach notification to supervisory authority
- Appoint a DPO (Data Protection Officer) if processing at scale
- Privacy notices: clear, plain language, upfront

**GDPR fines:** up to €20M or 4% of global annual revenue (whichever is higher)

### CCPA (California Consumer Privacy Act) — US
**Who it applies to:** businesses that collect California residents' data AND meet one of: > $25M revenue, > 100K records/year, > 50% revenue from selling data.

**User rights (similar to GDPR):**
- Right to know what data is collected
- Right to delete
- Right to opt out of sale of personal information
- Right to non-discrimination

**Key difference from GDPR:** CCPA is opt-out by default (you can collect unless user opts out); GDPR often requires opt-in consent.

### Privacy-by-design principles
1. **Proactive, not reactive:** anticipate risks before they materialize
2. **Privacy as default:** privacy-protective settings are the default
3. **Privacy embedded into design:** not bolted on after
4. **Full functionality:** privacy and functionality aren't zero-sum
5. **End-to-end security:** protect throughout lifecycle
6. **Visibility and transparency:** what you say you do, you do
7. **Respect for user privacy:** keep it user-centric

### Data minimization in practice
- Only collect fields you actively use in a feature
- Delete data that's no longer needed (set retention policies)
- Anonymize or pseudonymize analytics data where possible
- Don't log PII in application logs (phone numbers, email addresses, SSNs)

### Third-party vendors + DPAs
- Every vendor that processes your users' data (analytics, email, payment) must sign a Data Processing Agreement
- You are responsible for your processors' compliance
- Understand what data each vendor receives and why

### AI-specific privacy considerations
- Training data: can't train on personal data without consent or legitimate basis
- Model outputs: LLMs can memorize and reproduce PII from training data
- Automated decisions: GDPR Article 22 — restrictions on purely automated decisions with significant effect
- Retention of inference inputs/outputs: consider privacy implications of logging

---

## Exercises

**Set 1 — Map data flows (30 min):**
For a hypothetical SaaS app (user accounts, email notifications, analytics, payment processing):
1. List all data collected (email, name, IP, payment info, usage events, etc.)
2. For each, identify: legal basis (GDPR), necessary for core function? Shared with third parties?
3. Identify which fields could be removed/anonymized without breaking the product.
Save to `docs/reading/privacy-data-map.md`.

**Set 2 — Read a real privacy policy (20 min):**
Read Notion's or Linear's privacy policy. Answer:
- What lawful bases do they claim?
- How long do they retain data?
- Do they sell data?
- What rights do they grant users?
- What third-party processors do they list?
Save to `docs/reading/privacy-policy-analysis.md`.

**Set 3 — GDPR vs CCPA comparison (20 min):**
Build a comparison table:
- Who it applies to
- Lawful basis for processing
- Consent model (opt-in vs opt-out)
- Key user rights
- Fines
Save to `docs/reading/gdpr-ccpa-comparison.md`.

**Set 4 — Product decision: privacy tradeoff (20 min):**
You're building a feature to personalize content recommendations using browsing history.
- What data would you collect? What's the minimum needed?
- What legal basis applies?
- What disclosure is required?
- What if the user wants to delete their history?
Write your analysis in `docs/reading/privacy-product-decision.md`.

---

## Checks — you understand this when you can:
- [ ] Name the 6 lawful bases for processing under GDPR
- [ ] Explain the key user rights under GDPR and CCPA
- [ ] Explain the difference between opt-in (GDPR default) and opt-out (CCPA default)
- [ ] Explain what a DPA is and why you need one with vendors
- [ ] Apply data minimization to a product feature
- [ ] Explain why logging PII in application logs is risky

---

## Artifacts to commit
- [ ] `docs/reading/privacy-data-map.md`
- [ ] `docs/reading/privacy-policy-analysis.md`
- [ ] `docs/reading/gdpr-ccpa-comparison.md`
- [ ] `docs/reading/privacy-product-decision.md`
- [ ] Glossary entries: GDPR, CCPA, data minimization, PII, DPA, right to erasure, privacy-by-design
- [ ] Log entry in `docs/log.md`

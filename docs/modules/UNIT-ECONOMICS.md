# Module: Growth Metrics + Unit Economics

**Phase:** 3  
**Slug:** `unit-economics`  
**Status:** not started  

---

## What it is / how to think about it

Unit economics answers: "Does this business make money on each customer?" Growth metrics answer: "How fast is it growing and how efficiently?" Together they tell you whether a business is healthy, not just big.

**Mental model:** Imagine a vending machine. Unit economics asks: does each snack sold make profit after cost? Growth metrics ask: are you selling more snacks this month than last, and did you have to spend more on advertising to get there?

---

## Prerequisites
- No technical prereqs. Basic arithmetic and spreadsheet familiarity helps.

---

## Best resources

**Primary:**
1. [Lenny's Newsletter – SaaS metrics glossary](https://www.lennysnewsletter.com/p/saas-metrics) — clear definitions with benchmarks
2. [a16z SaaS Metrics](https://a16z.com/16-metrics-for-saas-growth/) — the canonical VC list of metrics that matter

**Supporting:**
- [The SaaS Metrics That Matter – David Skok](https://www.forentrepreneurs.com/saas-metrics/) — deep dive on LTV/CAC with formulas
- [Bessemer's State of the Cloud](https://www.bvp.com/atlas/state-of-the-cloud) — annual benchmarking report; understand what "good" looks like
- [Stripe Atlas Guide to SaaS Metrics](https://stripe.com/atlas/guides/saas-metrics)

**YouTube:**
- [SaaS Metrics explained – David Skok](https://www.youtube.com/watch?v=MIFSMkqQnXI) (45 min — best comprehensive walkthrough)
- [Unit Economics – Y Combinator](https://www.youtube.com/watch?v=Ipa6Q4kkvso) (15 min)

---

## Core concepts to cover

### The fundamental metrics

**ARR / MRR (Annual/Monthly Recurring Revenue)**
- MRR = sum of all active subscription revenue in a month
- ARR = MRR × 12
- Track: new MRR, expansion MRR, churned MRR, net new MRR

**CAC (Customer Acquisition Cost)**
- Total sales + marketing spend ÷ number of new customers acquired
- Blended CAC includes all marketing; paid CAC includes only paid channels
- Rule of thumb: CAC should be recovered within 12–18 months

**LTV (Lifetime Value)**
- Average revenue per account × gross margin ÷ churn rate
- Or: ARPU × avg customer lifespan
- Simplified: LTV = ARPU / churn rate (for steady-state businesses)

**LTV:CAC ratio**
- < 1: you lose money on every customer (unsustainable)
- 1–3: acceptable, but not efficient
- > 3: healthy SaaS business (benchmark: aim for 3x+)
- > 5: possibly under-investing in growth (leaving money on the table)

**Churn**
- **Logo churn:** % of customers who cancel per period
- **Revenue churn:** % of MRR lost per period
- **Net revenue churn:** revenue churn minus expansion revenue (upsells); can be negative (good!)
- Negative net revenue churn = existing customers grow faster than you lose

**NRR (Net Revenue Retention)**
- Revenue from existing customers this year ÷ same cohort's revenue last year
- NRR > 100% = business grows even without acquiring new customers
- Best-in-class SaaS: 120–140% NRR

### Growth metrics

**DAU / MAU (Daily / Monthly Active Users)**
- DAU/MAU ratio = stickiness (how often users return); 20%+ is good, 50%+ is exceptional

**Magic Number**
- Net new ARR ÷ prior quarter S&M spend
- > 0.75: efficient sales motion; < 0.5: something is wrong

**Payback period**
- Months to recover CAC: CAC ÷ (ARPU × gross margin)
- Target: < 12 months for consumer, < 18 months for SMB, < 24 months for enterprise

**Burn Multiple**
- Net burn ÷ net new ARR
- < 1: very efficient; > 2: burning too much to grow

### Cohort analysis
- Track groups of customers who signed up in the same period
- Shows: do customers retain over time? Do newer cohorts retain better/worse?
- Revenue cohort curves that flatten = good retention; curves that drop to zero = churn problem

---

## Exercises

**Set 1 — Calculate unit economics (30 min):**
Given: 500 customers, $80 ARPU/month, 85% gross margin, 2% monthly churn, $150K/month S&M spend, 50 new customers acquired last month.
Calculate: MRR, ARR, CAC, LTV, LTV:CAC ratio, payback period in months.
Show your work in `docs/reading/UNIT-ECON-CALC.md`.

**Set 2 — Churn scenarios (20 min):**
For each scenario, is this a problem? Why?
1. 3% monthly churn, but 110% NRR
2. 1% monthly churn, but 90% NRR
3. 5% monthly churn, 5% monthly new customer growth, NRR 100%
Write analysis in `docs/reading/UNIT-ECON-CALC.md` (append).

**Set 3 — Read a real S-1 (45 min):**
Find an S-1 filing from a SaaS company (Snowflake, Datadog, or HubSpot are readable). Look for:
- How do they define their key metrics?
- What's their NRR?
- What's their CAC efficiency?
- What cohort retention data do they show?
Write a 5-bullet summary in `docs/reading/S1-ANALYSIS.md`.

**Set 4 — Build a simple model (45 min):**
In a spreadsheet (Google Sheets or Excel), model a simple SaaS business:
- Month 1: 10 customers at $100/month; 5% churn; 20 new customers/month; $5K S&M spend/month
- Project 12 months: customer count, MRR, cumulative CAC spend, cumulative revenue
- At what month does monthly revenue exceed monthly S&M spend?
Export as CSV to `docs/projects/saas-model.csv`.

---

## Checks — you understand this when you can:
- [ ] Calculate LTV, CAC, and LTV:CAC ratio given the inputs
- [ ] Explain why NRR > 100% is a powerful property
- [ ] Explain the difference between logo churn and revenue churn
- [ ] Interpret a cohort retention curve — what makes it good or bad?
- [ ] Explain the Magic Number and what a reading of 0.4 tells you
- [ ] Explain why DAU/MAU ratio matters more than raw MAU

---

## Artifacts to commit
- [ ] `docs/reading/UNIT-ECON-CALC.md`
- [ ] `docs/reading/S1-ANALYSIS.md`
- [ ] `docs/projects/saas-model.csv`
- [ ] Glossary entries: ARR, MRR, CAC, LTV, churn, NRR, cohort, burn multiple, magic number
- [ ] Log entry in `docs/LOG.md`

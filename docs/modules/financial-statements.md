# Module: Financial Statements + SaaS Interpretation

**Phase:** 3 (Weeks 13–22)  
**Slug:** `financial-statements`  
**Status:** not started  
**Estimated time:** 5–7 hours

---

## What it is / how to think about it

Three financial statements tell the complete story of a business: the income statement (is it profitable?), the balance sheet (what does it own and owe?), and the cash flow statement (does it actually have cash?). Reading them lets you evaluate any company — not just as a PM, but as a potential employee, investor, or competitor analyst.

**Mental model:** Income statement = movie (what happened over a period). Balance sheet = photograph (what you own/owe at a point in time). Cash flow = bank account (what actually moved in and out).

SaaS businesses look weird on traditional financial statements because revenue is deferred (you collect cash upfront but recognize it over time), and customer acquisition costs hit immediately but generate revenue over years.

---

## Prerequisites
- Unit Economics module (builds on ARR, MRR, churn)

---

## Best resources

**Primary:**
1. [Financial Statements – Investopedia](https://www.investopedia.com/terms/f/financial-statements.asp) — clear definitions with examples
2. [How to Read Financial Statements – Khan Academy](https://www.khanacademy.org/economics-finance-domain/core-finance/accounting-and-financial-stateme) — free video series

**Supporting:**
- [SaaS Financial Model – Christoph Janz](https://christophjanz.blogspot.com/2013/04/a-saas-metrics-dashboard.html) — SaaS-specific interpretation
- [GAAP vs non-GAAP – Investopedia](https://www.investopedia.com/terms/n/non-gaap-earnings.asp) — why SaaS companies report both
- [Rule of 40 – Andreessen Horowitz](https://a16z.com/the-rule-of-40-for-a-healthy-saas-company-explained/) — growth rate + profit margin benchmark

**YouTube:**
- [How to Read an Income Statement – Investopedia](https://www.youtube.com/watch?v=3lehHqtTDUI) (10 min)
- [Balance Sheet explained – Accounting Stuff](https://www.youtube.com/watch?v=A5r_wLPRkbE) (15 min)
- [SaaS Financial Modeling – David Cummings](https://www.youtube.com/watch?v=GKKUKFXlqdc) (30 min)

---

## Core concepts to cover

### Income Statement (P&L)
```
Revenue
- Cost of Revenue (COGS)           → Gross Profit
- Operating Expenses (OpEx)        → Operating Income (EBIT)
- Interest + Taxes                 → Net Income
```
- **Gross margin** = Gross Profit ÷ Revenue (SaaS benchmark: 70–85%)
- **Operating margin** = Operating Income ÷ Revenue
- **EBITDA** = Earnings Before Interest, Taxes, Depreciation, Amortization (non-GAAP proxy for operating cash)

**SaaS specifics:**
- COGS: hosting/infra costs, customer support, professional services
- Sales & Marketing (S&M): largest opex for growth-stage SaaS
- R&D: capitalized vs expensed; product and engineering headcount
- G&A: finance, legal, HR

### Balance Sheet
```
Assets = Liabilities + Equity
```
- **Assets:** cash, accounts receivable, prepaid expenses, PP&E, intangibles
- **Liabilities:** deferred revenue (SaaS-critical), accounts payable, debt
- **Equity:** retained earnings, paid-in capital

**SaaS specifics:**
- **Deferred revenue:** cash collected but not yet recognized as revenue (customer paid annual upfront); appears as a liability
- High deferred revenue = strong cash position despite low GAAP revenue

### Cash Flow Statement
Three sections:
1. **Operating cash flow:** cash from running the business (add back D&A, changes in working capital)
2. **Investing cash flow:** capital expenditures, acquisitions
3. **Financing cash flow:** debt, equity raises, buybacks

**Free Cash Flow (FCF):** Operating cash flow - capex. The most important metric for evaluating actual profitability.

### SaaS-specific financial concepts
- **Rule of 40:** Growth rate + FCF margin ≥ 40% = healthy SaaS business
- **Burn rate:** how much cash spent per month; runway = cash ÷ burn rate
- **GAAP vs non-GAAP:** SaaS often reports non-GAAP earnings excluding stock comp; compare both
- **Revenue recognition (ASC 606):** recognize revenue ratably over contract period, not when cash received

---

## Exercises

**Set 1 — Read an income statement (30 min):**
Pull up Datadog's or Cloudflare's most recent quarterly earnings (investor relations pages or SEC EDGAR).
- What's the gross margin?
- What's the operating margin?
- Is the company GAAP profitable? Non-GAAP?
- What's the biggest operating expense line?
Write answers in `docs/reading/financial-stmt-exercise.md`.

**Set 2 — Deferred revenue exercise (20 min):**
A SaaS company signs a $120K annual contract on Jan 1, paid upfront.
- How much revenue do they recognize in Q1? Q2? Full year?
- How does deferred revenue on the balance sheet change each quarter?
- Why does cash flow look better than the income statement in Q1?
Write explanation in `docs/reading/financial-stmt-exercise.md` (append).

**Set 3 — Rule of 40 analysis (30 min):**
Look up 3 public SaaS companies and calculate their Rule of 40 score using their most recent annual report (growth rate = YoY revenue growth; FCF margin = FCF ÷ revenue).
Which ones pass? Which don't? What does the score tell you about their strategy?
Save to `docs/reading/rule-of-40.md`.

**Set 4 — Unit economics → financials bridge (20 min):**
Given: 1,000 customers at $10K ACV, 85% gross margin, $2M S&M spend, $3M R&D, $500K G&A.
Build a simple P&L:
- Revenue, COGS, Gross Profit, Gross Margin %
- OpEx total, Operating Loss/Income
- What would need to change to hit breakeven?
Write in `docs/reading/financial-stmt-exercise.md` (append).

---

## Checks — you understand this when you can:
- [ ] Explain what each of the three financial statements shows
- [ ] Calculate gross margin from revenue and COGS
- [ ] Explain why deferred revenue is a liability and why it's actually a good sign
- [ ] Explain the Rule of 40 and why it balances growth and profitability
- [ ] Explain why FCF is more meaningful than GAAP net income for SaaS
- [ ] Look at a real company's financials and identify whether they are healthy

---

## Artifacts to commit
- [ ] `docs/reading/financial-stmt-exercise.md`
- [ ] `docs/reading/rule-of-40.md`
- [ ] Glossary entries: gross margin, EBITDA, deferred revenue, free cash flow, burn rate, Rule of 40, GAAP
- [ ] Log entry in `docs/log.md`

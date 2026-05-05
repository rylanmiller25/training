# Module: Notion

**Phase:** 3 (Weeks 13–22) — integrated tool module  
**Slug:** `notion`  
**Status:** not started  
**Estimated time:** 3–4 hours

---

## What it is / how to think about it

Notion is a flexible all-in-one workspace: docs, wikis, databases, and project tracking in one tool. For PMs and technical ICs, it's the primary surface for writing specs, tracking work, and building knowledge bases. Understanding how to use it well — and its integrations — is a practical multiplier.

**Mental model:** Notion is a database with a document interface layered on top. Every page is an entry in a database (even if you don't see it that way). Databases have views (table, board, calendar, gallery, list) and relations. This makes it unusually flexible and unusually confusing until you internalize the model.

---

## Prerequisites
- None. Familiarity with any productivity tool helps.

---

## Best resources

**Primary:**
1. [Notion official guides](https://www.notion.so/guides) — structured, comprehensive, up-to-date
2. [Notion for Teams – official course](https://www.notion.so/learn/teams) — free video course

**Supporting:**
- [Thomas Frank Explains – Notion YouTube](https://www.youtube.com/channel/UC2D2CMWXMOVWx7giW1n3LIg) — best community tutorials
- [Notion API docs](https://developers.notion.com/) — for integrations

**YouTube:**
- [Notion full tutorial – Thomas Frank](https://www.youtube.com/watch?v=oTahLEX3NXo) (40 min)
- [Notion databases explained – Thomas Frank](https://www.youtube.com/watch?v=mAJOpO-_XX4) (20 min)

---

## Core concepts

- **Pages and blocks:** everything is a block (text, image, code, embed, database view)
- **Databases:** tables with properties (text, number, select, date, relation, formula, rollup)
- **Views:** same database rendered as table, board (Kanban), calendar, gallery, or list
- **Relations and rollups:** link databases together; aggregate data across relations
- **Templates:** reusable page structures; share with teams
- **Integrations:** GitHub (sync issues), Slack (notifications), Zapier/Make (automation), Notion API (custom)

---

## Exercises

**Set 1 — Set up your training workspace (30 min):**
In Notion, create a workspace for this training program:
1. A "Modules" database with properties: Phase (number), Status (select: not started/in progress/complete), Week (number)
2. Add one entry per module from the curriculum map
3. Create a Kanban view grouped by Status
4. Create a filtered view showing only Phase 1 modules

**Set 2 — Weekly review template (20 min):**
Create a template page for weekly reviews (mirrors `docs/weekly/<YYYY-WW>.md` structure):
- Done this week
- Learned
- Gaps / revisit
- Next week
Test it: create this week's entry using the template.

**Set 3 — GitHub integration (20 min):**
Connect Notion to GitHub via the Notion GitHub integration (or Zapier free tier):
- Sync open issues from this training repo into a Notion database
- Add a "Link to Issue" property
- Filter for open issues only

**Set 4 — API exploration (20 min):**
Using the Notion API (developers.notion.com):
1. Create an integration token
2. Query your Modules database via API (curl or Postman)
3. Parse the response: find all modules with Status = "not started"
This connects Notion to the HTTP/APIs module skills.

---

## Checks — you understand this when you can:
- [ ] Build a Notion database with 5+ properties and 3 different views
- [ ] Use relations to link two databases and rollups to aggregate data
- [ ] Create a reusable template with pre-filled structure
- [ ] Make a basic API call against a Notion database

---

## Artifacts to commit
- [ ] Note your Notion workspace URL in `docs/reading/notion-setup.md`
- [ ] Export your Modules database as CSV to `docs/projects/modules-tracker.csv`
- [ ] Log entry in `docs/log.md`

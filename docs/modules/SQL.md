# Module: SQL

**Phase:** 1  
**Slug:** `sql`  
**Status:** not started  

---

## What it is / how to think about it

SQL is the universal language for working with relational databases. Almost every product you'll work on has a relational database underneath it (Postgres, MySQL, SQLite). SQL lets you ask structured questions about data and is the primary tool for analysis, debugging, and data exploration.

**Mental model:** A database is a collection of tables (like spreadsheets), each with typed columns. SQL is a declarative language — you describe *what* you want, not *how* to compute it. The database figures out execution.

Key insight: think in sets, not loops. SQL operates on entire tables at once.

---

## Prerequisites
- None — SQL is self-contained. Spreadsheet experience helps with intuition.

---

## Best resources

**Primary:**
1. [SQLBolt](https://sqlbolt.com/) — interactive, browser-based SQL exercises. Start here. (free, ~2 hours)
2. [Mode SQL Tutorial](https://mode.com/sql-tutorial/) — covers beginner through advanced analytics patterns; run queries in-browser

**Supporting:**
- [PostgreSQL docs – Tutorial](https://www.postgresql.org/docs/current/tutorial.html) — authoritative reference for Postgres
- [SQL cheat sheet – LearnSQL](https://learnsql.com/blog/sql-basics-cheat-sheet/) — bookmark for quick lookups
- [Use The Index, Luke](https://use-the-index-luke.com/) — how indexes work (read when queries get slow)

**YouTube:**
- [SQL Tutorial – Full Database Course for Beginners – freeCodeCamp](https://www.youtube.com/watch?v=HXV3zeQKqGY) (4.5 hrs — skip to relevant sections)
- [SQL Window Functions – Kahan Data Solutions](https://www.youtube.com/watch?v=H6OTMoXjNiM) (25 min — best window function intro)

---

## Core concepts to cover

### Basics: SELECT, filtering, sorting
```sql
SELECT column1, column2 FROM table;
SELECT * FROM users WHERE active = true;
SELECT * FROM orders WHERE amount > 100 ORDER BY created_at DESC;
SELECT * FROM products LIMIT 10 OFFSET 20;
```

### Aggregations
```sql
SELECT COUNT(*) FROM users;
SELECT status, COUNT(*) FROM orders GROUP BY status;
SELECT user_id, SUM(amount) as total FROM orders GROUP BY user_id;
SELECT department, AVG(salary) FROM employees GROUP BY department HAVING AVG(salary) > 80000;
```

### JOINs — the critical concept
```sql
-- INNER JOIN: only rows that match in both tables
SELECT u.name, o.amount
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- LEFT JOIN: all rows from left, NULL for non-matching right
SELECT u.name, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name;

-- Conceptual: think of joins as combining tables by a matching key
```

### Window functions (analytics powerhouse)
```sql
-- ROW_NUMBER: rank within a partition
SELECT name, salary,
  ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
FROM employees;

-- SUM with window: running total
SELECT date, revenue,
  SUM(revenue) OVER (ORDER BY date) as running_total
FROM daily_sales;

-- LAG/LEAD: compare to previous/next row
SELECT date, revenue,
  LAG(revenue) OVER (ORDER BY date) as prev_revenue
FROM daily_sales;
```

### Subqueries + CTEs
```sql
-- Subquery
SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE amount > 500);

-- CTE (Common Table Expression) — cleaner, preferred
WITH high_value_orders AS (
  SELECT user_id FROM orders WHERE amount > 500
)
SELECT * FROM users WHERE id IN (SELECT user_id FROM high_value_orders);
```

### Data modification
```sql
INSERT INTO products (name, price) VALUES ('widget', 9.99);
UPDATE products SET price = 12.99 WHERE id = 42;
DELETE FROM sessions WHERE expires_at < NOW();
```

### Schema basics
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
-- Understand: primary key, foreign key, indexes, NOT NULL, UNIQUE
```

---

## Exercises

**Set 1 — SQLBolt (60–90 min):**
Complete all 18 SQLBolt lessons at https://sqlbolt.com/. These are interactive and self-grading.

**Set 2 — Aggregation analysis (30 min):**
Use Mode's in-browser editor with their sample data, or install SQLite locally.

Write queries to answer:
1. How many orders per user? (GROUP BY + COUNT)
2. Which 5 users have the highest total order value? (GROUP BY + SUM + ORDER BY + LIMIT)
3. What % of users have placed more than 1 order? (subquery or CTE + COUNT)

**Set 3 — JOIN practice (30 min):**
Given tables `users(id, name, email)` and `orders(id, user_id, amount, status)`:
1. Get all users and their total order count (include users with 0 orders).
2. Find users who have never placed an order.
3. Find orders where the user's email is from gmail.com.

**Set 4 — Window function (30 min):**
Given `daily_revenue(date, product_id, revenue)`:
1. Calculate a 7-day rolling average of revenue per product.
2. Rank products by revenue within each month.
3. Show each day's revenue and the prior day's revenue side by side.

**Set 5 — Mini analysis artifact (45 min):**
Write a short analysis note `docs/reading/SQL-ANALYSIS-NOTES.md` with:
- Your 3 most useful SQL patterns and why
- The JOIN type you'd use for each of: "all users + order count", "only users with orders", "orders missing users"
- When you'd use a window function vs GROUP BY

---

## Checks — you understand this when you can:
- [ ] Write a SELECT with WHERE, ORDER BY, LIMIT without looking anything up
- [ ] Explain the difference between INNER, LEFT, RIGHT, and FULL OUTER JOIN
- [ ] Use GROUP BY with COUNT, SUM, AVG, and filter with HAVING
- [ ] Write a CTE and explain why it's cleaner than a subquery
- [ ] Write a window function using ROW_NUMBER, SUM, or LAG
- [ ] Explain what an index does and when it helps
- [ ] Read an unfamiliar schema and write a query against it

---

## Artifacts to commit
- [ ] `docs/reading/SQL-ANALYSIS-NOTES.md` — your analysis patterns note
- [ ] Glossary entries: SQL, JOIN, aggregate, window function, CTE, index, primary key, foreign key
- [ ] Log entry in `docs/LOG.md`

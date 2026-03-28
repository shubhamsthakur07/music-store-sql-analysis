# 🎵 Music Store Sales Analysis — SQL Project

A structured SQL analysis of a digital music store database, covering customer behaviour, revenue trends, artist performance, and genre popularity across multiple countries. The project demonstrates a progression from basic queries to advanced analytical SQL using CTEs and window functions.

---

## 📌 Project Overview

| Attribute | Details |
|---|---|
| **Domain** | Retail / Music Streaming |
| **Tool** | PostgreSQL / SQL |
| **Dataset** | Music Store Database (11 relational tables) |
| **Techniques** | Joins, Subqueries, Aggregations, CTEs, Window Functions |
| **Difficulty** | Easy → Moderate → Advanced |

---

## 🗃️ Database Schema

The database contains **11 interrelated tables** modelling the full lifecycle of a digital music store:
```
ARTIST <── ALBUM <── TRACK ──> GENRE
                        │
                        └──> MEDIA_TYPE
                        └──> PLAYLIST_TRACK ──> PLAYLIST

CUSTOMER ──< INVOICE ──< INVOICE_LINE >── TRACK

EMPLOYEE (self-referencing via reports_to)
```

**Key Relationships:**
- `Artist → Album → Track` forms the music catalogue hierarchy
- `Customer → Invoice → Invoice_Line → Track` captures the complete purchase trail
- `Employee` table is self-referencing (manager hierarchy via `reports_to`)

---

## 📊 Business Questions Solved

### 🟢 Easy Level

| # | Question | SQL Concepts |
|---|---|---|
| 1 | Who is the senior-most employee based on job title level? | `ORDER BY`, `LIMIT` |
| 2 | Which country has the most invoices? | `COUNT`, `GROUP BY`, `ORDER BY` |
| 3 | What are the top 3 invoice values? | `ORDER BY DESC`, `LIMIT` |
| 4 | Which city generated the highest total invoice revenue? | `SUM`, `GROUP BY` |
| 5 | Which customer has spent the most money overall? | `JOIN`, `SUM`, `GROUP BY` |

### 🟡 Moderate Level

| # | Question | SQL Concepts |
|---|---|---|
| 6 | Return email, name & genre of all Rock music listeners (sorted by email) | Multi-table `JOIN`, `Subquery`, `DISTINCT` |
| 7 | Which are the top 10 rock artists by number of tracks? | 4-table `JOIN`, `COUNT`, `GROUP BY` |
| 8 | List all tracks longer than the average track length | `Scalar Subquery`, `AVG`, `ORDER BY` |

### 🔴 Advanced Level

| # | Question | SQL Concepts |
|---|---|---|
| 9 | How much has each customer spent on the best-selling artist? | `CTE`, 5-table `JOIN`, `SUM` |
| 10 | What is the most popular genre in each country? | `CTE`, `ROW_NUMBER()`, `PARTITION BY` |
| 11 | Who is the top-spending customer in each country? | `CTE`, `ROW_NUMBER()`, `PARTITION BY` |

---

## 🔍 Featured Queries

### Top Customer per Country (Window Function)
```sql
WITH customer_country AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           i.billing_country AS country,
           SUM(i.total) AS total_spent,
           ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS RowNo
    FROM invoice AS i
    JOIN customer AS c ON i.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, i.billing_country
)
SELECT country, first_name, last_name, total_spent
FROM customer_country
WHERE RowNo <= 1;
```

### Most Popular Genre per Country (CTE + ROW_NUMBER)
```sql
WITH popular_genre AS (
    SELECT COUNT(il.quantity) AS purchases, c.country, g.name, g.genre_id,
           ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS RowNo
    FROM invoice_line AS il
    JOIN invoice AS i ON il.invoice_id = i.invoice_id
    JOIN customer AS c ON i.customer_id = c.customer_id
    JOIN track AS t ON il.track_id = t.track_id
    JOIN genre AS g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name, g.genre_id
)
SELECT * FROM popular_genre WHERE RowNo <= 1;
```

---

## 🛠️ SQL Skills Demonstrated

- ✅ **Multi-table JOINs** — up to 5 tables joined in a single query
- ✅ **Aggregate Functions** — `SUM`, `COUNT`, `AVG` with `GROUP BY`
- ✅ **Subqueries** — correlated and scalar subqueries
- ✅ **Common Table Expressions (CTEs)** — `WITH` clause for readable, modular logic
- ✅ **Window Functions** — `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`
- ✅ **Filtering & Sorting** — `WHERE`, `HAVING`, `ORDER BY`, `LIMIT`
- ✅ **Deduplication** — `DISTINCT` for clean result sets

---

## 📁 Repository Structure
```
music-store-sql-analysis/
│
├── Music_Store_Analysis.sql     # All 11 analytical queries with comments
├── Music_Store_database.sql     # Database creation & seed script
├── SQL_SCHEMA.pdf               # Entity-Relationship diagram
└── README.md                    # Project documentation
```

---

## ▶️ How to Run

1. **Set up PostgreSQL** (or any SQL-compatible database)
2. **Create & seed the database:**
```sql
   \i Music_Store_database.sql
```
3. **Run the analysis queries:**
```sql
   \i Music_Store_Analysis.sql
```
   Or open `Music_Store_Analysis.sql` in **pgAdmin**, **DBeaver**, or **DB Browser for SQLite** and execute queries individually.

---

## 💡 Key Insights

- 🏆 The **USA** leads all countries in invoice volume
- 🎸 **Rock** is the dominant genre across most markets
- 💰 Revenue is concentrated among a small set of high-value customers per country — a signal for targeted retention strategies
- 🎵 The best-selling artist drives disproportionate customer spend — useful for playlist and licensing decisions

---

## 👤 Author

**Shubham**
- 📍 Mumbai, India
- 🎓 B.Com, University of Mumbai | CMA US Candidate
- 🛠️ Skills: SQL · Advanced Excel · Power BI · IFRS · US GAAP
- 🔗 www.linkedin.com/in/shubhamthakur07

---

This project is for educational and portfolio purposes. The dataset is publicly available and widely used for SQL practice.# music-store-sql-analysis
SQL-based analysis of a music store database to derive business insights on customers, sales, and genres

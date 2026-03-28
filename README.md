# 🎵 Music Store Data Analysis using SQL

## 📌 Project Overview
This project analyzes a digital music store database using SQL to extract business insights related to customers, sales, genres, and artists. The objective is to answer real-world business questions using structured query techniques.

The dataset consists of multiple interconnected tables such as customers, invoices, tracks, artists, albums, and genres.

---

## 🗂️ Database Schema
The database includes the following key tables:

- **Customer** – Customer details
- **Invoice** – Transaction-level data
- **Invoice_Line** – Line-item level purchase data
- **Track** – Song-level details
- **Album** – Album information
- **Artist** – Artist details
- **Genre** – Music category
- **Employee** – Organizational hierarchy
- **Playlist & Media Type** – Supporting metadata

The schema follows a **relational model** with primary and foreign key relationships.

---

## 🎯 Business Problems Solved

This project answers key analytical questions such as:

### 🔹 Sales & Revenue Insights
- Top 3 highest invoice values
- City generating the highest revenue
- Country with the most invoices
- Customer with highest total spending

### 🔹 Customer Analysis
- Identify top spending customers
- Analyze customer purchase behavior by country
- Find top customers per country

### 🔹 Music & Genre Insights
- Most popular genre by country
- Rock music listeners
- Artists with the highest number of rock songs
- Tracks longer than average duration

### 🔹 Advanced Analysis
- Customer spending on top-selling artist (using CTE)
- Country-wise top genre (using window functions)
- Country-wise top customer (handling ties using ROW_NUMBER)

---

## 🛠️ SQL Concepts Used

- Joins (INNER JOIN)
- Aggregations (SUM, COUNT, AVG)
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions (ROW_NUMBER)
- Grouping & Sorting
- Filtering with WHERE & HAVING
- Set-based logic

---

## 📊 Key Insights

- Identified high-value customers contributing maximum revenue  
- Found geographic regions with strongest sales performance  
- Discovered most popular genres across countries  
- Analyzed artist-level contribution to revenue  

---

## 🚀 How to Use

1. Import the schema into your SQL environment (MySQL/PostgreSQL/SQLite)
2. Load the dataset
3. Run the queries from `Music Store Analysis.sql`
4. Modify queries to explore additional insights

---

## 💡 Future Improvements

- Build interactive dashboards using Power BI / Tableau  
- Add stored procedures for reusable queries  
- Optimize queries for performance  
- Extend analysis with time-series trends  

---

## 📁 Files Included

- `SQL Schema.pdf` – Database schema diagram  
- `Music Store Analysis.sql` – SQL queries solving business problems  

---

## 🧠 Learning Outcome

This project demonstrates the ability to:
- Translate business questions into SQL queries  
- Work with relational databases  
- Perform data-driven analysis  
- Use advanced SQL features for deeper insights  

---

## 📌 Author
Shubham Thakur

---

This project is for educational and portfolio purposes. The dataset is publicly available and widely used for SQL practice.# music-store-sql-analysis
SQL-based analysis of a music store database to derive business insights on customers, sales, and genres

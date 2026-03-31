# 📊 GlobalMart SQL Database Project

**Author:** Nnajekwu Chinemerem Victory  
**Role:** Data Analyst  
**Tool Used:** MySQL  

---

## 📌 Project Overview

This project demonstrates an end-to-end SQL data analytics workflow, including database design, data cleaning, transformation, and business-driven analysis using MySQL.

The dataset represents a retail business (GlobalMart) with transactional data across customers, products, and orders.

The project goes beyond basic querying by transforming raw data into actionable business insights, simulating a real-world analytics scenario.

## 🧠 Business Problem

GlobalMart operates with large volumes of transactional data but lacks:

- Clean and standardized datasets
= Clear visibility into sales performance
- Insights into customer purchasing behavior
- Understanding of pricing, discounts, and shipping costs

👉 This results in inefficient decision-making.

## 🎯 Project Objectives

The goal of this project was to:

- Create a structured relational database
- Import and manage raw transactional data
- Implement a backup and recovery strategy
- Clean and standardize messy data
- Perform exploratory and advanced SQL analysis
- Generate business insights and recommendations
- Prepare data for visualization in Power BI
---

##  🗂️ Dataset Structure

The database consists of the following tables:

- categories → Product categories
- customers → Customer details
- employees → Staff information
- orders → Order transactions
- order_details → Individual order line items
- product → Product information
- shippers → Shipping companies

## 🧱 Database Design

Key Design Features:

 Primary Keys for uniqueness:
- orders (orderID)
- employees (employeeID)
- product (productID)
Composite Key:
- order_details (orderID, productID)
- Backup tables created for all datasets before cleaning

👉 This ensures data integrity, consistency, and reliability
## 🛠️ Sample SQL Queries

Below are full queries from the project.  
The full script is available in `GlobalMart Queries. mysql`.

## 📜 SQL Implementation

The complete SQL script used for this project  including database creation, data cleaning, transformations, and advanced analysis  is available in the file below:

👉 **[View Full SQL Script](https://drive.google.com/file/d/1HEBvXg2dENy3RJQ1PhfogTxUXwXXgPVS/view?usp=drive_link)**

---

### 🧩 SQL Workflow Breakdown

The SQL implementation was structured into the following key stages:

#### 1. Database Setup
- Created the `GlobalMart` database
- Defined structured tables for all datasets

#### 2. Data Import & Backup
- Inserted raw data into tables
- Created backup tables to preserve original datasets

#### 3. Data Cleaning & Standardization
- Removed leading/trailing spaces using `TRIM()`
- Standardized text using `UPPER()`
- Ensured consistency across all tables

#### 4. Data Transformation
- Created a `sales_summary` table
- Calculated:
  - Sales before discount
  - Discount amount
  - Sales after discount

#### 5. Exploratory Data Analysis (EDA)
- Product pricing analysis (MAX, MIN, AVG)
- Sales distribution
- Category filtering and sorting

#### 6. Business Analysis Queries
- Customer order behavior
- High-value customers (≥ 20 orders)
- Freight cost analysis
- Time-based order trends

#### 7. Advanced SQL Techniques
- Joins (INNER, LEFT, RIGHT, UNION)
- Subqueries
- Window Functions (`ROW_NUMBER`, `RANK`, `DENSE_RANK`)
- CASE statements for categorization
- Common Table Expressions (CTEs)

---

### 📌 Sample Queries

```sql
-- Top 5 most expensive products
SELECT productName, unitPrice
FROM product
ORDER BY unitPrice DESC
LIMIT 5;

-- Sales after discount calculation
SELECT *,
ROUND((unitPrice * quantity) - (unitPrice * quantity * discount), 2) AS sales_after_discount
FROM order_details;

-- Rank sales performance
SELECT *,
RANK() OVER(ORDER BY sales_after_discount DESC) AS sales_rank
FROM sales_summary;

---


```

## 🧹 Data Cleaning Approach

To ensure consistency and accuracy:

- Removed leading and trailing spaces using `TRIM()`
- Standardized text using `UPPER()`
- Created backup tables before cleaning
- Identified duplicates using `GROUP BY` and `HAVING`
- Created a cleaned version of the categories table

---

## 📂 Repository Structure

```
GlobalMart-SQL-Database-Project/
│
├── README.md                      # Project documentation and overview
├── GlobalMart Queries.mysql       # Full SQL script with all queries and data operations
├── screenshots/                   # All query output screenshots are ready
└── data/
    └── SQL Global Mart dataset.zip   # Raw dataset used to populate the tables

### Screenshots

All query outputs are ready in the screenshots/ folder, and you can also view them online here:
```
➡️ **[Open the Screenshots Folder](https://drive.google.com/drive/folders/1k7KUZJ-BMNy23JdcuvnZpAEyxBpyrD-a?usp=sharing)**
---

## 🎯 Key Skills Demonstrated

- Relational database design  
- Primary and composite keys  
- Data standardization  
- Duplicate detection  
- SQL querying fundamentals  
- Documentation and project structuring  

---


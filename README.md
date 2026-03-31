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

## 📜 Full SQL Implementation

```sql
 ------Database Setup
Q1. Create Database
CREATE DATABASE GlobalMart;

Q2. Use the Database
USE GlobalMart;

 ------Tables Creation
Q3. Create Categories Table
CREATE TABLE categories 
(
   categoryID INT,
   categoryName VARCHAR(50),
   categoryDescription TEXT
);

Q4. Create Customers Table
CREATE TABLE customers
(
   customerID VARCHAR(50),
   companyName VARCHAR(100),
   contactName VARCHAR(50),
   contactTitle VARCHAR(50),
   city VARCHAR(50),
   country VARCHAR(50)
);

Q5. Create Employees Table
CREATE TABLE employees
(
   employeeID INT PRIMARY KEY,
   employeeName VARCHAR(50),
   employeeTitle VARCHAR(50),
   city VARCHAR(50),
   country VARCHAR(50)
);

Q6. Create Order Details Table
CREATE TABLE order_details
(
   orderID INT,
   productID INT,
   unitPrice DECIMAL(10,2),
   quantity INT,
   discount FLOAT
);

Q7. Create Orders Table
CREATE TABLE orders
(
   orderID INT PRIMARY KEY,
   customerID VARCHAR(50),
   employeeID INT,
   orderDate DATE,
   requiredDate DATE,
   shippedDate DATE,
   shipperID INT,
   freight DECIMAL(10,2)
);

Q8. Create Product Table
CREATE TABLE product
(
   productID INT PRIMARY KEY,
   productName VARCHAR(50),
   quantityPerUnit INT,
   unitPrice DECIMAL(10,2),
   discontinued INT,
   categoryID INT
);

Q9. Create Shippers Table
CREATE TABLE shippers
(
   shipperID INT PRIMARY KEY,
   companyName VARCHAR(50)
);

------Data Import & Backup
Q10. Insert Sample Categories
INSERT INTO categories VALUES
(1,'beverages','Soft drinks, coffees, teas, beers, and ales'),
(1,'Beverages',' Soft drinks, coffees, teas, beers, and ales'),
(3,'CONFECTIONS','Desserts, candies, and sweet breads'),
(4,' Dairy Products','Cheeses'),
(5,'Grains & Cereals','Breads, crackers, pasta, and cereal'),
(6,' Meat & Poultry','Prepared meats'),
(7,'PRODUCE',' Dried fruit and bean curd'),
(8,'SEAFOOD',' Seaweed and fish');

Q11. Verify Categories Data
SELECT * FROM categories;

Q12–Q18. Create Backup Tables
CREATE TABLE categories_backup AS SELECT * FROM categories;
CREATE TABLE customers_backup AS SELECT * FROM customers;
CREATE TABLE employees_backup AS SELECT * FROM employees;
CREATE TABLE order_details_backup AS SELECT * FROM order_details;
CREATE TABLE orders_backup AS SELECT * FROM orders;
CREATE TABLE product_backup AS SELECT * FROM product;
CREATE TABLE shippers_backup AS SELECT * FROM shippers;

Q19. Add Composite Primary Key to Order Details
ALTER TABLE order_details
ADD PRIMARY KEY (orderID, productID);
Data Cleaning & Standardization

Q20. Select Sample Rows
SELECT * FROM order_details LIMIT 500;

Q21–Q26. Trim & Uppercase Text in Tables
-- Customers
UPDATE customers
SET customerID = TRIM(UPPER(customerID)),
    companyName = TRIM(UPPER(companyName)),
    contactName = TRIM(UPPER(contactName)),
    contactTitle = TRIM(UPPER(contactTitle)),
    city = TRIM(UPPER(city)),
    country = TRIM(UPPER(country));

-- Employees
UPDATE employees
SET employeeName = TRIM(UPPER(employeeName)),
    employeeTitle = TRIM(UPPER(employeeTitle)),
    city = TRIM(UPPER(city)),
    country = TRIM(UPPER(country));

-- Orders
UPDATE orders
SET customerID = TRIM(UPPER(customerID));

-- Products
UPDATE product
SET productName = TRIM(UPPER(productName));

-- Shippers
UPDATE shippers
SET companyName = TRIM(UPPER(companyName));

------Handling Duplicates
Q27. Identify Duplicate Categories
SELECT categoryID, COUNT(*)
FROM categories
GROUP BY categoryID
HAVING COUNT(*) > 1;

Q28. Create Cleaned Categories Table
CREATE TABLE categories_cleaned AS
SELECT DISTINCT
   categoryID,
   TRIM(UPPER(categoryName)) AS categoryName,
   TRIM(categoryDescription) AS categoryDescription
FROM categories;
Q29. Verify Cleaned Categories
SELECT * FROM categories_cleaned;

------Basic Queries on Categories
 Q30–Q34. Retrieve and Sort Categories
-- Retrieve products under order 10252
SELECT orderID, productID
FROM order_details
WHERE orderID = 10252;

-- Beverages category
SELECT * FROM categories_cleaned WHERE categoryName = 'BEVERAGES';

-- Exclude Beverages
SELECT * FROM categories_cleaned WHERE categoryName <> 'BEVERAGES';

-- Sort descending
SELECT * FROM categories_cleaned ORDER BY categoryID DESC;

-- Sort ascending
SELECT * FROM categories_cleaned ORDER BY categoryID ASC;

  Basic Queries on Products
Q35–Q41. Product Aggregations
-- Count
SELECT COUNT(*) AS total_products FROM product;

-- Max price
SELECT MAX(unitPrice) AS highest_price FROM product;

-- Min price
SELECT MIN(unitPrice) AS lowest_price FROM product;

-- Top 5 expensive
SELECT productName, unitPrice FROM product ORDER BY unitPrice DESC LIMIT 5;

-- Bottom 5 cheapest
SELECT productName, unitPrice FROM product ORDER BY unitPrice ASC LIMIT 5;

-- Average price
SELECT ROUND(AVG(unitPrice), 2) AS average_price FROM product;

-- Total quantity
SELECT SUM(quantityPerUnit) AS total_quantity FROM product;

------Order Details Calculations
Q42–Q46. Sales Metrics
-- Sales before discount
SELECT *, (unitPrice * quantity) AS sales_before_discount FROM order_details;

-- Discount amount
SELECT *, ROUND(unitPrice * quantity * discount, 2) AS discount_amount FROM order_details;

-- Sales after discount
SELECT *, ROUND((unitPrice * quantity) - (unitPrice * quantity * discount), 2) AS sales_after_discount FROM order_details;

-- Save to summary table
CREATE TABLE sales_summary AS
SELECT *,
(unitPrice * quantity) AS sales_before_discount,
ROUND(unitPrice * quantity * discount, 2) AS discount_amount,
ROUND((unitPrice * quantity) - (unitPrice * quantity * discount), 2) AS sales_after_discount
FROM order_details;

-- Check summary
SELECT * FROM sales_summary LIMIT 10;

------Joins & Customer-Order Analysis
Q47–Q58. Customer Orders
-- Customers with orders
SELECT c.customerID, c.contactName, o.orderID, o.orderDate
FROM customers c
INNER JOIN orders o ON c.customerID = o.customerID;

-- Customers including those without orders
SELECT c.customerID, c.contactName, o.orderDate
FROM customers c
LEFT JOIN orders o ON c.customerID = o.customerID;

-- Orders including unmatched orders
SELECT c.customerID, c.contactName, o.orderID, o.orderDate
FROM customers c
RIGHT JOIN orders o ON c.customerID = o.customerID;

-- All customers and orders (union)
SELECT c.contactName, o.orderID, o.orderDate
FROM customers c
LEFT JOIN orders o ON c.customerID = o.customerID
UNION
SELECT c.contactName, o.orderID, o.orderDate
FROM customers c
RIGHT JOIN orders o ON c.customerID = o.customerID;

-- Customers with ≥1 order
SELECT * FROM customers
WHERE customerID IN (SELECT DISTINCT customerID FROM orders);

-- Customers with ≥20 orders
SELECT * FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    GROUP BY customerID
    HAVING COUNT(orderID) >= 20
);

-- Products above average price
SELECT * FROM product
WHERE unitPrice > (SELECT AVG(unitPrice) FROM product);

-- Orders after a date
SELECT * FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    WHERE orderDate > '2015-04-30'
);

-- Orders before a date
SELECT * FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    WHERE orderDate < '2015-04-30'
);

-- Orders in date ranges
SELECT * FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    WHERE orderDate BETWEEN '2015-04-01' AND '2015-04-03'
);

SELECT * FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    WHERE orderDate BETWEEN '2015-05-01' AND '2015-05-10'
);

-- Customers with freight > 800
SELECT country, contactName, companyName
FROM customers
WHERE customerID IN (
    SELECT customerID
    FROM orders
    WHERE freight > 800
);

------Advanced Queries: Window Functions & Ranking
Q59–Q64. Row Numbers, Rank & Summation

-- Row number over orderID
SELECT *, ROW_NUMBER() OVER(ORDER BY orderID) AS row_num
FROM sales_summary;

-- Row number per order by sales_before_discount
SELECT *, ROW_NUMBER() OVER(PARTITION BY orderID ORDER BY sales_before_discount DESC) AS row_num
FROM sales_summary;

-- Rank sales_before_discount
SELECT *, RANK() OVER(ORDER BY sales_before_discount DESC) AS sales_rank
FROM sales_summary;

-- Rank sales_after_discount per order
SELECT *, RANK() OVER(PARTITION BY orderID ORDER BY sales_after_discount DESC) AS rank_per_order
FROM sales_summary;

-- Dense rank sales_after_discount
SELECT *, DENSE_RANK() OVER(ORDER BY sales_after_discount DESC) AS dense_rank_value
FROM sales_summary;

-- Sum quantity per order (window)
SELECT *, SUM(quantity) OVER(PARTITION BY orderID) AS total_quantity_per_order
FROM order_details;

------Conditional Categorization
Q65–Q66. Categorize Sales & Products

-- Sales categories
SELECT *,
CASE 
    WHEN sales_after_discount <= 500 THEN 'Low Sales'
    WHEN sales_after_discount <= 1000 THEN 'Medium Sales'
    ELSE 'High Sales'
END AS sales_category
FROM sales_summary;

-- Discontinued status
SELECT *,
CASE 
    WHEN discontinued = 1 THEN 'Yes'
    WHEN discontinued = 0 THEN 'No'
END AS discontinued_status
FROM product;

------Common Table Expressions (CTEs)
Q67–Q69. CTE Examples
-- Orders with freight > 70
WITH high_freight_orders AS (
    SELECT * FROM orders
    WHERE freight > 70
)
SELECT * FROM high_freight_orders;

-- Customers for orders with freight > 70
WITH high_freight_orders AS (
    SELECT * FROM orders
    WHERE freight > 70
)
SELECT * 
FROM high_freight_orders h
JOIN customers c ON h.customerID = c.customerID;

-- Calculate sales before discount with product info
WITH sales_calc AS (
    SELECT *, od.unitPrice * od.quantity AS sales_before_discount
    FROM order_details od
)
SELECT *
FROM sales_calc s
JOIN product p ON s.productID = p.productID;
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


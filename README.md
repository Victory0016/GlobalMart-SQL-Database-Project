# 📊 GlobalMart SQL Database Project

**Author:** Nnajekwu Chinemerem Victory  
**Role:** Data Analyst  
**Tool Used:** MySQL  

---

## 📌 Project Overview

This project demonstrates end-to-end SQL database setup, table design, data cleaning, and basic data exploration using MySQL.

The goal of this project was to:

- Create a structured relational database
- Import and manually insert data
- Implement backup strategy
- Clean and standardize messy data
- Perform exploratory queries

---

## 🛠️ Sample SQL Queries

Below are full queries from the project.  
The full script is available in `GlobalMart Queries. mysql`.

## 📜 Full SQL Implementation

```sql
---- creating a database
CREATE DATABASE GlobalMart;

----Use the Database
USE GlobalMart;

---- Creating tables for each CSV file
CREATE TABLE categories 
(
   categoryID INT,
   categoryName VARCHAR(50),
   categoryDescription TEXT
);

---- creating table for customers
CREATE TABLE customers
(
   customerID VARCHAR(50),
   companyName VARCHAR(100),
   contactName VARCHAR(50),
   contactTitle VARCHAR(50),
   city VARCHAR(50),
   country VARCHAR(50)
);

----creating table for employees
CREATE TABLE employees
(
   employeeID INT PRIMARY KEY,
   employeeName VARCHAR(50),
   employeeTitle VARCHAR(50),
   city VARCHAR(50),
   country VARCHAR(50)
);

---- creating table for order details
CREATE TABLE order_details
(
   orderID INT,
   productID INT,
   unitPrice DECIMAL(10,2),
   quantity INT,
   discount FLOAT
);

---- creating table for orders
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

---- creating table for product
CREATE TABLE product
(
   productID INT PRIMARY KEY,
   productName VARCHAR(50),
   quantityPerUnit INT,
   unitPrice DECIMAL(10,2),
   discontinued INT,
   categoryID INT
);

----creating table for shippers
CREATE TABLE shippers
(
   shipperID INT PRIMARY KEY,
   companyName VARCHAR(50)
);

---- Manually import the categories table
INSERT INTO categories VALUES
(1,'beverages','Soft drinks, coffees, teas, beers, and ales'),
(1,'Beverages',' Soft drinks, coffees, teas, beers, and ales'),
(3,'CONFECTIONS','Desserts, candies, and sweet breads'),
(4,' Dairy Products','Cheeses'),
(5,'Grains & Cereals','Breads, crackers, pasta, and cereal'),
(6,' Meat & Poultry','Prepared meats'),
(7,'PRODUCE',' Dried fruit and bean curd'),
(8,'SEAFOOD',' Seaweed and fish');

---- Checking the categories table
SELECT *
FROM categories;

---- Creating backup tables
CREATE TABLE categories_backup AS SELECT * FROM categories;
CREATE TABLE customers_backup AS SELECT * FROM customers;
CREATE TABLE employees_backup AS SELECT * FROM employees;
CREATE TABLE order_details_backup AS SELECT * FROM order_details;
CREATE TABLE orders_backup AS SELECT * FROM orders;
CREATE TABLE product_backup AS SELECT * FROM product;
CREATE TABLE shippers_backup AS SELECT * FROM shippers;

---- Adding composite primary key
ALTER TABLE order_details
ADD PRIMARY KEY (orderID, productID);

---- selecting 500 Rows
SELECT *
FROM order_details
LIMIT 500;

---- Data Cleaning
SET sql_safe_updates = 0;

UPDATE customers
SET
    customerID  = TRIM(UPPER(customerID)),
    companyName = TRIM(UPPER(companyName)),
    contactName = TRIM(UPPER(contactName)),
    contactTitle = TRIM(UPPER(contactTitle)),
    city = TRIM(UPPER(city)),
    country = TRIM(UPPER(country));

UPDATE employees
SET
    employeeName = TRIM(UPPER(employeeName)),
    employeeTitle = TRIM(UPPER(employeeTitle)),
    city = TRIM(UPPER(city)),
    country = TRIM(UPPER(country));

UPDATE orders
SET customerID = TRIM(UPPER(customerID));

UPDATE product
SET productName = TRIM(UPPER(productName));

UPDATE shippers
SET companyName = TRIM(UPPER(companyName));

---- Identify duplicates
SELECT categoryID, COUNT(*)
FROM categories
GROUP BY categoryID
HAVING COUNT(*) > 1;

---- Create cleaned categories table
CREATE TABLE categories_cleaned AS
SELECT DISTINCT
    categoryID,
    TRIM(UPPER(categoryName)) AS categoryName,
    TRIM(categoryDescription) AS categoryDescription
FROM categories;

---- Check cleaned table
SELECT *
FROM categories_cleaned;

---- Retrieve products under order 10252
SELECT orderID, productID
FROM order_details
WHERE orderID = 10252;
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

All query outputs are available in the **screenshots/** folder in this repository.

If you prefer viewing them online, access them here:

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


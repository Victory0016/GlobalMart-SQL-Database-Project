# Q1. creating a database
create database GlobalMart;

#Q2. Use the Database
use GlobalMart;

# Q3.  Creating tables for each CSV file
create table categories 
(
   categoryID int,
   categoryName varchar (50),
   categoryDescription text
   );
   
   # Q4. creating table for customers
   create table customers
   (
   customerID varchar(50),
   companyName varchar(100),
   contactName varchar(50),
   contactTitle varchar(50),
   city varchar(50),
   country varchar(50)
   );
   
   # Q5. creating table for employees
   create table employees
   (
     employeeID int primary key,
     employeeName varchar(50),
     employeeTitle varchar(50),
     city varchar(50),
     country varchar(50)
     );
     
    # Q6. creating table for order details
   create table order_details
    (
       orderID int,
       productID int,
       unitPrice decimal (10,2),
       quantity int,
       discount float
	);
       
       # Q7. creating table for orders
       create table orders
       (
       orderID int primary key,
       customerID varchar(50),
       employeeID int,
       orderDate date,
       requiredDate date,
       shippedDate date,
       shipperID int,
       freight decimal(10,2)
       );
      
	
       # Q8. creating table for product
       create table  product
       (
          productID int primary key,
          productName varchar(50),
          quantityPerUnit int,
          unitPrice decimal(10,2),
          discontinued int,
          categoryID int
          );
          
          # Q9. creating table for shippers
          create table shippers
          (
          shipperID int primary key,
          companyName varchar(50)
          );

# Q10. Manually import the categories table
INSERT INTO categories 
VALUES
(1,'beverages','Soft drinks, coffees, teas, beers, and ales'),
(1,'Beverages',' Soft drinks, coffees, teas, beers, and ales'),
(3,'CONFECTIONS','Desserts, candies, and sweet breads'),
(4,' Dairy Products','Cheeses'),
(5,'Grains & Cereals','Breads, crackers, pasta, and cereal'),
(6,' Meat & Poultry','Prepared meats'),
(7,'PRODUCE',' Dried fruit and bean curd'),
(8,'SEAFOOD',' Seaweed and fish');

# Q11. Checking the categories table if it was successfully imported manually 
select*
from categories;

# Q12. Creating  backup table for each table
create table categories_backup as
select *from categories;
#Q13. Backup for customer table 
create table customers_backup as
select * from customers;

#Q14. Backup for employees table 
create table employees_backup as
select * from employees;

#Q15. Backup for order_details table
create table order_details_backup as
select * from order_details;

#Q16. Backup for orders table 
create table orders_backup as 
select * from orders;

#Q17. Backup for product table 
create table product_backup as
select * from product;

#Q18. Backup for shippers table 
create table shippers_backup as
select * from shippers;

#Q19. Adding primary key using alter table for the order_details
ALTER TABLE order_details
ADD PRIMARY KEY (orderID, productID);

# Q20. selecting 500 Rows from order_details
select*
from order_details
limit 500;

#Data Cleaning for All Tables

# Q21. Removing unwanted space from the customers table 
set sql_safe_updates = 0;
update customers
set
    customerID  = TRIM(customerID),
	companyName = TRIM(companyName),
    contactName = TRIM(contactName),
    contactTitle = TRIM(contactTitle),
    city = TRIM(city),
    country = TRIM(country);
    
    # Q22: Standardize Text for the customers table
    set sql_safe_updates = 0;
    update customers
    set
	customerID  = upper(customerID),
	companyName = upper(companyName),
    contactName = upper(contactName),
    contactTitle = upper(contactTitle),
    city = upper(city),
    country = upper(country);
    
  # Q23. Removing unwanted space and standardizing the text for employees table
  set sql_safe_updates = 0;
  update employees
  set
  employeeName =trim(upper(employeeName)),
  employeeTitle	=trim(upper(employeeTitle)),
  city =trim(upper(city)),
  country =trim(upper(country));

# Q24. Removing unwanted space and standardaring text for orders table
set sql_safe_updates = 0;
update orders
set
customerID = trim(upper(customerID));

# Q25. Removing unwanted space and standardaring text for product table
set sql_safe_updates = 0;
update product
set
productName = trim(upper(productName));

# Q26. Removing unwanted space and standardaring text for shippers table
set sql_safe_updates = 0;
update shippers
set
companyName = trim(upper(companyName));

# Q27. Identifying if there is a duplicates in the categories table
select categoryID, COUNT(*) 
from categories
group by categoryID
having COUNT(*) > 1;

# Q28. creating a clean categories table
create table categories_cleaned AS
select distinct
    categoryID,
    TRIM(UPPER(categoryName)) AS categoryName,
    TRIM(categoryDescription) AS categoryDescription
From categories;

# Q29. checking the Cleaned Table
Select * 
from categories_cleaned;

# Q30. selecting orderID & productID where orderID = 10252
select orderID, productID
from order_details
where orderID = 10252;


----# From the Categories Table
# Q31. Retrieve all details of the Beverages category
SELECT *
FROM categories_cleaned
WHERE categoryName = 'BEVERAGES';

#Q32. Retrieve all categories except Beverages
SELECT *
FROM categories_cleaned
WHERE categoryName <> 'BEVERAGES';

# Q33. List all categories sorted by categoryID in descending order
SELECT *
FROM categories_cleaned
ORDER BY categoryID DESC;

# Q34. List all categories sorted by categoryID in ascending order
SELECT *
FROM categories_cleaned
ORDER BY categoryID ASC;

---# from the Product Table
# Q35. Count the total number of products available
SELECT COUNT(*) AS total_products
FROM product;

# Q36. Find the highest (maximum) product price
SELECT MAX(unitPrice) AS highest_price
FROM product;

# Q37. Find the lowest(minimum) product price
SELECT MIN(unitPrice) AS lowest_price
FROM product;

# Q38. List the top 5 most expensive products
SELECT productName, unitPrice
FROM product
ORDER BY unitPrice DESC
LIMIT 5;

# Q39. List the bottom 5 cheapest products
SELECT productName, unitPrice
FROM product
ORDER BY unitPrice ASC
LIMIT 5;

# Q40. Calculate the average product price (rounded to 2 decimals)
SELECT ROUND(AVG(unitPrice), 2) AS average_price
FROM product;


# Q41. Find the sum of the quantity of all products
SELECT SUM(quantityPerUnit) AS total_quantity 
FROM product;

--- # From the Order Details Table
# Q42.  Calculate the sales amount of each order item before the discount
SELECT *,
(unitPrice * quantity) AS sales_before_discount
FROM order_details;

# Q43.  Calculate the discount amount for each order item
SELECT *,
round(unitPrice * quantity * discount,2) AS discount_amount
FROM order_details;

# Q44.  Calculate the sales amount  of each order item after the discount
SELECT *,
round((unitPrice * quantity) - (unitPrice * quantity * discount), 2) AS sales_after_discount
FROM order_details; 

# Q45. Save all calculated business metrics into a new summary table
CREATE TABLE sales_summary AS
SELECT *,
(unitPrice * quantity) AS sales_before_discount,
round(unitPrice * quantity * discount,2) AS discount_amount,
round((unitPrice * quantity) - (unitPrice * quantity * discount), 2) AS sales_after_discount
FROM order_details;


# Q46. Check the new summary table
select *
from sales_summary
limit 10;

# Q47. List customer names and their order dates (only customers with orders)
SELECT c.customerID, c.contactName, o.orderID, o.orderDate
FROM customers as c
INNER JOIN orders as o
ON c.customerID = o.customerID;

# Q48. List all customers and their order dates including those without orders
SELECT c.customerID, c.contactName, o.orderDate
FROM customers as c
LEFT JOIN orders as o
ON c.customerID = o.customerID;

# Q49. List all orders with customer information including unmatched orders
SELECT c.customerID, c.contactName,  o.orderID, o.orderDate
FROM customers as c
RIGHT JOIN orders as o
ON c.customerID = o.customerID;

# Q50. List all customers and all orders including: Customers who have not placed any orders and Orders that do not have matching customer information
SELECT c.contactName, o.orderID, o.orderDate
FROM customers as c
LEFT JOIN orders as o
ON c.customerID = o.customerID
UNION
SELECT c.contactName, o.orderID, o.orderDate
FROM customers as c
RIGHT JOIN orders as o
ON c.customerID = o.customerID;

# Q51. List all the customers who have placed at least one order
SELECT *
FROM customers
WHERE customerID 
IN(
    SELECT DISTINCT customerID
    FROM orders
);

# Q52. List all customers who have placed 20 or more orders
SELECT *
FROM customers
WHERE customerID
 IN(
    SELECT customerID
    FROM orders
    GROUP BY customerID
    HAVING COUNT(orderID) >= 20
); 

# Q53. List all products that are above the average unit price
SELECT *
FROM product
WHERE unitPrice >
(
    SELECT AVG(unitPrice)
    FROM product
);

# Q54. Retrieve customers who placed at least one order after '2015-04-30'
SELECT *
FROM customers
WHERE customerID 
IN(
    SELECT customerID
    FROM orders
    WHERE orderDate > '2015-04-30'
);

# Q55. Retrieve customers who placed at least one order before '2015-04-30'
SELECT *
FROM customers
WHERE customerID 
IN(
    SELECT customerID
    FROM orders
    WHERE orderDate < '2015-04-30'
);

# Q56. Retrieve customers who placed an order between '2015-04-01' and '2015-04-03'
SELECT *
FROM customers
WHERE customerID 
IN(
    SELECT customerID
    FROM orders
    WHERE orderDate BETWEEN '2015-04-01' AND '2015-04-03'
);

# Q57. Retrieve customers who placed an order between '2015-05-01' and '2015-05-10'
SELECT *
FROM customers
WHERE customerID 
IN(
    SELECT customerID
    FROM orders
    WHERE orderDate BETWEEN '2015-05-01' AND '2015-05-10'
);

# Q58. Retrieve the country, contact name, and company name of customers who have at least one order with freight greater than 800
SELECT country, contactName, companyName
FROM customers
WHERE customerID 
IN(
    SELECT customerID
    FROM orders
    WHERE freight > 800
);

#Q59.  Using the order details calulated table, create a row_number using orderID column.
SELECT *,
ROW_NUMBER() OVER(order by orderID) AS row_num
FROM sales_summary;

#Q60. For each orderID, assign a row number and order by the salesAmountBeforeDiscount in descending order.
SELECT*,
ROW_NUMBER() OVER(PARTITION BY orderID ORDER BY sales_before_discount DESC) AS row_num
FROM sales_summary;

#Q61.Rank the sales amount before after discount in descending order, skip the tie.
SELECT*,
RANK() OVER(ORDER BY sales_before_discount DESC) AS sales_rank
FROM sales_summary;

#Q62. Rank the sales amount after discount for each order in descending order, skip the tie.
SELECT *,
RANK() OVER(PARTITION BY orderID ORDER BY sales_after_discount DESC) AS rank_per_order
FROM sales_summary;

#Q63. Rank the sales amount after discount in descending order, even if there is a tie.
SELECT*,
DENSE_RANK() OVER(ORDER BY sales_after_discount DESC) AS dense_rank_value
FROM sales_summary;

#Q64. Using window function, sum the quantity for each orders (orderID). i.e display the values across rows, no grouping
SELECT*, 
SUM(quantity) OVER(PARTITION BY orderID) AS total_quantity_per_order
FROM order_details;

#Q65.Categorize Sales
SELECT*,
CASE 
	WHEN sales_after_discount <= 500 THEN 'Low Sales'
	WHEN sales_after_discount <= 1000 THEN 'Medium Sales'
	ELSE 'High Sales'
    END AS sales_category
FROM sales_summary;

#Q66. Categorize discontinued
SELECT*,
  CASE 
	WHEN discontinued = 1 THEN 'Yes'
	WHEN discontinued = 0 THEN 'No'
    END AS discontinued_status
FROM product;

#Q67. Write a CTE to show all order freight above 70.
WITH high_freight_orders AS (
    SELECT *
    FROM orders
    WHERE freight > 70
)
SELECT *
FROM high_freight_orders;

#Q68. Using the above result, show the customers details of the order with freight above 70
WITH high_freight_orders AS
    (SELECT *
    FROM orders
    WHERE freight > 70)
SELECT*
FROM high_freight_orders h
JOIN customers c
ON h.customerID = c.customerID;

#Q69. Write a CTE to calculate the sales amount before discount, then show the product name for each purchase. 
WITH sales_calc AS 
  (SELECT*,
  od.unitPrice * od.quantity AS sales_before_discount
  FROM order_details od)
SELECT *
FROM sales_calc s
JOIN product p
ON s.productID = p.productID;





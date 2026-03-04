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





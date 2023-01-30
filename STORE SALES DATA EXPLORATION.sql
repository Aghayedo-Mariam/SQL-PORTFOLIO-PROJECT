 /*
 Data Exploraton
 Data File or scripts derived from MoshHamedani
 Exploring three dataset tables and also joining these tables
 -- Customers Table
 -- Products Table
 -- Orders Table
 -- Order_items Table
 -- Shippers Table
 -- Order_Statuses Table
 -- Order_item_notes Table
 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Creating Views, Converting Data Types

-- View The DataSet */

Select *
From customers;

Select *
From customers
Where phone is null;

Select first_name, last_name, phone, city
From customers
Where phone is  not null
Order by 1,2;


-- Get the customers whose
-- Whose addresses contain TRAIL or AVENUE 

Select *
from customers 
where address like '%trail%' or 
	  address like '%avenue%';
      
      
 -- Get the top three loyal customers
 
 Select *
 From customers
 order by points desc
 limit 3;
      
      
-- Return all data from orders table in descending order by their first name

Select *
From orders
order by first_name desc;


-- Return all the products  name, unit_price and new_price(unit_price * 1.1)

Select name, unit_price, unit_price * 1.1 AS new_price
From products;


-- Return products where quantity in stock is greater than 40

Select *
From products 
where quantity_in_stock > 40;


-- Return products with 
-- Quantity in stock equal to 49, 38, 72

Select *
From products
Where quantity_in_stock in (49, 38, 72);


-- From the orders table, get the order_id, shipper_id, shipped_date

Select order_id, shipper_id, shipped_date
from orders;


-- Get the orders that are not shipped

Select *
From orders 
where shipper_id is null;


-- Putting Two tables together OR Joining collums from multiple tables
-- The customers and orders table

Select *
from customers
join orders
  ON customers.customer_id = orders.customer_id;


-- Joining multiple tables
-- use of (outer joins) customer id, first name, order id

Select
	c.customer_id,
    c.first_name,
    o.order_id
From customers c
Join orders o
    ON c.customer_id = o.customer_id
order by c.customer_id ;


-- Joining Two OR More Tables

Select
	o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shippeer
From orders o
Join customers c
    ON o.customer_id = c.customer_id
Join shippers sh
	ON o.shipper_id = sh.shipper_id;
    
    
 -- Query for all orders that have been shipped and Joining the order_statuses table   
 
 Select 
     o.order_id,
     o.order_date,
     c.first_name AS customer,
     sh.name AS shipper
From orders o 
Join customers c 
   ON o.customer_id = c.customer_id
Left Join shippers sh 
   ON o.shipper_id = sh.shipper_id
Join order_statuses os
  ON o.status = os.order_status_id;
  
  
  -- Do a cross join between shppers and products
  -- Using the implicit syntax
  -- and then using the explicit syntax

-- Implicit Syntax

Select
    sh.name AS shipper,
    p.name AS product
From shippers sh, products p 
order by shipper.name;

-- Explicit Syntax

Select 
     sh.name AS shipper,
     p.name AS prodiuct
From shippers sh 
Cross Join product p 
order by shipper.name;


-- Combining Records for multiple query
-- UNION

Select  
   order_id,
   order_date,
   'Active' AS Status
From orders
Where order_date >= '2019-01-01'
UNION
Select 
    order_id,
    order_date
    'Archieved' 
From orders 
Where order_date < '2019-01-01';


-- Inserting Of Data
-- Inserting six rows into the customers table

Insert Into customers (
       first_name,
       last_name,
       birth_date,
       address,
       city,
       state)
Values (
    'John',
    'Smith',
    '1990-01-01',
    '6a Afromedia',
    'Cali',
    'LA');


-- Copying of data from one table to another
-- Creating a copy of another table
-- Create a new Table ie Orders Archived

Create Table orders_archived AS
select*
From orders;


-- Updating Of Data

Update customers
set phone = 444-323-70, points = 6590
where customer_id = 5;

 


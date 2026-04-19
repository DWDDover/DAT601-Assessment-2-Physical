USE MASTER;
go
DROP DATABASE IF EXISTS business_database;
go
CREATE DATABASE business_database;
go
USE business_database;

	DROP TABLE IF EXISTS Customer;

	CREATE TABLE Customer
	(
		CustID		CHAR(10)	NOT NULL,
		CustName	CHAR(50)	NOT NULL,
		CustAddress	CHAR(50)	,
		CustCity	CHAR(50)	,
		CustContact	CHAR(50)	,
		CustPhone	CHAR(15)	,
		CustEmail	CHAR(255)	,
		PRIMARY KEY (CustID)
	);

	DROP TABLE IF EXISTS OrderEntry;

	CREATE TABLE OrderEntry
	(
		OrderID		INTEGER		NOT NULL,
		OrderDate	DATETIME	NOT NULL,
		CustID		CHAR(10)	NOT NULL,
		PRIMARY KEY (OrderID)
	);

	DROP TABLE IF EXISTS Vendor;

	CREATE TABLE Vendor
	(
		VendorID		CHAR(10)	NOT NULL,
		VendorName		CHAR(50)	NOT NULL,
		VendorAddress	CHAR(50)	,
		VendorCity		CHAR(50)	,
		VendorPhone		CHAR(15)	,
		PRIMARY KEY (VendorID)
	);

	DROP TABLE IF EXISTS OrderItem;

	CREATE TABLE OrderItem
	(
		OrderID		INTEGER		NOT NULL,
		OrderItem	INTEGER		NOT NULL,
		ProductID	CHAR(10)	NOT NULL,
		Quantity	INTEGER		NOT NULL,
		ItemPrice	DECIMAL(8,2)NOT NULL,
		PRIMARY KEY (OrderID, OrderItem)
	);

	DROP TABLE IF EXISTS Product;

	CREATE TABLE Product
	(
		ProductID		CHAR(10)	NOT NULL,
		VendorID		CHAR(10)	NOT NULL,
		ProductName		CHAR(255)	NOT NULL,
		ProductPrice	DECIMAL(8,2)NOT NULL,
		ProductDesc		VARCHAR(100)		,
		PRIMARY KEY (ProductID)
	);

	INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
	VALUES('1000000001','Village Toys','200 Oak Lane','Wellington','09-389-2356','John Smith','sales@villagetoys.co.nz');

	INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact)
	VALUES('1000000002','Kids Place','333 Tahunanui Drive','Nelson','03-545-6333','Michelle Green');

	INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
	VALUES('1000000003','Fun4All','1 Sunny Place','Nelson','03-548-2285','Jim Jones','jjones@fun4all.co.nz');

	INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
	VALUES('1000000004','Fun4All','829 Queen Street','Auckland','09-368-7894','Denise L. Stephens','dstephens@fun4all.co.nz');

	INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact)
	VALUES('1000000005','The Toy Store','50 Papanui Road','Christchurch','04-345-4545','Kim Howard');


	INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
	VALUES(20005,'1999/5/1','1000000001');

	INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
	VALUES(20006,'1999/1/12','1000000003');

	INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
	VALUES(20007,'1999/1/30','1000000004');

	INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
	VALUES(20008,'1999/2/3','1000000005');

	INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
	VALUES(20009, '1999/2/8','1000000001');


	INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
	VALUES('BRS01','Bears R Us','123 Main Street','Richmond','03-523-8871');

	INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
	VALUES('BRE02','Bear Emporium','500 Park Street','Auckland','06-396-8854');

	INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
	VALUES('DLL01','Doll House Inc.','555 High Street','Motueka','03-455-7898');

	INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
	VALUES('FRB01','Furball Inc.','1 Clifford Avenue','Nelson','03-546-9978');


	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20005,1,'BR01',100,5.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20005,2,'BR03',100,10.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20006,1,'BR01',20,5.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20006,2,'BR02',10,8.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20006,3,'BR03',10,11.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20007,1,'BR03',50,11.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20007,2,'BNBG01',100,2.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20007,3,'BNBG02',100,2.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20007,4,'BNBG03',100,2.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20007,5,'RGAN01',50,4.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20008,1,'RGAN01',5,4.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20008,2,'BR03',5,11.99);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20008,3,'BNBG01',10,3.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20008,4,'BNBG02',10,3.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20008,5,'BNBG03',10,3.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20009,1,'BNBG01',250,2.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20009,2,'BNBG02',250,2.49);

	INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
	VALUES(20009,3,'BNBG03',250,2.49);


	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BR01', 'BRS01', '8 inch teddy bear',5.99,'8 inch teddy bear, comes with cap and jacket');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BR02', 'BRS01', '12 inch teddy bear',8.99,'12 inch teddy bear, comes with cap and jacket');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BR03', 'BRS01', '18 inch teddy bear',11.99,'18 inch teddy bear, comes with cap and jacket');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BNBG01', 'DLL01', 'Fish bean bag toy',3.49,'Fish bean bag toy, complete with bean bag worms with which to feed it');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BNBG02', 'DLL01', 'Bird bean bag toy',3.49,'Bird bean bag toy, eggs are not included');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy',3.49,'Rabbit bean bag toy, comes with bean bag carrots');

	INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
	VALUES('RGAN01', 'DLL01', 'Raggedy Ann',4.99,'18 inch Raggedy Ann doll');


-- A. Adding Foreign Keys (10 Marks) 
-- The database does not contain any Foreign Key constraints
-- add all add the required Foreign Keys to your copy of the database using SQLServer SQL ALTER TABLE commands. 
-- Write an ALTER TABLE statement for each Foreign Key. 

ALTER TABLE OrderEntry
ADD CONSTRAINT fk_OrderEntry
FOREIGN KEY (CustID) REFERENCES Customer(CustID);

ALTER TABLE OrderItem
ADD CONSTRAINT fk_OrderItem
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
FOREIGN KEY (OrderID) REFERENCES OrderEntry(OrderID);

ALTER TABLE Product
ADD CONSTRAINT fk_product
FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID);

-- B. Using the installed small business database, write the following queries in SQLServer SQL. 
-- Each returned result must be in the same column order and have correct column names. (40 Marks)

-- 1. List all products not made by vendor DLL01 (WHERE, <>).

SELECT ProductID as ID, ProductName as Product
FROM Product
WHERE VendorID <> 'DLL01';

-- 2. List all products with a price between $5.00 and $10.00 (WHERE, BETWEEN).

Select ProductName as Name, ProductPrice as Price
from Product
Where ProductPrice BETWEEN 5.00 AND 10.00;

-- 3. List any products made by either vendor DLL01 or vendor BRS01 costing
-- $10.00 or greater (WHERE, OR, AND, order of evaluation using brackets)

Select ProductName as Name, ProductPrice as Price
from Product
Where ProductPrice > 10.00 AND (VendorID = 'DLL01' OR VendorID = 'BRS01');

-- 4. Return the average price of all the products in the products table (AVG)

SELECT AVG(ProductPrice) as AveragePrice
from Product;

-- 5. Return the total number of customers in the Customers table (COUTN(*), AS
-- result name

SELECT Count(*) as TotalCustomers
from Customer;

-- 6. Return the number of customers in the customers table with an email address
-- (COUNT(column name))

SELECT Count(CustEmail) as CustomersWithEmail
from Customer;

-- 7. Return the number of product types, minimum, maximum and average product price, 
-- from the products table.  

SELECT 
	Count(*) as ProductTypes, 
	Min(ProductPrice) as MinPrice, 
	Max(ProductPrice) as MaxPrice,
	Avg(ProductPrice) as AvgPrice
FROM Product;

-- 8. Joins: Return the vendor’s name, product price and product name from the 
-- vendors and products tables (JOIN or WHERE tablename.columnname, =).

SELECT v.VendorName, p.ProductName as Product, p.ProductPrice as Price
FROM Product p
INNER JOIN Vendor v
ON p.VendorID = v.VendorID;

-- 9. Return the product name, vendor name, product price and quantity for each 
-- item in order number 20007 (JOIN or WHERE tablename.columnname, =, AND) 

SELECT p.ProductName as Product, v.VendorName, p.ProductPrice as Price, o.Quantity
FROM Product p
INNER JOIN Vendor v
ON p.VendorID = v.VendorID
INNER JOIN OrderItem o
ON o.ProductID = p.ProductID
WHERE o.OrderID = '20007';

-- Sub Queries – For 10 to 11 use Sub Queries in a single SQL statement 

-- 10. Create a list of all the customers (customer name and customer contact) 
-- who ordered item RGAN01.

-- First break into steps:
-- Retrieve the order numbers of all orders containing item RGAN01. 
-- Retrieve the customer ID of all the customers who have orders listed in the order numbers returned in the previous step. 
-- Retrieve the customer information for all the customer IDs returned in the previous step. 
-- Work out each query then combine as nested sub queries. 

Select CustName, CustContact
from Customer
where CustID IN (
	Select CustID from OrderEntry where OrderID IN (
		Select OrderID from OrderItem where ProductID = 'RGAN01'));

-- 11. Display the total number of orders placed by every customer in the Customers table, 
-- as well as the city the customer is in 

-- Retrieve the list of customers from the customers table 
-- For each customer retrieved, count the number of associated orders in the Orders table

SELECT c.CustName as Name, c.CustCity as City, Count(o.OrderID) as OrdersPlaced
FROM OrderEntry o
RIGHT JOIN Customer c
on o.CustID = c.CustID
Group by c.CustID, c.CustName, c.CustCity
order by c.CustName asc;

-- 12. Create a report on all the customers in Nelson and Wellington.  
-- You also should include all Fun4All locations, regardless of city
-- The resulting customers should be in alphabetical order of customer 
-- name then customer contact (CTE, WHERE, IN(), UNION, ORDER BY).  

WITH CustNsnWgt AS (
	Select CustName, CustContact, CustEmail
	FROM Customer
	Where CustID IN (SELECT CustID where Custcity = 'Nelson' Or CustCity = 'Wellington')),
	CustFun4All AS (
		Select CustName, CustContact, CustEmail
		FROM Customer
		Where CustName = 'Fun4All')
select CustName, CustContact as Contact, CustEmail as Email From CustNsnWgt
UNION
select CustName, CustContact as Contact, CustEmail as Email From CustFun4All
order by CustName asc, CustContact asc;

-- Views

-- 13.  Read the following and write out the steps and tasks you expect to take. 
-- Think of this as a small job you’ve been given by your team leader. 
-- Complete and record your process and the results, both the DML and DDL as you 
-- undertake the following.

-- Create a view called vProductCustomer which joins 
-- the Customer, Order and OrderItem tables to return a list of all customers 
-- who have ordered any product (CREATE VIEW, AS). Now retrieve from that view a 
-- list of customers who ordered product RGAN01.

--First create a view with a row for each customer in the customer table that 
--has an order in the orderentry, that has an item in the orderItem table.
--Then add a new column to each row with the product ID which appears in 
--any orderitem entry in one of that customers orders.
--A new customer row will exist for each product they have in their orders.

DROP VIEW IF EXISTS vProductCustomer;
go
CREATE VIEW vProductCustomer AS
SELECT c.*, i.ProductID
FROM Customer c
INNER JOIN OrderEntry o
on o.CustID = c.CustID
INNER JOIN OrderItem i
ON o.OrderID = i.OrderID;
go

--Using the previously created view, customers that have any orders containing 
--a specified product ID can be selected. Grouping by customer name and customer contact
--prevents repeat rows

SELECT CustName as Name, CustContact as Contact from vProductCustomer
where ProductID = 'RGAN01'
GROUP BY CustName, CustContact;

-- 14. Read the following and write out the steps and tasks you expect to take. 
-- Think of this as a small job you’ve been given by your team leader. 
-- Complete and record your process and the results, both the DML and DDL as you 
-- undertake the following.

-- Use an INSERT statement to add a customer to the database: 

-- CustID = 1000000006 
-- CustName = <Your name> 
-- CustPhone = <0x-xxx-xxx , Your Phone> 
-- See below for the expected address and its format.  
-- Include your Insert statement in your on-going SQL SCRIPT.

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustContact,CustPhone,CustEmail)
VALUES('1000000006','ddover',NULL,NULL,'Declan Dover','02-238-8281','ddover@gmail.com');

-- Using a View to format mailing list data: 

-- First write and run a query that will display the customer’s name and then
-- the address in the following format – pay attention to the third column it 
-- has a specific format: 
-- CustName  Customer address City/town, Phone number 

SELECT CustName AS 'Name', CustAddress AS 'Address', TRIM(CustCity) + ', ' + TRIM(CustPhone) AS 'Phone and City'
FROM Customer;


-- Turn this query into a view called vCustomerMailingLabel 

DROP VIEW IF EXISTS vCustomerMailingLabel;
go
CREATE VIEW vCustomerMailingLabel AS
SELECT CustName AS 'Name', CustAddress AS 'Address', CONCAT(TRIM(CustCity), ', ', TRIM(CustPhone)) AS 'Phone and City'
FROM Customer;
go
SELECT *
FROM vCustomerMailingLabel;

-- Write query to display all the “entries” in vCustomerMailingLabel 
-- Finish by writing a View that provides customer mailing labels that filters 
-- out any incomplete addresses as these cannot be used for mailing labels. 

DROP VIEW IF EXISTS vCustomerMailingLabelFiltered;
go
CREATE VIEW vCustomerMailingLabelFiltered AS
SELECT CustName AS 'Name', CustAddress AS 'Address', CONCAT(TRIM(CustCity), ', ', TRIM(CustPhone)) AS 'Phone and City'
FROM Customer
WHERE (CustName IS NOT NULL) AND (CustAddress IS NOT NULL) AND (CustCity IS NOT NULL) AND (CustPhone IS NOT NULL);
go
SELECT *
FROM vCustomerMailingLabelFiltered;
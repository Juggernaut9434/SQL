-- working in a new database: TwoTrees
CREATE DATABASE two_trees_dbf3;

-- Create the Two Trees Database: 
-- make sure you're modifying two_trees and not master

----------------------------------------------------------
-- EMPTY THE TWO TREES DATABASE IN CASE IT CONTAINS CONTENT
----------------------------------------------------------

DROP TABLE IF EXISTS inventory.products;
DROP TABLE IF EXISTS inventory.categories;
DROP SCHEMA IF EXISTS inventory;
DROP TABLE IF EXISTS sales.order_lines;
DROP TABLE IF EXISTS sales.orders;
DROP TABLE IF EXISTS sales.customers;
DROP SCHEMA IF EXISTS sales;

-----------------------------------
-- CREATE THE TABLE STRUCTURE
-----------------------------------

-- Create the database schemas
GO -- comment this line out when running on PostgreSQL
CREATE SCHEMA inventory;
GO -- comment this line out when running on PostgreSQL
CREATE SCHEMA sales;
GO -- comment this line out when running on PostgreSQL


-- Create a table for the Two Trees category data
CREATE TABLE inventory.categories (
    category_id          INT NOT NULL PRIMARY KEY,
    category_description VARCHAR(50),
    product_line         VARCHAR(25)
);

-- Create a table for the Two Trees product data
CREATE TABLE inventory.products (
    sku             VARCHAR(7) NOT NULL PRIMARY KEY,
    product_name    VARCHAR(50) NOT NULL,
    category_id     INT,
    size            INT,
    price           DECIMAL(5,2) NOT NULL
);

ALTER TABLE inventory.products
ADD CONSTRAINT fk_products_category_id FOREIGN KEY (category_id)
    REFERENCES inventory.categories (category_id)
;

-- Create a table for the Two Trees customer data
CREATE TABLE sales.customers (
    customer_id CHAR(5) NOT NULL PRIMARY KEY,
    company     VARCHAR(100),
    address     VARCHAR(100),
    city        VARCHAR(50),
    state       CHAR(2),
    zip         CHAR(5)
);

-- Create a table for the Two Trees order data
CREATE TABLE sales.orders (
    order_id     INT IDENTITY(100,1) NOT NULL PRIMARY KEY, --PostgreSQL: use GENERATED ALWAYS AS IDENTITY (START WITH 100 INCREMENT BY 1)
    order_date   DATE,
    customer_id  CHAR(5)
);

ALTER TABLE sales.orders
ADD CONSTRAINT fk_customers_customer_id FOREIGN KEY (customer_id)
    REFERENCES sales.customers (customer_id)
;

-- Create a table for the order's line-item data
CREATE TABLE sales.order_lines (
    order_id    INT,
    line_id     INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    sku         VARCHAR(7),
    quantity    INT
);

ALTER TABLE sales.order_lines
ADD CONSTRAINT fk_orders_order_id FOREIGN KEY (order_id)
    REFERENCES sales.orders (order_id)
;


-----------------------------------
-- INSERT DATA INTO TABLES 
-----------------------------------

-- Add data to the categories table
INSERT INTO inventory.categories
    (category_id, category_description, product_line)
VALUES
    (1, 'Olive Oils', 'Gourmet Chef'),
    (2, 'Flavor Infused Oils', 'Gourmet Chef'),
    (3, 'Bath and Beauty', 'Cosmetics')
;

-- Add data to the customers table
INSERT INTO sales.customers VALUES
    ('FV418', 'Flavorville', '798 Ravinia Road', 'Des Moines', 'IA', '50320'),
    ('WR421', 'Wild Rose', '222 Dakota Lane', 'Kalamazoo', 'MI', '49001'),
    ('BX305', 'Bread Express', '3362 Ute Loop', 'Tiffin', 'OH', '44883'),
    ('BV446', 'Blue Vine', '40675 Raymond Curve', 'Columbus', 'GA', '31901'),
    ('GR208', 'Green Gardens', '394 Mesa Palms Avenue', 'Glen Campbell', 'PA', '15742'),
    ('DF600', 'Delish Food', '809 Weathersfield Ctr Park', 'Madisonville', 'OH', '45227')
;

-- Add data to the products table
INSERT INTO inventory.products
    (sku, product_name, category_id, size, price)
VALUES
    ('ALB008', 'Delicate', 1, 8, 10.99),
    ('ALB032', 'Delicate', 1, 32, 18.99),
    ('ALB064', 'Delicate', 1, 64, 22.99),
    ('ALB128', 'Delicate', 1, 128, 26.99),
    ('EV008', 'Extra Virgin', 1, 8, 8.99),
    ('EV016', 'Extra Virgin', 1, 16, 12.99),
    ('EV032', 'Extra Virgin', 1, 32, 16.99),
    ('EV064', 'Extra Virgin', 1, 64, 20.99),
    ('EV128', 'Extra Virgin', 1, 128, 24.99),
    ('FCP008', 'First Cold Press', 1, 8, 8.99),
    ('FCP016', 'First Cold Press', 1, 16, 12.99),
    ('FCP032', 'First Cold Press', 1, 32, 16.99),
    ('FCP064', 'First Cold Press', 1, 64, 20.99),
    ('FCP128', 'First Cold Press', 1, 128, 24.99),
    ('FR008', 'Frantoio', 1, 8, 10.99),
    ('FR016', 'Frantoio', 1, 16, 14.99),
    ('FR032', 'Frantoio', 1, 32, 18.99),
    ('FR064', 'Frantoio', 1, 64, 22.99),
    ('FR128', 'Frantoio', 1, 128, 26.99),
    ('HOJ008', 'Bold', 1, 8, 11.99),
    ('HOJ016', 'Bold', 1, 16, 15.99),
    ('HOJ032', 'Bold', 1, 32, 19.99),
    ('HOJ064', 'Bold', 1, 64, 23.99),
    ('HOJ128', 'Bold', 1, 128, 27.99),
    ('KRN008', 'Koroneiki', 1, 8, 10.99),
    ('KRN016', 'Koroneiki', 1, 16, 14.99),
    ('KRN032', 'Koroneiki', 1, 32, 18.99),
    ('KRN064', 'Koroneiki', 1, 64, 22.99),
    ('KRN128', 'Koroneiki', 1, 128, 26.99),
    ('LEC008', 'Leccino', 1, 8, 10.99),
    ('LEC016', 'Leccino', 1, 16, 14.99),
    ('LEC032', 'Leccino', 1, 32, 18.99),
    ('LEC064', 'Leccino', 1, 64, 22.99),
    ('LEC128', 'Leccino', 1, 128, 26.99),
    ('LGT008', 'Light', 1, 8, 8.99),
    ('LGT016', 'Light', 1, 16, 12.99),
    ('LGT032', 'Light', 1, 32, 16.99),
    ('LGT064', 'Light', 1, 64, 20.99),
    ('LGT128', 'Light', 1, 128, 24.99),
    ('MAN008', 'Manzanilla', 1, 8, 10.99),
    ('MAN016', 'Manzanilla', 1, 16, 14.99),
    ('MAN032', 'Manzanilla', 1, 32, 18.99),
    ('MAN064', 'Manzanilla', 1, 64, 22.99),
    ('MAN128', 'Manzanilla', 1, 128, 26.99),
    ('MIS008', 'Mission', 1, 8, 10.99),
    ('MIS016', 'Mission', 1, 16, 14.99),
    ('MIS032', 'Mission', 1, 32, 18.99),
    ('MIS064', 'Mission', 1, 64, 22.99),
    ('MIS128', 'Mission', 1, 128, 26.99),
    ('MOR008', 'Moraiolo', 1, 8, 10.99),
    ('MOR016', 'Moraiolo', 1, 16, 14.99),
    ('MOR032', 'Moraiolo', 1, 32, 18.99),
    ('MOR064', 'Moraiolo', 1, 64, 22.99),
    ('MOR128', 'Moraiolo', 1, 128, 26.99),
    ('OBL008', 'Oblica', 1, 8, 11.99),
    ('OBL016', 'Oblica', 1, 16, 15.99),
    ('OBL032', 'Oblica', 1, 32, 19.99),
    ('OBL064', 'Oblica', 1, 64, 22.99),
    ('OBL128', 'Oblica', 1, 128, 27.99),
    ('PEN008', 'Pendolino', 1, 8, 10.99),
    ('PEN016', 'Pendolino', 1, 16, 14.99),
    ('PEN032', 'Pendolino', 1, 32, 18.99),
    ('PEN064', 'Pendolino', 1, 64, 22.99),
    ('PEN128', 'Pendolino', 1, 128, 26.99),
    ('PCH008', 'Picholine', 1, 8, 11.99),
    ('PCH016', 'Picholine', 1, 16, 15.99),
    ('PCH032', 'Picholine', 1, 32, 19.99),
    ('PCH064', 'Picholine', 1, 64, 23.99),
    ('PCH128', 'Picholine', 1, 128, 27.99),
    ('PIC008', 'Picual', 1, 8, 10.99),
    ('PIC016', 'Picual', 1, 16, 14.99),
    ('PIC032', 'Picual', 1, 32, 18.99),
    ('PIC064', 'Picual', 1, 64, 22.99),
    ('PIC128', 'Picual', 1, 128, 26.99),
    ('PUR008', 'Pure', 1, 8, 8.99),
    ('PUR016', 'Pure', 1, 16, 12.99),
    ('PUR032', 'Pure', 1, 32, 16.99),
    ('PUR064', 'Pure', 1, 64, 20.99),
    ('PUR128', 'Pure', 1, 128, 24.99),
    ('REF008', 'Refined', 1, 8, 8.99),
    ('REF016', 'Refined', 1, 16, 12.99),
    ('REF032', 'Refined', 1, 32, 16.99),
    ('REF064', 'Refined', 1, 64, 20.99),
    ('REF128', 'Refined', 1, 128, 24.99),
    ('V008', 'Virgin', 1, 8, 8.99),
    ('V016', 'Virgin', 1, 16, 12.99),
    ('V032', 'Virgin', 1, 32, 16.99),
    ('V064', 'Virgin', 1, 64, 20.99),
    ('V128', 'Virgin', 1, 128, 24.99),
    ('MI008', 'Mandarin-Infused EVO', 2, 8, 8.99),
    ('MI016', 'Mandarin-Infused EVO', 2, 16, 12.99),
    ('MI032', 'Mandarin-Infused EVO', 2, 32, 16.99),
    ('LI008', 'Lemon-Infused EVO', 2, 8, 8.99),
    ('LI016', 'Lemon-Infused EVO', 2, 16, 12.99),
    ('LI032', 'Lemon-Infused EVO', 2, 32, 16.99),
    ('BI008', 'Basil-Infused EVO', 2, 8, 10.99),
    ('BI016', 'Basil-Infused EVO', 2, 16, 14.99),
    ('BI032', 'Basil-Infused EVO', 2, 32, 18.99),
    ('RI008', 'Rosemary-Infused EVO', 2, 8, 10.99),
    ('RI016', 'Rosemary-Infused EVO', 2, 16, 14.99),
    ('RI032', 'Rosemary-Infused EVO', 2, 32, 18.99),
    ('GI008', 'Garlic-Infused EVO', 2, 8, 11.99),
    ('GI016', 'Garlic-Infused EVO', 2, 16, 15.99),
    ('GI032', 'Garlic-Infused EVO', 2, 32, 19.99),
    ('JI008', 'Chili-Infused EVO', 2, 8, 11.99),
    ('JI016', 'Chili-Infused EVO', 2, 16, 15.99),
    ('JI032', 'Chili-Infused EVO', 2, 32, 19.99),
    ('OGEC004', 'Olive Glow eye cream', 3, 4, 18.99),
    ('OGFL006', 'Olive Glow face lotion', 3, 6, 14.99),
    ('OGBL012', 'Olive Glow body lotion', 3, 12, 12.99),
    ('OGFT006', 'Olive Glow foot treatment', 3, 6, 7.99),
    ('OGNR004', 'Olive Glow night repair', 3, 4, 21.99),
    ('OGBG016', 'Olive Glow bath gel', 3, 16, 9.99),
    ('OGHS006', 'Olive Glow hand soap', 3, 6, 6.99)
;

-- Add data to the orders table
INSERT INTO sales.orders (order_date, customer_id) VALUES
    ('2020-10-15', 'BX305'),
    ('2020-10-17', 'GR208'),
    ('2020-10-19', 'BV446'),
    ('2020-10-19', 'BV446'),
    ('2020-10-20', 'FV418'),
    ('2020-10-21', 'DF600'),
    ('2020-10-22', 'FV418'),
    ('2020-10-23', 'WR421'),
    ('2020-10-24', 'WR421'),
    ('2020-10-25', 'GR208'),
    ('2020-10-25', 'BX305'),
    ('2020-10-26', 'GR208'),
    ('2020-10-26', 'BV446'),
    ('2020-10-27', 'FV418'),
    ('2020-10-28', 'WR421'),
    ('2020-10-28', 'BV446'),
    ('2020-10-28', 'DF600'),
    ('2020-10-29', 'DF600'),
    ('2020-10-29', 'BX305'),
    ('2020-10-30', 'GR208'),
    ('2020-10-31', 'BX305')
;

-- Add data to the order_lines table
INSERT INTO sales.order_lines (order_id, sku, quantity) VALUES
    (100, 'HOJ016', 2),
    (101, 'MAN128', 2),
    (101, 'MIS032', 1),
    (101, 'PEN008', 1),
    (101, 'RI016', 1),
    (102, 'FCP128', 2),
    (102, 'FCP128', 3),
    (102, 'LGT016', 3),
    (102, 'MIS064', 1),
    (102, 'OBL008', 3),
    (103, 'FCP016', 4),
    (104, 'MIS016', 1),
    (105, 'HOJ128', 2),
    (105, 'KRN128', 4),
    (105, 'LEC008', 4),
    (106, 'JI032', 1),
    (106, 'MOR032', 2),
    (106, 'PIC016', 1),
    (106, 'RI032', 4),
    (107, 'LI016', 3),
    (107, 'PIC008', 4),
    (107, 'PIC064', 3),
    (107, 'V032', 4),
    (108, 'FCP008', 4),
    (108, 'RI008', 1),
    (109, 'EV008', 3),
    (109, 'OBL128', 2),
    (110, 'FCP008', 5),
    (110, 'LGT008', 3),
    (110, 'PUR016', 4),
    (110, 'V064', 1),
    (111, 'KRN128', 3),
    (112, 'JI032', 3),
    (112, 'OBL128', 1),
    (112, 'PCH032', 4),
    (113, 'HOJ008', 2),
    (113, 'PUR064', 2),
    (113, 'PUR128', 3),
    (113, 'REF008', 3),
    (114, 'EV128', 5),
    (115, 'FR128', 5),
    (115, 'PCH064', 4),
    (115, 'PUR064', 4),
    (116, 'FCP128', 2),
    (116, 'PEN064', 4),
    (117, 'ALB064', 3),
    (117, 'ALB128', 2),
    (117, 'GI032', 4),
    (117, 'HOJ064', 2),
    (117, 'JI016', 1),
    (117, 'PIC016', 4),
    (118, 'FR008', 2),
    (118, 'PIC016', 2),
    (118, 'REF008', 2),
    (119, 'JI016', 3),
    (119, 'MI008', 3),
    (120, 'BI008', 4),
    (120, 'EV032', 4),
    (120, 'FR064', 1),
    (120, 'PEN032', 2)
;



-------------------------------------
-- REVIEW THE DATA THATS BEEN ENTERED
-------------------------------------

SELECT * FROM inventory.categories;
SELECT * FROM inventory.products;
SELECT * FROM sales.customers;
SELECT * FROM sales.orders;
SELECT * FROM sales.order_lines;


-- View Query below
GO
CREATE VIEW sales.order_details AS
SELECT 
    orders.order_id,
    order_lines.line_id,
    customers.customer_id,
    customers.company,
    orders.order_date,
    order_lines.sku,
    order_lines.quantity,
    products.product_name,
    products.size,
    products.price
FROM sales.customers
    JOIN sales.orders ON customers.customer_id = orders.customer_id
    JOIN sales.order_lines ON orders.order_id = order_lines.order_id
    JOIN inventory.products ON order_lines.sku = products.sku
;
GO

-- DELETE a view with `DROP VIEW view_name;`

-- query the new view
SELECT * FROM sales.order_details;

SELECT * FROM sales.order_details
WHERE order_id = 105;

-- when you rename a column in a table,
-- the view auto updates by using a `AS`
-- to not break any naming refactoring
-- only in postgres,
-- b/c this is SQL server
-- the view has to be dropped and recreated

-- renamed
EXEC sp_rename 'sales.customers.company', 'company_name', 'COLUMN';
-- fix the view
DROP VIEW sales.order_details;

GO
CREATE VIEW sales.order_details AS
SELECT 
    orders.order_id,
    order_lines.line_id,
    customers.customer_id,
    customers.company_name,
    orders.order_date,
    order_lines.sku,
    order_lines.quantity,
    products.product_name,
    products.size,
    products.price
FROM sales.customers
    JOIN sales.orders ON customers.customer_id = orders.customer_id
    JOIN sales.order_lines ON orders.order_id = order_lines.order_id
    JOIN inventory.products ON order_lines.sku = products.sku
;
GO

-- challenge 1.1: aggregate data of number of orders by company

-- solution by me
SELECT 
    company_name,
    COUNT(order_id) as "number of orders"
FROM sales.order_details
GROUP BY company_name;
-- solution by tutorial
GO
CREATE VIEW sales.order_counts AS
SELECT
    customers.company_name,
    COUNT(orders.order_id) as total_orders
FROM sales.orders
    JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY company_name;
GO

SELECT * FROM sales.order_counts
ORDER BY total_orders DESC;
-- challenge 1.2: Multiply quantity of product ordered by its price for each order line

-- solution by me
SELECT
    line_id,
    quantity * price AS "total price"
FROM sales.order_details;

-- solution by tutorial
GO
CREATE VIEW sales.total_price AS
SELECT 
    order_lines.line_id,
    order_lines.quantity * products.price AS line_total_price
FROM sales.order_lines
    JOIN inventory.products ON order_lines.sku = products.sku
;
GO

SELECT * FROM sales.total_price;

SELECT * FROM sales.order_details
    JOIN sales.total_price 
    ON order_details.line_id = total_price.line_id;

-- exec plans
-- View the execution plan for a query
-- SQL Server uses a toolbar button to display query plans
-- PostgreSQL uses the EXPLAIN command to show plans

-- EXPLAIN (ANALYZE)  -- PostgreSQL only. Omit for SQL Server
SELECT 
    orders.customer_id,
    customers.company_name,
    COUNT(orders.order_id) AS number_of_orders,
    SUM(order_lines.quantity * products.price) AS customer_total_spend
FROM sales.order_lines
    JOIN inventory.products ON order_lines.sku = products.sku
    JOIN sales.orders ON order_lines.order_id = orders.order_id
    JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.company_name;

-- run the above and press "Explain" on the tool bar in the Azure Data Studio
-- or similar

-- HINTS
-- Execute a query with no hints
SELECT 
    orders.customer_id,
    customers.company_name,
    COUNT(orders.order_id) AS number_of_orders,
    SUM(order_lines.quantity * products.price) AS customer_total_spend
FROM sales.order_lines
    JOIN inventory.products ON order_lines.sku = products.sku
    JOIN sales.orders ON order_lines.order_id = orders.order_id
    JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.company_name;

-- Force all HASH joins with a query hint
SELECT 
    orders.customer_id,
    customers.company_name,
    COUNT(orders.order_id) AS number_of_orders,
    SUM(order_lines.quantity * products.price) AS customer_total_spend
FROM sales.order_lines
    INNER HASH JOIN inventory.products ON order_lines.sku = products.sku
    INNER HASH JOIN sales.orders ON order_lines.order_id = orders.order_id
    INNER HASH JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.company_name;


-- Force all MERGE joins with a query hint
SELECT 
    orders.customer_id,
    customers.company_name,
    COUNT(orders.order_id) AS number_of_orders,
    SUM(order_lines.quantity * products.price) AS customer_total_spend
FROM sales.order_lines
    INNER MERGE JOIN inventory.products ON order_lines.sku = products.sku
    INNER MERGE JOIN sales.orders ON order_lines.order_id = orders.order_id
    INNER MERGE JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.company_name;



-- end
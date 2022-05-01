
-- sql server
CREATE DATABASE mytestdb;
SELECT * FROM sys.databases;

-- add schemas
GO -- in mysql, have to run schema's by themselves
CREATE SCHEMA products;
GO
CREATE SCHEMA sales;
GO

-- test schema to practice dropping
CREATE SCHEMA test;
DROP SCHEMA test;

-- create tables

CREATE TABLE products.products (
    SKU CHAR(7) NOT NULL PRIMARY KEY,
    ProductName CHAR(50) NOT NULL,
    CategoryID INT,
    Size INT,
    Price DECIMAL(5,2) NOT NULL
);

CREATE TABLE products.categories (
    CategoryID INT PRIMARY KEY,
    CategoryDescription CHAR(50)
);

-- add data
INSERT INTO products.categories 
	(CategoryID, CategoryDescription)
VALUES
	(1, 'Olive Oils'),
	(2, 'Flavor Infused Oils'), 
	(3, 'Bath and Beauty')
;

-- check they have been added
SELECT TOP (100) CategoryID, CategoryDescription FROM products.categories;

-- add a column
ALTER TABLE  products.categories
ADD ProductLine CHAR(25);

-- add new column data
UPDATE products.categories SET ProductLine = 'Gourmet Chef'
WHERE CategoryID IN (1,2);

UPDATE products.categories SET ProductLine = 'Cosmetics'
WHERE CategoryID = 3;

-- add product values
INSERT INTO products.products
VALUES ('FCP008', 'First Cold Press', 1,8, 8.99);

INSERT INTO products.products VALUES
    ('BI088', 'Basil-Infused EVO', 2, 8, 10.99),
    ('GI016', 'Garlic-Infused EVO', 2, 16, 15.99)
;

-- add to specific columns
INSERT INTO products.products
    (SKU, ProductName, Price)
VALUES
    ('OGEC004', 'Olive Glow eye Cream', 18.99)
;

UPDATE products.products
SET CategoryID = 3,
    Size = 4
WHERE SKU = 'OGEC004';

DELETE FROM products.products
WHERE SKU = 'OGEC004';

-- Remove all rows from the products table
DELETE FROM products.products;

-- Add all new product data
INSERT INTO products.products
    (SKU, ProductName, CategoryID, Size, Price)
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

-- Selecting
SELECT ProductName, Size, Price 
FROM products.products;

SELECT * 
FROM products.products
WHERE CategoryID = 2;

SELECT * 
FROM products.products
WHERE NOT Price > 25;

SELECT * 
FROM products.products
WHERE PRICE > 10 AND Size < 12;

-- Order by
SELECT *
FROM products.products
WHERE Size = 8
ORDER BY Price;

SELECT *
FROM products.products
WHERE Size = 8
ORDER BY Price DESC, ProductName;

-- join
SELECT *
FROM products.products
    JOIN products.categories
        ON products.CategoryID = categories.CategoryID
WHERE SKU = 'ALB008';

-- specify the table columns
SELECT products.ProductName,
    products.CategoryID,
    products.SKU,
    products.Price,
    categories.ProductLine
FROM products.products
    JOIN products.categories
        ON products.CategoryID = categories.CategoryID
WHERE SKU = 'ALB008';

-- limit
-- mysql uses top with the select, postgres uses limit at the end of the query
SELECT TOP 5 *
FROM products.products
ORDER BY Price;

-- SELECT * FROM products.products LIMIT 5;

-- percent of the data
-- postgres doesn't have percent functionality
SELECT TOP 5 PERCENT
FROM products.products
ORDER BY Price;

-- aliases, rename in the results
SELECT products.ProductName AS "Product Name",
	products.Size as "Size (ounces)",
    products.SKU as "Product SKU",
    products.Price as "Price (US Dollars)",
    categories.ProductLine as "Product Line"
FROM products.products
    JOIN products.categories
        ON products.CategoryID = categories.CategoryID
;

-- rename table to shorten query
SELECT p.ProductName AS "Product Name",
	p.Size as "Size (ounces)",
    p.SKU as "Product SKU",
    p.Price as "Price (US Dollars)",
    c.ProductLine as "Product Line"
FROM products.products AS p
    JOIN products.categories AS c
        ON p.CategoryID = c.CategoryID
;

-- the As keyword is optional so it is the same as
SELECT p.ProductName "Product Name",
	p.Size "Size (ounces)",
    p.SKU "Product SKU",
    p.Price "Price (US Dollars)",
    c.ProductLine "Product Line"
FROM products.products p
    JOIN products.categories c
        ON p.CategoryID = c.CategoryID
;

-- MATH

-- adding in, at runtime math on the price
-- so that if the price changes, the tax rate will auto change too
SELECT SKU,
    ProductName,
    CategoryID,
    Size,
    Price,
    '8.5%' as TaxRate,
    Price * 0.085 as SalesTax,
    Price * 1.085 as TotalPrice
FROM products.products;

-- default functions of maths
SELECT
    MAX(Price) "Max Price",
    MIN(Price) "Min Price",
    AVG(Price) "Average Price"
    ROUND(AVG(Price), 2) "Rounded avg price" -- round to 2 decimal places 
FROM products.products

-- embedded query
SELECT ProductName, Size, Price
FROM products.products
WHERE Price = 
    (SELECT MAX(Price)
     FROM products.products
    )
;

-- look for documentation for more functions :)

-- group by
-- after the where but before order by
SELECT
    categories.CategoryDescription,
    products.SKU
FROM products.products
    JOIN products.categories
    ON products.CategoryID = categories.CategoryID
;

SELECT
    categories.CategoryDescription,
    COUNT(products.SKU) "Number of SKUs"
    -- also apply min, max, avg to see on each grouping
FROM products.products
    JOIN products.categories
    ON products.CategoryID = categories.CategoryID
GROUP BY CategoryDescription
ORDER BY COUNT(products.SKU) DESC
;

-- Having
SELECT
    categories.CategoryDescription,
    COUNT(products.SKU) "Number of SKUs"
FROM products.products
    JOIN products.categories
    ON products.CategoryID = categories.CategoryID
WHERE products.Price > 15
GROUP BY CategoryDescription
HAVING CategoryDescription = 'Olive Oils'
-- HAVING NOT CategoryDescription = 'Bath and Beauty'
ORDER BY COUNT(products.SKU) DESC
;

-- Question: How many different product SKU's are available in each size?
-- Answer
SELECT Size "Size (Ounces)",
	COUNT(SKU) "Number of SKUs"
FROM products.products
GROUP BY Size;

-- Clean up
DROP TABLE products.categories;
DROP TABLE products.products;
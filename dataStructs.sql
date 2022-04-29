-- into the same db as the intro db, mytestdb

-- Creating tables with Primary Keys in SQL Server
-- OPTION 1
-- Create the primary key column in the column specification
CREATE TABLE customers (
    customer_id char(5) NOT NULL PRIMARY KEY,
    company     varchar(100),
    address     varchar(100),
    city        varchar(50),
    state       char(2),
    zip         char(5)
);

DROP TABLE customers;


-- OPTION 2
-- Add the primary key constraint when creating the table
CREATE TABLE customers (
    customer_id char(5) NOT NULL,
    company     varchar(100),
    address     varchar(100),
    city        varchar(50),
    state       char(2),
    zip         char(5),
    CONSTRAINT PK_Customers_CustomerID PRIMARY KEY (customer_id)
);

DROP TABLE customers;


-- OPTION 3
-- Add the primary key after the table is created
CREATE TABLE customers (
    customer_id char(5) NOT NULL,
    company     varchar(100),
    address     varchar(100),
    city        varchar(50),
    state       char(2),
    zip         char(5)
);

ALTER TABLE customers
   ADD CONSTRAINT PK_Customers_CustomerID PRIMARY KEY (customer_id);


-- Test out the Primary Key
INSERT INTO customers VALUES
('FV418', 'Flavorville', '798 Ravinia Road', 'Des Moines', 'IA', '50320');

INSERT INTO customers VALUES
('FV418', 'Wild Rose', '222 Dakota Lane', 'Kalamazoo', 'MI', '49001');
-- Change id for Wild Rose to 'WR421'
INSERT INTO customers VALUES
('WR421', 'Wild Rose', '222 Dakota Lane', 'Kalamazoo', 'MI', '49001');


SELECT * FROM customers;

----------------------
-- Composite Keys
CREATE TABLE HotelRooms (
    CheckinDate date NOT NULL,
    RoomNumber char(3) NOT NULL,
    GuestName varchar(50),
    CONSTRAINT PK_Checkinrooms PRIMARY KEY (CheckinDate, RoomNumber)
);

INSERT INTO HotelRooms VALUES
('2020-10-15', '201', 'Dr. White');

INSERT INTO HotelRooms VALUES
('2020-10-15', '315', 'Ms. Green'),
('2020-10-16', '201', 'Mr. Brown')
;

-- below causes PK error
--INSERT INTO HotelRooms VALUES
--('2020-10-15', '201', 'Mrs. Blue');

DROP TABLE HotelRooms;


-- Surrogate Key
-- AUTO INCREMENT
CREATE TABLE fruit (
    fruitID INT IDENTITY (100, 10) PRIMARY KEY,
    type varchar(10)
);

INSERT INTO fruit (type) VALUES
('apple'), ('grape'), ('Watermelon');

SELECT * from fruit;

DROP TABLE fruit;

-- foreign keys
-- Creating and using foreign key fields
SELECT * FROM customers;

-- Create a table that relates to the 'customers' table
CREATE TABLE orders (
    order_id     INT IDENTITY(100,1) NOT NULL PRIMARY KEY, --PostgreSQL: use GENERATED ALWAYS AS IDENTITY (START WITH 100 INCREMENT BY 1)
    order_date   DATE,
    total_price  DECIMAL(10,2),
    customer_id  CHAR(5)
);

INSERT INTO orders (order_date, total_price, customer_id) VALUES
    ('2020-10-15', 195.99, 'FV418'),
    ('2020-10-19', 128.76, 'FV418'),
    ('2020-10-20', 65.92, 'WR421'),
    ('2020-10-20', 1518.33, 'FV418')
;

-- View the result in both tables
SELECT * FROM customers;
SELECT * FROM orders;

-- Join data rows by matching primary and foreign key fields
SELECT  orders.order_id,
        orders.order_date,
        customers.company,
        customers.customer_id,
        customers.address,
        customers.city,
        customers.state,
        orders.total_price
FROM customers JOIN orders ON customers.customer_id = orders.customer_id;

----------------------------------------------------------------------------------
-- now to alter table and add foreign key
-- Creating a foreign key constraint
SELECT * FROM customers;
SELECT * FROM orders;

-- Insert an orphan row
INSERT INTO orders (order_date, total_price, customer_id) VALUES
('2020-10-22', 397.54, 'DF399');

SELECT * FROM customers;
SELECT * FROM orders;

DELETE FROM orders WHERE customer_id = 'DF399';


-- Add a foreign key constraint on the customer_id column
ALTER TABLE orders
ADD CONSTRAINT fk_customers_customer_id FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
;

-- Try to add the orphan row again
-- Get an error because parent row doesn't have DF399, 
-- so we add it on the next command
INSERT INTO orders (order_date, total_price, customer_id) VALUES
('2020-10-22', 397.54, 'DF399');

-- Add the new customer data first, then enter the order
INSERT INTO customers VALUES
('DF399', 'Delish Food', '583 Roosevelt Lane', 'Evergreen Park', 'IL', '60642');

INSERT INTO orders (order_date, total_price, customer_id) VALUES
('2020-10-22', 397.54, 'DF399');

SELECT * FROM customers;
SELECT * FROM orders;


-----------------------------------------------------------------------------------------
-- cascade changes
-- Cascade updates and deletes
SELECT * FROM customers;
SELECT * FROM orders;

-- Try to edit a customer id, Error
UPDATE customers
SET customer_id = 'WR521' WHERE customer_id = 'WR421';

-- Try to remove a customer, Error
DELETE FROM customers
WHERE customer_id = 'WR421'

-- Remove the existing foreign key constraint
ALTER TABLE orders
DROP CONSTRAINT fk_customers_customer_id;

-- Recreate the constraint with options to cascade update and cascade delete changes
ALTER TABLE orders
ADD CONSTRAINT fk_customers_customer_id FOREIGN KEY (customer_id)
      REFERENCES customers (customer_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
;

-- Edit a customer id
UPDATE customers
SET customer_id = 'WR521' WHERE customer_id = 'WR421';

SELECT * FROM customers;
SELECT * FROM orders;

-- Remove a customer
DELETE FROM customers
WHERE customer_id = 'WR521'

SELECT * FROM customers;
SELECT * FROM orders;


-- add index
CREATE INDEX IX_Customers_State -- named IX_customer_state
ON customers (state);

DROP INDEX IX_Customers_State on customers;

-- look at system index stats
-- View index information on SQL Server

SELECT * FROM sys.indexes;

SELECT  sys.objects.name AS [table name],
        sys.indexes.name AS [index name],
        sys.objects.object_id AS [object id],
        sys.indexes.type_desc AS [index type],
        CASE (sys.indexes.is_primary_key)
            WHEN 0 THEN ''
            WHEN 1 THEN 'Primary Key'
        END AS [primary key],
        CASE (sys.indexes.is_unique_constraint)
            WHEN 0 THEN ''
            WHEN 1 THEN 'Unique Constraint'
        END AS [unique constraint]
FROM sys.objects JOIN sys.indexes ON sys.objects.object_id = sys.indexes.object_id
WHERE sys.objects.type_desc = 'USER_TABLE';

-- View index usage statistics
SELECT * FROM sys.dm_db_index_usage_stats;

SELECT  OBJECT_NAME(s.object_id) AS [table name],
        i.name AS [index name],
        s.user_seeks,
        s.user_scans,
        s.user_lookups,
        s.user_updates,
        s.last_user_seek,
        s.last_user_scan
FROM sys.dm_db_index_usage_stats AS s
    JOIN sys.indexes AS i ON i.object_id = s.object_id;

--- unique
-- the unique constraint forces each row's column to be unique.

-- setting default value
ALTER TABLE customers
    ALTER COLUMN state SET DEFAULT 'CA';

CREATE TABLE test (
    customer_id char(5) NOT NULL PRIMARY KEY,
    state char(2) DEFAULT 'CA'
);

DROP TABLE test;

-- check constraint
-- > < = !, and some regex depending on server use
ALTER TABLE orders
    ADD CONSTRAINT check_min_price
    CHECK (total_price > 100);

CREATE TABLE test (
    customer_id char(5) NOT NULL PRIMARY KEY,
    total_price DECIMAL(10, 2) CONSTRAINT check_min_price CHECK (total_price > 100)
);

DROP TABLE test;
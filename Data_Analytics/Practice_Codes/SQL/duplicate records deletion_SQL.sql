-- Dropping the table if it exists
DROP TABLE IF EXISTS customer;

-- Creating the customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    created_date DATE
);

TRUNCATE table customer ;

-- Inserting data into the customer table
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA', '2023-01-15');
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(2, 'John Doe', 'John.doe@example.com', '123-555-7890', '456 Oak St, Anytown, USA', '2023-02-20');
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(3, 'Alice Johnson', 'alice.johnson@example.com', '123-555-7891', '789 Pine St, Anytown, USA', '2023-03-10');
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(4, 'Bob Brown', 'bob.brown@example.com', '123-555-7892', '321 Elm St, Anytown, USA', '2023-04-05');
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(5, 'Carol White', 'carol.white@example.com', '123-555-7893', '654 Maple St, Anytown, USA', '2023-05-25');
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(6, 'David Green', 'david.green@example.com', '123-555-7894', '987 Cedar St, Anytown, USA', '2023-06-30');

-- Selecting all data from customer table
SELECT * FROM customer;

-- Identifying duplicates based on customer_name and email
SELECT customer_id, customer_name, email, phone_number, address, created_date
FROM (
    SELECT customer_id, customer_name, email, phone_number, address, created_date,
           ROW_NUMBER() OVER (PARTITION BY customer_name, email ORDER BY customer_id) AS rn
    FROM customer 
) AS duplicate_cnt
WHERE rn > 1
ORDER BY customer_id;


delete 
FROM (
    SELECT customer_id, customer_name, email, phone_number, address, created_date,
           ROW_NUMBER() OVER (PARTITION BY customer_name, email ORDER BY customer_id) AS rn
    FROM customer 
) AS duplicate_cnt
WHERE rn > 1
ORDER BY customer_id;


SELECT * FROM  customer;

WITH duplicate_cte AS (
    SELECT customer_id,
           ROW_NUMBER() OVER (PARTITION BY customer_name, email ORDER BY customer_id) AS duplicate_cnt
    FROM customer
)
DELETE FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM duplicate_cte
    WHERE duplicate_cnt > 1
);


-- Verifying the deletion
SELECT * FROM customer;

-- Using GROUP BY and HAVING to find duplicate customer names
SELECT 
    customer_name, 
    COUNT(*) AS cnt  
FROM customer
GROUP BY customer_name
HAVING COUNT(*) > 1;

-- Selecting all data from customer table
SELECT * FROM customer;

-- Deleting duplicates while keeping the latest entry

select * FROM customer
WHERE customer_id NOT IN (
    SELECT MAX(customer_id)
    FROM customer
    GROUP BY customer_name
);

DELETE  FROM customer
WHERE customer_id NOT IN (
    SELECT MAX(customer_id)
    FROM customer
    GROUP BY customer_name
);

-- Verifying the deletion
SELECT * FROM customer;

-- Employee table operations

-- Dropping the Employee table if it exists
DROP TABLE IF EXISTS Employee;

-- Creating the Employee table
CREATE TABLE Employee (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Country VARCHAR(100)
);

-- Inserting data into the Employee table
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (1, 'Raj', 'Gupta', 'India');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (2, 'Raj', 'Gupta', 'India');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (3, 'Mohan', 'Kumar', 'USA');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (4, 'James', 'Barry', 'UK');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (5, 'James', 'Barry', 'UK');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (6, 'James', 'Barry', 'UK');

-- Selecting all data from Employee table
SELECT * FROM Employee;

-- Using GROUP BY and HAVING to find duplicate employees
SELECT 
    FirstName, 
    LastName, 
    Country, 
    COUNT(*) AS CNT
FROM Employee
GROUP BY FirstName, LastName, Country
HAVING COUNT(*) > 1;


SELECT * FROM Employee
WHERE ID NOT IN (
    SELECT MAX(ID)
    FROM Employee
    GROUP BY FirstName, LastName, Country
);

-- Deleting duplicates while keeping the latest entry
DELETE FROM Employee
WHERE ID NOT IN (
    SELECT MAX(ID)
    FROM Employee
    GROUP BY FirstName, LastName, Country
);

-- Verifying the deletion
SELECT * FROM Employee;

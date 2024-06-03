drop table customer;

CREATE TABLE customer (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    address VARCHAR2(200),
    created_date DATE
);
-- Inserting data into the customer table
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA', TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(2, 'John Doe', 'John.doe@example.com', '123-555-7890', '456 Oak St, Anytown, USA', TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(3, 'Alice Johnson', 'alice.johnson@example.com', '123-555-7891', '789 Pine St, Anytown, USA', TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(4, 'Bob Brown', 'bob.brown@example.com', '123-555-7892', '321 Elm St, Anytown, USA', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(5, 'Carol White', 'carol.white@example.com', '123-555-7893', '654 Maple St, Anytown, USA', TO_DATE('2023-05-25', 'YYYY-MM-DD'));
INSERT INTO customer (customer_id, customer_name, email, phone_number, address, created_date) VALUES
(6, 'David Green', 'david.green@example.com', '123-555-7894', '987 Cedar St, Anytown, USA', TO_DATE('2023-06-30', 'YYYY-MM-DD'));

SELECT * FROM customer;

SELECT customer_id, customer_name, email, phone_number, address, created_date
FROM (
    SELECT customer_id, customer_name, email, phone_number, address, created_date,
           ROW_NUMBER() OVER (PARTITION BY customer_name, email ORDER BY customer_id) AS rn
    FROM customer
)
WHERE rn > 1;


SELECT * FROM 

(SELECT customer_id,email,ROW_NUMBER () OVER (PARTITION BY customer_name ORDER BY customer_id) "rank_now" 
FROM customer); -- WHERE "rank_now" > 1;


-- rank()

/*DELETE * FROM 

(SELECT customer_id,email,rank() OVER (PARTITION BY customer_name ORDER BY customer_id) "rank_now" 
FROM customer) 

WHERE "rank_now" > 1;


DELETE FROM CUSTOMER

WHERE customer_id IN (

SELECT 

"customer_id" WHERE "rank_now" > 1

SELECT * FROM CUSTOMER c ; -- this way OF query isnot working IN oracle;


-- need to use CTE:

-- Using a Common Table Expression (CTE) to identify duplicates with row_number()

WITH duplicates AS (
    SELECT customer_id,
           ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY customer_id) AS duplicate_count
    FROM customer
)
-- Deleting the identified duplicates
DELETE FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM duplicates
    WHERE duplicate_count > 1
);*/

-- CTE also not working in Oracle


SELECT * FROM CUSTOMER c;


DELETE FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM (
        SELECT customer_id,
               ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY customer_id) AS duplicate_count
        FROM customer
    )
    WHERE duplicate_count > 1
);

-- This normal delete with  ROW_NUMBER() partition is working

SELECT * FROM CUSTOMER c;

-- using having 


/*SELECT [FirstName], 
    [LastName], 
    [Country], 
    COUNT(*) AS CNT
FROM [SampleDB].[dbo].[Employee]
GROUP BY [FirstName], 
      [LastName], 
      [Country]
HAVING COUNT(*) > 1;*/





SELECT 
customer_id,
	customer_name, 
--		email, 
--		phone_number, 
--		address, 
--		created_date,
        count(*) AS cnt
 FROM customer
 GROUP BY
 customer_id,
		customer_name
--		email, 
--		phone_number, 
--		address, 
--		created_date 
HAVING count(*) > 1;



SELECT 
       customer_name,count(*) AS cnt  
 FROM customer
 GROUP BY   
		customer_name
		
HAVING count(*) > 1;
   

-- both ways working in oracel( working in sql_dev app, but not showing data in dbeaver app,syntax is correct)


SELECT * FROM  CUSTOMER c;



SELECT *
    FROM CUSTOMER
    WHERE customer_id NOT IN
    (
        SELECT MAX(customer_id)
        FROM CUSTOMER
        GROUP BY 
				customer_name
    );
   
DELETE FROM CUSTOMER
    WHERE customer_id NOT IN
    (
        SELECT MAX(customer_id)
        FROM CUSTOMER
        GROUP BY 
				customer_name
    );
	
   
SELECT * FROM   CUSTOMER;  -- working IN oracle
	
-- --------------------------------------------------------------------------------------------------------------------

   
DROP TABLE    Employee;

CREATE TABLE Employee (
    ID INT PRIMARY KEY,
    FirstName VARCHAR2(100),
    LastName VARCHAR2(100),
    Country VARCHAR2(100)
);

    
SELECT * FROM Employee;
    
    
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES (1, 'Raj', 'Gupta', 'India');
INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES
       (2, 'Raj', 'Gupta', 'India');
      INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES
       (3, 'Mohan', 'Kumar', 'USA');
      INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES
       (4, 'James', 'Barry', 'UK');
      INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES
       (5, 'James', 'Barry', 'UK');
      INSERT INTO Employee (ID, FirstName, LastName, Country)
VALUES
       (6, 'James', 'Barry', 'UK');

                               
                               
SELECT * FROM Employee;



-- Group By and having clause

SELECT 
    FirstName ,
    LastName ,
    Country , 
    COUNT(*) AS CNT
FROM Employee
GROUP BY FirstName ,
    LastName ,
    Country
HAVING COUNT(*) > 1;

SELECT *
    FROM Employee
    WHERE ID NOT IN
    (
        SELECT MAX(ID)
        FROM Employee
        GROUP BY FirstName ,
			    LastName ,
			    Country
    );
   
   
 SELECT * FROM Employee;
    
 delete FROM Employee
    WHERE ID NOT IN
    (
        SELECT MAX(ID)
        FROM Employee
        GROUP BY FirstName ,
			    LastName ,
			    Country
    );
   
SELECT * FROM Employee;

-- working in oracle



-- --------------------------------------------------------------------------------------------------------------------------

   
   
   
      
   
   
drop table customer;

CREATE TABLE customer (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    Cont_No VARCHAR2(20),
    address VARCHAR2(255),
    city VARCHAR2(100),
    state VARCHAR2(50),
    postal_code VARCHAR2(20),
    country VARCHAR2(100),
    DATA VARCHAR2(100)
);


/*INSERT INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) VALUES
(1, 'John', 'Doe', 'john@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(2, 'Jane', 'Smith', 'jane@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA'),
(3, 'John', 'Doe', 'john3@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(4, 'Jane', 'Smith', 'jane4@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA'),
(5, 'John', 'Doe', 'john5@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(6, 'Jane', 'Smith', 'jane6@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA'),
(7, 'John', 'Doe', 'john7@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(8, 'Jane', 'Smith', 'jane8@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA'),
(9, 'John', 'Doe', 'john9@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(10, 'Jane', 'Smith', 'jane10@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');
*/ -- sql query insert

INSERT 
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES (1, 'John', 'Doe', 'john@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA');
INSERT INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(2, 'Jane', 'Smith', 'jane@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');
INSERT 
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(3, 'John', 'Doe', 'john3@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA');
INSERT
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(4, 'Jane', 'Smith', 'jane4@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');
INSERT
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(5, 'John', 'Doe', 'john5@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA');
INSERT 
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(6, 'Jane', 'Smith', 'jane6@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');
INSERT
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(7, 'John', 'Doe', 'john7@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA');
INSERT INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(8, 'Jane', 'Smith', 'jane8@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');
INSERT
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(9, 'John', 'Doe', 'john9@example.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345', 'USA');
INSERT
INTO customer (customer_id, first_name, last_name, email, Cont_No, address, city, state, postal_code, country) 
VALUES 
(10, 'Jane', 'Smith', 'jane10@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'NY', '54321', 'USA');

select * from customer;

-- Update a single column on multiple rows with one SQL query: 
-- one way: one at once   

UPDATE customer SET DATA='FOO' WHERE CUSTOMER_ID=1;
UPDATE customer SET DATA='ASD' WHERE CUSTOMER_ID=6;
UPDATE customer SET DATA='FGH' WHERE CUSTOMER_ID=7;
UPDATE customer SET DATA='JKL' WHERE CUSTOMER_ID=5;
UPDATE customer SET DATA='QWE' WHERE CUSTOMER_ID=3;
UPDATE customer SET DATA='BAR' WHERE CUSTOMER_ID=9;

-- working in oracle

-- UPDATE customer SET DATA="ASD" WHERE ID=6; -- SQL syntax


select * from customer;  

-- Another way : all at once (check if this work or not)  

UPDATE customer SET DATA=('FOO', 'ASD', 'FGH', 'JKL')  
WHERE ID=(2 ,10, 4, 8); 			--> not working  in oracle and Sql also

Another Way: All at once using CASE:   

/*SELECT first_name, age 

FROM customer; 

select * from customer;*/ 

-- alter table customer add Cont_No; 

/*UPDATE customer 

SET Cont_No=("123", "456", "789", "101112", "131415")  

WHERE customer_id = (1,3,5,4,2);*/

  

update  customer set Cont_No= 

case  

when customer_id = 1 then  '123' 

when customer_id = 2 then  '456' 

when customer_id = 4 then '789' 

when customer_id = 5 then '101112'  

when customer_id = 3 then  '131415' 

end; 

-- working in oracle multiple rows of same column in a table are updated 


-- Creating Procedure in Oracle no need of DELIMITER //:  

CREATE OR REPLACE PROCEDURE add_to_Cust_table AS
BEGIN
    UPDATE customer
    SET Cont_No = 
        CASE customer_id
            WHEN 1 THEN '000'
            WHEN 2 THEN '456'
            WHEN 4 THEN '0000'
            WHEN 5 THEN '101112'
            WHEN 3 THEN '131415'
        END;
END add_to_Cust_table;
/


-- call add_to_Cust_table;

BEGIN
    add_to_Cust_table;
END;
/

select * from customer;

-- procedure working in oracle and table data updated


 
--> updating contact no - with user given values   

CREATE OR REPLACE PROCEDURE update_Cont_No(p_customer_id IN NUMBER, p_new_cont_no IN VARCHAR2) AS
BEGIN
    UPDATE customer
    SET Cont_No = p_new_cont_no
    WHERE customer_id = p_customer_id;
    
   --  COMMIT; -- Optional, depending on your transaction requirements
END update_Cont_No;
/



--> call this procedure by providing values for the parameters:   

CALL update_Cont_No(1, '111'); 

CALL update_Cont_No(2, '222'); 

CALL update_Cont_No(4, '4444'); 

CALL update_Cont_No(5, '55555'); 

CALL update_Cont_No(3, '333333'); 


select * from customer;
  

  

practice functions:   

SELECT USER FROM DUAL;
SELECT SYS_CONTEXT('USERENV', 'DB_NAME') FROM DUAL; -- oracle



-- SELECT DATABASE();  

-- SELECT CURRENT_USER(); 
 

--> creation and updating multiple values in multiple tables:   

CREATE GLOBAL TEMPORARY TABLE a_new (
    x VARCHAR2(10),
    y VARCHAR2(10),
    z VARCHAR2(10),
    value NUMBER
) ON COMMIT PRESERVE ROWS;

INSERT INTO a_new (x, y, z, value)
SELECT 'a', 'b', 'c', 100 FROM DUAL
UNION ALL
SELECT 'a1', 'b1', 'c1', 200 FROM DUAL; -- Oracle Syntax

select * from a_new;



CREATE GLOBAL TEMPORARY TABLE a_old (
    x VARCHAR2(10),
    y VARCHAR2(10),
    z VARCHAR2(10),
    value NUMBER
) ON COMMIT PRESERVE ROWS;

INSERT INTO a_old (x, y, z, value)
SELECT 'a', 'b', 'c', 100 FROM DUAL
UNION ALL
SELECT 'a1', 'b1', 'c1', 200 FROM DUAL; -- Oracle Syntax

select * from a_old;


select * from a_old o inner join a_new n on n.x = o.x; 
  

select * from a_old o inner join a_new n; -- not working in Oracle but working in SQL


update a_new a set a.value = b.value from a_old b 

where (b.x,b.y,b.z) = (a.x,a.y,a.z); -- not working in Oracle, need to use merge

MERGE INTO a_new a
USING a_old b
ON (b.x = a.x AND b.y = a.y AND b.z = a.z)
WHEN MATCHED THEN
  UPDATE SET a.value = b.value;
  
select * from  a_new a; -- using merge working in Oracle
 


select * from a_old o  

inner join a_new n on  n.value in (100,200)  

where o.value in (100,200);  


/* 
create temp table a_old as  

select 'a' x, 'b' y, 'c' z, 300 value 

union all 

select 'a1', 'b1', 'c1', 500 value; */ 

  

/* update a_new as a 

set value = b.value 

from a_old b 

where (b.x,b.y,b.z) = (a.x,a.y,a.z);*/ 

  

-- select * from a_new; 

/*update a_new n, a_old o 

set n.y = 0,o.x=1 

where n.z= 'c1' and o.y = 'b1'; */  


select * from a_old o 

inner join a_new n on n.x = o.x; 
  

select * from a_old o 

inner join a_new n;--  on n.x = o.x;--> this also works in SQL displaying all the data in two tables at once 


/*UPDATE a_new 

SET y = 0 

WHERE z = 'c1';*/ 

  

/* UPDATE a_old AS o 

SET o.x = 1 

WHERE o.y = 'b1';*/ 

  

-- delete from a_old  where value in (0); 

/* select * from a_old o  

inner join a_new n on  n.value in (300,500)  

where o.value in (300,500);  */

--> updating old and new data tables at the same time(need to learn):   

conditions :  

1) data in both the tables need to be updates and displayed in same time. 

2) need to execute task with only one query.
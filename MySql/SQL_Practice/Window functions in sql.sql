-- drop table if exists students; 

  

-- create a table 

CREATE TABLE students ( 

  id INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  gender TEXT NOT NULL 

); 

  	

  

-- insert some values 

INSERT INTO students VALUES (1, 'Ryan', 'M'); 

INSERT INTO students VALUES (2, 'Joanna', 'F'); 

-- fetch some values 

-- SELECT * FROM students WHERE gender = 'F'; 

  

  

  

-- create 

CREATE TABLE EMPLOYEE ( 

  empId INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  dept TEXT NOT NULL 

);    

   

  

select * from EMPLOYEE;n 

  

-- insert 

INSERT INTO EMPLOYEE VALUES (0001, 'Clark', 'Sales'); 

INSERT INTO EMPLOYEE VALUES (0002, 'Dave', 'Accounting'); 

INSERT INTO EMPLOYEE VALUES (0003, 'Ava', 'Sales'); 

  

-- fetch  

SELECT * FROM EMPLOYEE WHERE dept = 'Sales'; 

  

  

  
-- -----------------------------------------------------------------------------------------------------------------------------
  

  

-- window functions SQL... 

  

-- using partition by, group by, insertion new column and data into the table 

  

-- Example 1: 

  

CREATE TABLE students ( 

  id INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  gender TEXT NOT NULL, 

  date_of_the_day DATE NOT NULL 

#Marks INT NOT NULL 

) 

  

-- fetch some values 

  

-- SELECT * FROM students WHERE gender = 'F'; 

  

  

-- SELECT * FROM students order by id;--  limit 3; 

  

  

-- alter table  students add column Marks int; 

  

SELECT name, 

       id, 

       Count() OVER 

         (PARTITION BY start_terminal) AS running_total, 

       COUNT(duration_seconds) OVER 

         (PARTITION BY start_terminal) AS running_count, 

       AVG(duration_seconds) OVER 

         (PARTITION BY start_terminal) AS running_avg 

  FROM tutorial.dc_bikeshare_q1_2012 

  

WHERE start_time < '2012-01-08';    

  

  

ALTER TABLE students 

ADD COLUMN Marks INT; 

  

-- insert some values 

  

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (1, 'Ryan',40, 'M',CURRENT_DATE); 

INSERT INTO students  (id,name,name,gender,date_of_the_day)  

	VALUES (2, 'Joanna',3, 'F',CURRENT_DATE); 

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (27,'kumar',50,'M',CURRENT_DATE); 

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (3, 'Joa',10, 'F',CURRENT_DATE); 

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (9,'kumar',50,'M',CURRENT_DATE); 

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (10, 'Joe',100, 'M',CURRENT_DATE); 

INSERT INTO students (id,name,name,gender,date_of_the_day)  

	VALUES (11,'kumari',500,'F',CURRENT_DATE); 

  

  

-- SELECT * FROM students partition by Marks order by id;--  limit 3; 

  

-- SELECT * FROM students partitionby id;--  limit 3; 

  

    SELECT 

  

    ROW_NUMBER() OVER (PARTITION BY Marks ORDER BY id) AS row_num, 

  

    RANK() OVER(PARTITION BY Marks ORDER BY id DESC) AS Std_rank, 

  

    DENSE_RANK() OVER(PARTITION BY Marks ORDER BY id DESC) AS Std_dense_rank, 

  

    sum(Marks)  OVER(PARTITION BY Marks ORDER BY id DESC) AS Total_Marks, 

  

    avg(Marks)  OVER(PARTITION BY Marks ORDER BY id DESC) AS Average, 

  

    count(name)  OVER(PARTITION BY Marks ORDER BY id DESC) AS Total_Marks, 

  

    NTILE(4)  OVER(PARTITION BY Marks ORDER BY id DESC) AS quartile, 

    NTILE(5) OVER(PARTITION BY Marks ORDER BY id DESC)  AS quintile, 

    NTILE(100) OVER(PARTITION BY Marks ORDER BY id DESC) AS percentile, 

  

    lead(Marks,1) OVER(PARTITION BY Marks ORDER BY id DESC) AS lead, 

    COALESCE(LAG(Marks, 2) OVER (PARTITION BY Marks ORDER BY id DESC), -1) AS lag 

  

FROM 

  students;--  where id = 27; 

  

  

  

  

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

-- Example 2:  

-- Create a table  

CREATE TABLE sales ( 

    sale_id INT PRIMARY KEY, 

    product_name VARCHAR(50) NOT NULL, 

    sale_date DATE NOT NULL, 

    sale_amount DECIMAL(10, 2) NOT NULL, 

    date_of_day DATE NOT NULL, 

    time_of_day TIME  

); 

  

-- Insert values into the table  

INSERT INTO sales VALUES 

    (1, 'Product A', '2022-01-01', 100.50,DATE(),TIME()),      

-- TIME IS PRINTED WRONG NEED TO CHECK AGAIN  

    (2, 'Product B', '2022-01-01', 150.75,DATE(),TIME()), 

    (3, 'Product A', '2022-01-01', 120.00,DATE(),TIME()), 

    (4, 'Product C', '2022-01-01', 200.25,DATE(),TIME()), 

    (5, 'Product B', '2022-01-01', 180.50,DATE(),TIME()), 

    (6, 'Product A', '2022-01-01', 90.75,DATE(),TIME()), 

    (7, 'Product C', '2022-01-01', 250.00,DATE(),TIME()); 

  

-- Write a query including various window functions 

SELECT 

   date_of_day, 

    sale_id, 

    time_of_day, 

    product_name /*, 

    sale_date, 

    sale_amount, 

    ROW_NUMBER() OVER (ORDER BY sale_amount DESC) AS row_number, 

    RANK() OVER (ORDER BY sale_amount DESC) AS rank, 

    DENSE_RANK() OVER (ORDER BY sale_amount DESC) AS dense_rank, 

     FIRST_VALUE(sale_amount)  

    OVER (PARTITION BY product_name  

    ORDER BY sale_date) AS first_sale_product, 

    LAST_VALUE(sale_amount)  

    OVER (PARTITION BY product_name  

    ORDER BY sale_date) AS last_sale_product , 

    MAX(sale_amount)  

    OVER (PARTITION BY product_name  

    ORDER BY sale_date) AS first_sale_in_product, 

    MIN(sale_amount)  

    OVER (PARTITION BY product_name  

    ORDER BY sale_date) AS last_sale_in_product, 

    AVG(sale_amount) OVER () AS avg_sale_amount, 

    SUM(sale_amount) OVER (PARTITION BY product_name) AS total_sale_amount_by_product, 

    LAG(sale_amount, 1) OVER (ORDER BY sale_date) AS lag_sale_amount, 

    LEAD(sale_amount, 1) OVER (ORDER BY sale_date) AS lead_sale_amount,    

    TRIM(product_name, 'o') AS Trimmed_Value, 

    LTRIM(product_name, 'o') AS L_Trimmed_Value, 

    RTRIM(product_name, 'o') AS R_Trimmed_Value, 

    RTRIM(LTRIM(product_name, 'o'), ' ') AS LR_Trimmed_Value, 

    -- RTRIM(TRANSLATE(product_name, 'o', ''), ' ') AS TR_Trimmed_Value, 

    RTRIM(REPLACE(product_name, 'o', ''), ' ') AS Replaced_Trimmed_Value*/ 

  

FROM 

    sales     GROUP BY product_name HAVING sale_id IN (1,2,3,4,5); 

-- WHERE product_name = 'Product A'; 

  

 

Explanation: 

  

Window Functions (ROW_NUMBER, RANK, DENSE_RANK): 

  

ROW_NUMBER(), RANK(), and DENSE_RANK() are window functions that assign a unique number or rank to each row based on the sale_amount in descending order. 

FIRST_VALUE and LAST_VALUE:  

FIRST_VALUE and LAST_VALUE are window functions that retrieve the first and last sale amounts within each partition defined by product_name, ordered by sale_date. 

MAX and MIN as Window Functions:  

MAX and MIN are window functions that calculate the maximum and minimum sale amounts within each partition defined by product_name, ordered by sale_date. 

AVG and SUM as Window Functions:  

AVG and SUM are window functions that calculate the average and total sale amounts within each partition defined by product_name. 

LAG and LEAD:  

LAG and LEAD are window functions that retrieve the sale amount from the previous and next rows, respectively, based on the order of sale_date. 

 

 

 

TRIM, LTRIM, RTRIM, and REPLACE:  

TRIM removes leading and trailing characters from a string. 

LTRIM removes leading characters from a string. 

RTRIM removes trailing characters from a string. 

REPLACE replaces occurrences of a specified substring with another substring. 

The use of these functions is to manipulate the product_name values by trimming or replacing characters. 

  

Note: The TRIM(TRANSLATE(...)) part is commented out because it contains a potential error and may not work as intended. The TRANSLATE function is not standard SQL, and its usage might vary across database systems. 



-- ------------------------------------------------------------------------------------------------------------




rank() example:


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    full_name VARCHAR(100),
    salary INT
);

INSERT INTO employees (employee_id, first_name, last_name,salary)
VALUES	
    (101, 'John', 'Doe',10000),
    (102, 'Jane', 'Smith',20000),
    (103, 'John', 'Johnson',20000);
    
select * from  employees;


select first_name,last_name,rank() 
over (partition by salary  order by employee_id) as rnk 
from employees;


-- ------------------------------------------------------------------------------------------------------------



Lead() and lag() example: ( need to upderdstand more about these ())

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    full_name VARCHAR(100),
    salary INT
);

INSERT INTO employees (employee_id, first_name, last_name,salary)
VALUES	
    (101, 'John', 'Doe',10000),
    (102, 'Jane', 'Smith',20000),
    (103, 'John', 'Johnson',20000);
    
select * from  employees;

select first_name,last_name,
lead(salary) over (order by employee_id) as next_lead_empl 
from employees; 


select first_name,last_name,
lag(salary) over (order by employee_id) as next_lag_empl 
from employees;

/*

select first_name,last_name,
lead() over (partition by salary  order by employee_id) as next_lead_empl 
from employees; */ -- not working this way

CREATE TABLE your_table (
    id INT PRIMARY KEY,
    your_duplicate_column VARCHAR(50),
    other_column INT
);

-- Insert data into the table
INSERT INTO your_table (id, your_duplicate_column, other_column)
VALUES
    (1, 'DuplicateValue', 100),
    (2, 'DuplicateValue', 200),
    (3, 'UniqueValue', 300),
    (4, 'AnotherDuplicate', 400),
    (5, 'AnotherDuplicate', 500);






create or replace  VIEW view1 

as 


select id,other_column from  your_table;


select * from view1;

-- CREATE [ OR REPLACE ] VIEW name [ ( column_name [, ...] ) ] AS query [ WITH NO SCHEMA BINDING ]    

-- --------------------------------------------------------------------------------------------------------------------------- 

CREATE TABLE employee_details (
    emp_loc VARCHAR(100),
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    status VARCHAR(20)
);
INSERT INTO employee_details (emp_loc, name, salary, status)
VALUES 
    ('New York', 'John Doe', 60000.00, 'Active'),
    ('San Francisco', 'Jane Smith', 75000.00, 'Active'),
    ('Los Angeles', 'Michael Johnson', 50000.00, 'Inactive'),
    ('Chicago', 'Emily Brown', 65000.00, 'Active'),
    ('Chicago', 'Daniel Lee', 70000.00, 'Active'),
    ('Seattle', 'Emma Wilson', 62000.00, 'Active'),
    ('Dallas', 'William Martinez', 55000.00, 'Inactive'),
    ('Houston', 'Olivia Taylor', 58000.00, 'Active'),
    ('Miami', 'James Anderson', 63000.00, 'Active'),
    ('Seattle', 'Sophia Garcia', 68000.00, 'Inactive');

-- delete from employee_details where emp_loc in ('New York','Seattle');

-- truncate table employee_details;

VACUUM employee_details;

create view temp_empl as (select * from employee_details where emp_loc in ('Chicago'));

select * from temp_empl;







          
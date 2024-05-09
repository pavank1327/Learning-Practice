Sort and Dist Keys in Redshift:


CREATE TABLE employee_details (
    employee_location VARCHAR(100),
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    status VARCHAR(20)
);
INSERT INTO employee_details (employee_location, name, salary, status)
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


-- select * from employee_details;

select * from employee_details sortby(employee_location,name,salary);

-- select * from employee_details COMPOUND SORTKEY(employee_location,name,salary); -- need to work on compound sort

-- select * from employee_details interleaved SORTKEY(employee_location,name,salary); -- need to work on interleaved sort


-- --------------------------------------------------------------------------------------------------------------


-- DISTINCT:



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


-- select * from employee_details;

select distinct emp_loc,name from employee_details where salary > 50000  order by(name);
analyze compression employee_details(salary);



















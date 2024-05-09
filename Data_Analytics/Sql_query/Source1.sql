use Pavank

-- Create the stage_Employee table
drop table IF EXISTS Source_Employee

-- use PavanK
create TABLE Source_Employee
(
    [EmpNo] INT,
    [Ename] VARCHAR(MAX),
    [Esalary] MONEY,
    [EDeptID] INT,
    [Country] VARCHAR(MAX)
);

-- Insert some sample values

-- use PavanK
INSERT INTO Source_Employee ([EmpNo], [Ename], [Esalary], [EDeptID], [Country])
VALUES
    (101, 'John Doe', 50000.00, 1, 'USA'),
    (102, 'Jane Smith', 60000.00, 2, 'Canada'),
    (103, 'Bob Johnson', 55000.00, 1, 'UK'),
    (104, 'Alice Brown', 70000.00, 3, 'Australia'),
	(105, 'Alice Brain', 70000.01, 3, 'Austin');


/* use PavanK
INSERT INTO Source_Employee ([EmpNo], [Ename], [Esalary], [EDeptID], [Country])
VALUES
 (105, 'Alice Brain', 70000.01, 3, 'Austin');


use PavanK
 -- Drop the table if it exists
IF OBJECT_ID('Source_Employee', 'U') IS NOT NULL
    DROP TABLE Source_Employee;

select * from Source_Employee



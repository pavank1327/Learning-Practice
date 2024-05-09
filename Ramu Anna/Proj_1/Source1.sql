use Pavank

-- Create the stage_Employee table
CREATE TABLE Source_Employee
(
    [EmpNo] INT,
    [Ename] VARCHAR(MAX),
    [Esalary] MONEY,
    [EDeptID] INT,
    [Country] VARCHAR(MAX)
);

-- Insert some sample values
INSERT INTO Source_Employee ([EmpNo], [Ename], [Esalary], [EDeptID], [Country])
VALUES
    (101, 'John Doe', 50000.00, 1, 'USA'),
    (102, 'Jane Smith', 60000.00, 2, 'Canada'),
    (103, 'Bob Johnson', 55000.00, 1, 'UK'),
    (104, 'Alice Brown', 70000.00, 3, 'Australia');



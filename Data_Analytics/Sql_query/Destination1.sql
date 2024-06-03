use  Pavank_Dest
drop table IF EXISTS Dest_Employee

-- Create the stage_Employee table
CREATE TABLE Dest_Employee
(
    [EmpNo] INT,
    [Ename] VARCHAR(MAX),
    [Esalary] MONEY,
    [EDeptID] INT,
    [Country] VARCHAR(MAX)
);

INSERT INTO Dest_Employee ([EmpNo], [Ename], [Esalary], [EDeptID], [Country])
VALUES
    (101, 'John Doe', 50000.00, 1, 'USA'),
    (102, 'Jane Smith', 60000.00, 2, 'Canada'),
    (103, 'Bob Johnson', 55000.00, 1, 'UK'),
    (104, 'Alice Brown', 70000.00, 3, 'Australia');




/* -- Insert some sample values

USE  Pavank_Dest; -- Use the correct database name
TRUNCATE TABLE Dest_Employee;

GO
 use  Pavank_Dest
SELECT * FROM Dest_Employee;



 use Pavank_Dest
 -- Drop the table if it exists
IF OBJECT_ID('Dest_Employee', 'U') IS NOT NULL
    DROP TABLE Dest_Employee;







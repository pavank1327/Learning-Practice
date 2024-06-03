DROP TABLE EMPLOYEE;

CREATE TABLE Employee
( 
    ID INT PRIMARY KEY, -- identity(1,1), 
    FirstName Varchar(100), 
    LastName Varchar(100), 
    Country Varchar(100) 
);

Insert into Employee (ID,FirstName,LastName,Country)
values
(1,'Raj','Gupta','India');
Insert into Employee (ID,FirstName,LastName,Country)
values
(2,'Raj','Gupta','India');
Insert into Employee (ID,FirstName,LastName,Country)
values
(3,'Mohan','Kumar','USA');
Insert into Employee (ID,FirstName,LastName,Country)
values
(4,'James','Barry','UK');
Insert into Employee (ID,FirstName,LastName,Country) 
values
(5,'James','Barry','UK');
Insert into Employee (ID,FirstName,LastName,Country)
values
(6,'James','Barry','UK');

SELECT * FROM Employee;
					
								
-- SQL delete duplicate Rows using Group By and having clause	

SELECT FirstName,LastName,Country,
    COUNT(*) AS CNT
FROM Employee
GROUP BY FirstName,LastName,Country
HAVING COUNT(*) > 1;

-- We use the SQL MAX function to calculate the max id of each data row.

SELECT *
    FROM Employee
    WHERE ID NOT IN
    (
        SELECT MAX(ID)
        FROM Employee
        GROUP BY FirstName,LastName,Country
    );							
	
-- To remove this data, replace the first Select with the SQL delete statement as per the following query.

DELETE FROM Employee
    WHERE ID NOT IN
    (
        SELECT MAX(ID) AS MaxRecordID
        FROM Employee
        GROUP BY FirstName,LastName,Country
    );
   
 SELECT * FROM EMPLOYEE;
	
-- SQL delete duplicate Rows using Common Table Expressions (CTE)


WITH CTE(FirstName,LastName,Country, 
    duplicatecount)
AS (SELECT FirstName,LastName,Country ,
           ROW_NUMBER() OVER(PARTITION BY FirstName,LastName,Country
                                         
           ORDER BY id) AS DuplicateCount
    FROM employee)
SELECT *
FROM CTE;


-- We can remove the duplicate rows using the following CTE.

WITH CTE(FirstName,LastName,Country,
    DuplicateCount)
AS (SELECT FirstName,LastName,Country,
           ROW_NUMBER() OVER(PARTITION BY FirstName,LastName,Country)
                                         
           ORDER BY ID) AS DuplicateCount
    FROM Employee
DELETE FROM CTE
WHERE DuplicateCount > 1;


-- RANK function to SQL delete duplicate rows

SELECT E.ID, 
       E.firstname, 
       E.lastname, 
       E.country, 
       T.rank
FROM Employee E
INNER JOIN
(
    SELECT *, 
           RANK() OVER(PARTITION BY firstname, lastname, country ORDER BY id) AS rank
    FROM Employee
) T ON E.ID = T.ID; -- throwing error


-- another way of writing

WITH RankedEmployee AS (
    SELECT *,
           RANK() OVER(PARTITION BY firstname, lastname, country ORDER BY id) AS rank
    FROM Employee
)
SELECT E.ID, 
       E.firstname, 
       E.lastname, 
       E.country, 
       T.rank
FROM Employee E
INNER JOIN RankedEmployee T ON E.ID = T.ID;



-- we need to remove the row having a Rank greater than one

DELETE E
    FROM Employee E
         INNER JOIN
    (
        SELECT *, 
               RANK() OVER(PARTITION BY firstname, 
                                        lastname, 
                                        country
               ORDER BY id) rank
        FROM Employee
    ) T ON E.ID = t.ID
    WHERE rank > 1;
    
   
   
   
-- CTE with Oracle syntax
   
 -- CTE is supported in Oracle, so you can keep the same query structure

WITH RankedEmployee AS (
    SELECT *,
           RANK() OVER(PARTITION BY firstname, lastname, country ORDER BY id) AS rank
    FROM Employee
)
SELECT E.ID, 
       E.firstname, 
       E.lastname, 
       E.country, 
       T.rank
FROM Employee E
INNER JOIN RankedEmployee T ON E.ID = T.ID;

-- We need to adjust the DELETE statement because Oracle doesn't allow referencing the target table of the DELETE directly in the FROM clause

DELETE FROM Employee
WHERE ID IN (
    SELECT ID
    FROM (
        SELECT ID, 
               RANK() OVER(PARTITION BY firstname, lastname, country ORDER BY id) AS rank
        FROM Employee
    ) 
    WHERE rank > 1
);

SELECT * FROM Employee;

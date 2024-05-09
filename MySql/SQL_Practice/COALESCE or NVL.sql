Sure, both COALESCE and NVL are used to handle NULL values in SQL. They return the first non-null value from a list of expressions.

Syntax: COALESCE(expr1, expr2, ...)
Example: SELECT COALESCE(NULL, 5, 10); -- Output: 5

-- --------------------------------------------------------------------------------------------------------------------------------


NVL (specific to Oracle): -- in redshift this won't work need to use COALESCE instead

Syntax: NVL(expr1, expr2)
Example: SELECT NVL(NULL, 5); -- Output: 5



-- ---------------------------------------------------------------------------------------------------------------------------------

SELECT COALESCE(CAST('string' AS VARCHAR), 5);

SELECT COALESCE('string' , 5);

-- SELECT nvl('string' , 5);



-- create
CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT,
  dept TEXT NOT NULL
);

-- insert
INSERT INTO EMPLOYEE VALUES (0001, 'Clark', 'Sales');
INSERT INTO EMPLOYEE VALUES (0002, '', 'Accounting');
INSERT INTO EMPLOYEE VALUES (0003, 'Ava', 'Sales');

SELECT empId, COALESCE(name, 'Unknown') AS emp_name, dept fROM EMPLOYEE;
-- showing empty space intead of 'unknown' string

SELECT empId, COALESCE(NULLIF(name, ''), 'Unknown') AS emp_name, dept FROM EMPLOYEE;
-- showing 'unknown' string for an empty space using "nullif()"

-- Type casting and convertions:(need to work in this)


-- Type casting:

-- Create a table named 'sales'
CREATE TABLE sales (
    salesid INT PRIMARY KEY,
    saletime TIME,  -- Assuming saletime is stored as TIME for this example
    pricepaid DECIMAL(10, 2) -- for decimal values
-- pricepaid VARCHAR(20)  -- Assuming pricepaid is stored as a VARCHAR for this example
);

-- Insert data into the 'sales' table
INSERT INTO sales (salesid, saletime, pricepaid)
VALUES
    (100, CURRENT_TIME, '123.1'),
    (101, CURRENT_TIME, '456.6'),
    (102, CURRENT_TIME, '789.7');

-- Query to convert 'pricepaid' to integer for salesid=100
SELECT CAST(pricepaid AS integer) AS converted_price
FROM sales
WHERE salesid = 100; 

SELECT CAST(saletime AS TIME) as salestime_con, salesid FROM sales order by salesid limit 10;



-- SELECT CONVERT(time, saletime), salesid FROM sales order by salesid limit 10;


-----------------------------------------------------------------------

-- Create a table named 'sales'
/* CREATE TABLE sales (
    salesid INT PRIMARY KEY,
    saletime TIME,  -- Assuming saletime is stored as TIME for this example
    pricepaid DECIMAL(10, 2) -- for decimal values
-- pricepaid VARCHAR(20)  -- Assuming pricepaid is stored as a VARCHAR for this example
);

-- Insert data into the 'sales' table
INSERT INTO sales (salesid, saletime, pricepaid)
VALUES
    (100, CURRENT_TIME, '123.1'),
    (101, CURRENT_TIME, '456.6'),
    (102, CURRENT_TIME, '789.7');

-- Query to convert 'pricepaid' to integer for salesid=100 */
SELECT CAST(pricepaid AS INT) AS converted_price
FROM sales
WHERE salesid = 100;

-- Query to convert 'saletime' to TIME for salesid=100 and 101
SELECT saletime AS time_of_sale 
FROM sales
WHERE salesid IN (100, 101);

-- ----------------------------------------------------------------------------------------------
-- date cast example:

select cast('2008-02-18 02:36:48' as date) as mysaletime; -- working 

SELECT EXTRACT(DOW FROM CAST('2008-02-18 02:36:48' AS TIMESTAMP)) AS day_of_week;


SELECT EXTRACT(HOUR FROM CAST('2008-02-18 02:36:48' AS TIMESTAMP)) AS hour_of_day;

SELECT 
    EXTRACT(DOW FROM CAST('2008-02-18 02:36:48' AS TIMESTAMP)) AS day_of_week,
    EXTRACT(HOUR FROM CAST('2008-02-18 02:36:48' AS TIMESTAMP)) AS hour_of_day,
    -- Displaying the minutes:
    EXTRACT(MINUTE FROM CAST('2008-02-18 02:36:48' AS TIMESTAMP)) AS minutes;


-- -------------------------------------------------------------------------------------------------

-- convert is not directly supported in RedShift
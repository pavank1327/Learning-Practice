-- Create a simplified 'sales' table for demonstration
CREATE TABLE sales (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales (saletime, pricepaid) VALUES
    ('2008-09-01 10:30:00', 50.00),
    ('2008-09-01 15:45:00', 30.00),
    ('2008-09-05 08:15:00', 25.00),
    ('2008-09-10 12:00:00', 40.00),
    ('2008-09-12 16:20:00', 60.00);

-- Query to calculate the sum of 'pricepaid' per week in September 2008
SELECT 
    DATE_TRUNC('week', saletime) AS week_start,
    SUM(pricepaid) AS total_price
FROM 
    sales
WHERE 
    saletime::text LIKE '2008-09%'
GROUP BY 
    DATE_TRUNC('week', saletime)
ORDER BY 
    week_start;  

-- give me the output for the following query


----------------------------------------------------------------------------------

select date_trunc('week', saletime), sum(pricepaid) 

from sales where saletime like '2008-09%' 
 
group by date_trunc('week', saletime);



----------------------------------------------------------------------------------

-- answer


      week_start       | total_price
------------------------+-------------
 2008-09-01 00:00:00   |      80.00
 2008-09-08 00:00:00   |      40.00
 2008-09-15 00:00:00   |      60.00



----------------------------------------------------------------------------------------------------



-- Create a simplified 'sales' table for demonstration (POSTGRESQL)

CREATE TABLE sales (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales (saletime, pricepaid) VALUES
    ('2022-01-15 10:30:00', 50.00),
    ('2022-02-20 15:45:00', 30.00),
    ('2022-04-05 08:15:00', 25.00),
    ('2022-07-10 12:00:00', 40.00),
    ('2022-09-12 16:20:00', 60.00);

-- Query to truncate date to month, quarter, and year
SELECT 
    saletime,
 /* DATE_TRUNC('month', saletime) AS truncated_month,
    DATE_TRUNC('quarter', saletime) AS truncated_quarter,
    DATE_TRUNC('year', saletime) AS truncated_year,*/


    EXTRACT(MONTH from saletime) as currentmonth_extract,--  FROM your_table;

    EXTRACT(DAY from saletime) as currentday_extract,--  FROM your_table;

    EXTRACT(YEAR from saletime) as  currentyear_extract--  FROM your_table;


/*
    SELECT EXTRACT(MONTH from saletime) as currentmonth_extract;--  FROM your_table; -- saletime

    SELECT EXTRACT(DAY from saletime) as currentday_extract;--  FROM your_table;

    SELECT EXTRACT(YEAR from saletime) as currentyear_extract;--  FROM your_table; -- query works using extract*/


FROM 
    sales;

-- output is shown wrong using DATE_TRUNC(), but works using extract() need to work on it

-- i want month and year and date in seprate columns



Output:

+---------------------+-----------------------+---------------------+---------------------+
| saletime             | currentmonth_extract | currentday_extract | currentyear_extract |
|---------------------|-----------------------|---------------------|---------------------|
| 2022-01-15 10:30:00 | 1                     | 15                  | 2022                |
| 2022-02-20 15:45:00 | 2                     | 20                  | 2022                |
| 2022-04-05 08:15:00 | 4                     | 5                   | 2022                |
| 2022-07-10 12:00:00 | 7                     | 10                  | 2022                |
| 2022-09-12 16:20:00 | 9                     | 12                  | 2022                |
+---------------------+-----------------------+---------------------+---------------------+




-------------------------------------------------------------------------------------------------------------------------

-- month and year and date in seprate columns using EXTRACT(): (MySQL)

-- Create a simplified 'sales' table for demonstration
CREATE TABLE sales (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales (saletime, pricepaid) VALUES
    ('2022-01-15 10:30:00', 50.00),
    ('2022-02-20 15:45:00', 30.00),
    ('2022-04-05 08:15:00', 25.00),
    ('2022-07-10 12:00:00', 40.00),
    ('2022-09-12 16:20:00', 60.00);

-- Query to truncate date to month, quarter, and year
SELECT 
    saletime,
    EXTRACT(YEAR FROM saletime) AS year,
    EXTRACT(MONTH FROM saletime) AS month,
    EXTRACT(DAY FROM saletime) AS day
FROM 
    sales;
----------------------------------------------------

-- output


| saletime               | year | month | day |
|------------------------|------|-------|-----|
| 2022-01-15 10:30:00    | 2022 | 1     | 15  |
| 2022-02-20 15:45:00    | 2022 | 2     | 20  |
| 2022-04-05 08:15:00    | 2022 | 4     | 5   |
| 2022-07-10 12:00:00    | 2022 | 7     | 10  |
| 2022-09-12 16:20:00    | 2022 | 9     | 12  |


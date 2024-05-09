-- Truncate date to year
SELECT TRUNC(SYSDATE, 'YEAR') AS truncated_year FROM dual;

-- Truncate date to month
SELECT TRUNC(SYSDATE, 'MONTH') AS truncated_month FROM dual;

-- Truncate date to day
SELECT TRUNC(SYSDATE, 'DD') AS truncated_day FROM dual;

SELECT 
TRUNC(SYSDATE, 'YEAR') AS truncated_year,
TRUNC(SYSDATE, 'MONTH') AS truncated_month,
TRUNC(SYSDATE, 'DD') AS truncated_day
FROM dual;

SELECT TO_CHAR(TRUNC(SYSDATE, 'DD'), 'DD') AS truncated_day FROM dual;

SELECT TO_CHAR(TRUNC(SYSDATE, 'YEAR'), 'YYYY') AS truncated_year,
       TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'MM') AS truncated_month,
       TO_CHAR(TRUNC(SYSDATE, 'DD'), 'DD') AS truncated_day
FROM dual;

drop table sales_time;

-- Create a simplified 'sales_time' table for demonstration
CREATE TABLE sales_time (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
/*INSERT ALL INTO sales_time (saletime, pricepaid) VALUES
    ('2008-09-01 10:30:00', 50.00)
     INTO sales_time (saletime, pricepaid) VALUES
    ('2008-09-01 15:45:00', 30.00)
     INTO sales_time (saletime, pricepaid) VALUES
    ('2008-09-05 08:15:00', 25.00)
     INTO sales_time (saletime, pricepaid) VALUES
    ('2008-09-10 12:00:00', 40.00)
     INTO sales_time (saletime, pricepaid) VALUES
    ('2008-09-12 16:20:00', 60.00)
-- Repeat this process for each row...
SELECT * FROM DUAL;*/

-- another way of writing insert into Oracle
INSERT INTO sales_time (saletime, pricepaid)
SELECT TO_TIMESTAMP('2008-09-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 50.00 FROM DUAL UNION ALL
SELECT TO_TIMESTAMP('2008-09-01 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 30.00 FROM DUAL UNION ALL
SELECT TO_TIMESTAMP('2008-09-05 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 25.00 FROM DUAL UNION ALL
SELECT TO_TIMESTAMP('2008-09-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 40.00 FROM DUAL UNION ALL
SELECT TO_TIMESTAMP('2008-09-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 60.00 FROM DUAL;

select * from sales_time;

SELECT 
    TRUNC(saletime, 'WW') AS week_start,
    SUM(pricepaid) AS total_price_using_oracle
FROM 
    sales_time
WHERE 
    TO_CHAR(saletime, 'YYYY-MM') = '2008-09'
GROUP BY 
    TRUNC(saletime, 'WW')
ORDER BY 
    week_start;


/*
-- Query to calculate the sum of 'pricepaid' per week in September 2008
SELECT 
    DATE_TRUNC('week', saletime) AS week_start,
    SUM(pricepaid) AS total_price
FROM 
    sales_time
WHERE 
    saletime::text LIKE '2008-09%'
GROUP BY 
    DATE_TRUNC('week', saletime)
ORDER BY 
    week_start;  

-- give me the output for the following query


----------------------------------------------------------------------------------

select date_trunc('week', saletime), sum(pricepaid) 

from sales_time where saletime like '2008-09%' 
 
group by date_trunc('week', saletime);

----------------------------------------------------------------------------------

-- answer


      week_start       | total_price
------------------------+-------------
 2008-09-01 00:00:00   |      80.00
 2008-09-08 00:00:00   |      40.00
 2008-09-15 00:00:00   |      60.00



----------------------------------------------------------------------------------------------------



-- Create a simplified 'sales_time' table for demonstration (POSTGRESQL)

CREATE TABLE sales_time (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales_time (saletime, pricepaid) VALUES
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
    sales_time;

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

-- Create a simplified 'sales_time' table for demonstration
drop table sales_time;
CREATE TABLE sales_time (
    saletime TIMESTAMP,
    pricepaid DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales_time (saletime, pricepaid) VALUES
    ('2022-01-15 10:30:00', 50.00);
    INSERT INTO sales_time (saletime, pricepaid) VALUES
    ('2022-02-20 15:45:00', 30.00);
    INSERT INTO sales_time (saletime, pricepaid) VALUES
    ('2022-04-05 08:15:00', 25.00);
    INSERT INTO sales_time (saletime, pricepaid) VALUES
    ('2022-07-10 12:00:00', 40.00);
    INSERT INTO sales_time (saletime, pricepaid) VALUES
    ('2022-09-12 16:20:00', 60.00);

-- Query to truncate date to month, quarter, and year
SELECT 
    saletime,
    EXTRACT(YEAR FROM saletime) AS year,
    EXTRACT(MONTH FROM saletime) AS month,
    EXTRACT(DAY FROM saletime) AS day
FROM 
    sales_time;
----------------------------------------------------

-- output


| saletime               | year | month | day |
|------------------------|------|-------|-----|
| 2022-01-15 10:30:00    | 2022 | 1     | 15  |
| 2022-02-20 15:45:00    | 2022 | 2     | 20  |
| 2022-04-05 08:15:00    | 2022 | 4     | 5   |
| 2022-07-10 12:00:00    | 2022 | 7     | 10  |
| 2022-09-12 16:20:00    | 2022 | 9     | 12  |


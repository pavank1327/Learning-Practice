-- Create a sample table 

  

CREATE TABLE sample_dates ( 

    event_date TIMESTAMP 

); 

  

-- Insert sample data 

  

INSERT INTO sample_dates VALUES 

    ('2022-01-15 12:30:00'), 

    ('2022-02-20 15:45:00'), 

    ('2022-03-25 08:00:00'); 

  

-- Query to format dates 

  

/*SELECT 

    event_date, 

    TO_CHAR(event_date, 'YYYY-MM-DD') AS formatted_date, 

    TO_CHAR(event_date, 'Mon DD, YYYY HH12:MI:SS PM') AS formatted_date_time*/ 

  

SELECT TO_VARCHAR(event_date, 'YYYY-MM-DD') AS formatted_date 

  

FROM sample_dates;

  

  

-- VARCHAR() and CHAR() are not working (study)...  

 	 

-- curdate() and now() are not working (study)..	-- date is printed using date() 

  

-- time() is showing time -- but current time is not printed 

Working with dates in Amazon Redshift involves various operations such as extracting components, formatting, arithmetic, and handling time zones.  

Practice exercises: 

1. Date Arithmetic: 

Perform date arithmetic to calculate the difference between two dates and add or subtract days from a given date.   

-- Calculate the age of each user based on their birthdate 

SELECT user_id, birthdate, 

       DATEDIFF('year', birthdate, GETDATE()) AS age 

FROM user_table; 

  

-- Add 7 days to the order date  

  

SELECT order_id, order_date, 

       order_date + INTERVAL '7 days' AS new_delivery_date 

FROM orders; 

  

2. Extracting Date Components:  

Use functions to extract specific components (day, month, year, etc.) from date values.   

-- Extract the day of the week and month from the order date 

  

SELECT order_id, order_date, 

       EXTRACT(DOW FROM order_date) AS day_of_week, 

       EXTRACT(MONTH FROM order_date) AS month 

FROM orders; 

  

 

 

 

 

3. Date Formatting: 

 Format dates according to a specific format using the TO_CHAR function. 

  

-- Format the order date in 'YYYY-MM-DD' format 

  

SELECT order_id, TO_CHAR(order_date, 'YYYY-MM-DD') AS formatted_order_date 

FROM orders; 

  

4. Filtering by Date Range:  

Filter data based on a specific date range.   

   

-- Retrieve orders placed in the last 30 days 

  

SELECT order_id, order_date 

FROM orders 

WHERE order_date >= GETDATE() - INTERVAL '30 days'; 

  

5. Time Zone Conversion:  

Convert dates between different time zones.   

   

-- Convert order dates from UTC to 'America/New_York' time zone 

  

SELECT order_id, order_date, 

       CONVERT_TIMEZONE('UTC', 'America/New_York', order_date) AS est_order_date 

FROM orders; 

  

 

 

 

 

6. Handling NULL Dates:  

Handle NULL dates gracefully in your queries.  

   

-- Display 'N/A' for NULL birthdates 

  

SELECT user_id, COALESCE(TO_CHAR(birthdate, 'YYYY-MM-DD'), 'N/A') AS formatted_birthdate 

FROM user_table; 

  

7. Identify Weekdays and Weekends:  

Determine whether a date falls on a weekday or weekend.  

   

-- Classify orders as 'Weekday' or 'Weekend' 

  

SELECT order_id, order_date, 

       CASE WHEN EXTRACT(DOW FROM order_date) IN (0, 6) THEN 'Weekend' ELSE 'Weekday' END AS day_type 

FROM orders; 

 

 

Current date in redshift: 

  

SELECT GETDATE() AS current_date;  

  

DATE_TRUNC function: 

  

SELECT DATE_TRUNC('day', GETDATE()) AS current_date; 

  

This will truncate the time part, providing only the current date. Adjust the format and functions as needed based on your specific requirements. 

 

-- CORRECT DATE FORMAT.... 

  

SELECT CURRENT_DATE AS current_date;   

SELECT CURRENT_TIMESTAMP AS current_date; 

SELECT current_time AS currenttime;  

  

-- SELECT TO_CHAR(GETDATE(), 'YYYY-MM-DD HH24:MI:SS') AS current_time_with_seconds;   -- THIS IS NOT WORKING 

  

-- create a table  

CREATE TABLE students ( 

  id INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  gender TEXT NOT NULL, 

date DATE NOT NULL, 

    time  TIME NOT NULL 

); 

  

-- insert some values  

INSERT INTO students VALUES (1, 'Ryan', 'M',CURRENT_DATE,current_time); 

INSERT INTO students VALUES (2, 'Joanna', 'F',CURRENT_DATE,current_time); 

  

-- fetch some values  

SELECT * FROM students;--  WHERE gender = 'F'; 

 

- Create a table for distinct genders  

CREATE TABLE Gender AS 

SELECT DISTINCT gender 

FROM students; 

  

 

 

select * from Gender;  

  

CREATE TABLE Details AS 

SELECT DISTINCT id,name 

FROM students; 

  

CREATE TABLE DATE_DATA AS 

    SELECT distinct date 

    from students; 

 

CREATE TABLE TIME_DATA AS 

    SELECT distinct time 

    from students; 

  

select * from Details group by id; 

  

select * FROM DATE_DATA; 

Select * from TIME_DATA; 

 

 

 

 

 

 

 

 

 

 

-- displaying time,month,year and day: 

  

SELECT MONTH('2017/05/25 09:08') AS Month; 

SELECT YEAR('2017/05/25 09:08') AS Year; 

SELECT DAY('2017/05/25 09:08') AS Day; 

-- SELECT TIMEZONE_HOUR('2017/05/25 09:08') AS Hour; 

SELECT TIME('2017/05/25 09:08') AS Time; 

  

SELECT 

  HOUR('2017/05/25 09:08') AS Hours, 

  MINUTE('2017/05/25 09:08') AS Minutes, 

  SECOND('2017/05/25 09:08') AS Seconds; 

  

SELECT 

  HOUR(CURRENT_TIME) AS cHours, 

  MINUTE(CURRENT_TIME) AS cMinutes, 

  SECOND(CURRENT_TIME) AS cSeconds; 

  

-- SELECT CURRENT_TIME AT TIME ZONE 'UTC' AS curtime_utc;  

 -- select current_time AT TIME ZONE 'LOCAL' as curtime; 

  

  

  

SELECT MONTH(CURRENT_DATE) AS Month; 

SELECT YEAR(CURRENT_DATE) AS Year; 

SELECT DAY(CURRENT_DATE) AS Day; 

 

 

 

 

-- date formats in redshift: Practice  

-- create a table  

CREATE TABLE students ( 

  id INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  gender TEXT NOT NULL, 

    date DATE not null 

); 

  

-- insert some values  

INSERT INTO students VALUES (1, 'Ryan', 'M',current_date); 

INSERT INTO students VALUES (2, 'Joanna', 'F',current_date); 

  

-- fetch some values 

-- SELECT * FROM students WHERE gender = 'F'; 

  

-- DESC students;  

SHOW TABLE STATUS LIKE '%studen%';

  

SELECT DATE FROM students;  

  

 

 

 

 

 

 

 

 

 

-- trunc and trim and replace:  

 

SELECT REPLACE(DATE_FORMAT(date, '%Y-%m-%d'), '-', '/') AS replaced_date FROM students;  

-- Replace is working 

SELECT DATE_FORMAT(date, '%Y-%m-01') AS truncated_month FROM students;  

-- trinc is not working 

SELECT TRIM(LEADING '1' FROM DATE_FORMAT(date, '%d')) AS trimmed_day FROM students; 

 -- Trim is working  

  

 

/* -- Truncate to the beginning of the month 

  

-- SELECT DATE_TRUNC('month', date) AS truncated_month FROM students; 

  

-- Trim characters '0' from the beginning of the day 

  

-- SELECT TRIM(LEADING '1' FROM TO_CHAR(date, 'DD')) AS trimmed_day FROM students; 

  

-- Replace '-' with '/' in the date 

  

SELECT REPLACE(TO_CHAR(date, 'YYYY-MM-DD'), '-', '/') AS replaced_date FROM students; 

 

 

 

 

 

 

 

 

 

-- example date query: 

  

/*SELECT 

  cur_date AS current_date, 

  cur_date + CASE  

                  WHEN DOW(cur_date) IN (1,7) THEN 2  -- If current day is Sunday (1) or Saturday (7), add 2 days to skip the weekend 

                  ELSE 5  -- Otherwise, add 5 days to skip the weekend 

                END AS new_date; 

                */ 
ā
  SELECT 

  CURRENT_DATE AS current_date, 

  CURRENT_DATE + CASE  

                  WHEN EXTRACT(DOW FROM CURRENT_DATE) IN (1, 7)  

                  THEN INTERVAL '2 days'  -- If current day is Sunday (0) or Saturday (6), add 2 days to skip the weekend 

                  ELSE INTERVAL '5 days'  -- Otherwise, add 5 days to skip the weekend

                END AS new_date; 

 

 
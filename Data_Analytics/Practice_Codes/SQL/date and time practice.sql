drop table rdate;

-- Create table rdate
CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

select * from rdate;

-- Insert the current date
INSERT INTO rdate VALUES (GETDATE(), 0);

select * from rdate;


TRUNCATE table rdate;

-- Insert additional rows for demonstration. Adjust this approach as needed.
INSERT INTO rdate (original_date, days_added)

-- SELECT DATEPART(dw, 'GETDATE()'+1);

SELECT DATEADD(DAY, 1, GETDATE()) AS date_plus_2,
       CASE WHEN DATEPART(WEEKDAY, DATEADD(DAY, 1, GETDATE())) IN (1, 7) THEN 0 ELSE 2 END AS days_added
UNION ALL
SELECT DATEADD(DAY, 2, GETDATE()) AS date_plus_2,
       CASE WHEN DATEPART(WEEKDAY, DATEADD(DAY, 2, GETDATE())) IN (1, 7) THEN 0 ELSE 2 END AS days_added
UNION ALL
SELECT DATEADD(DAY, 3, GETDATE()) AS date_plus_3,
       CASE WHEN DATEPART(WEEKDAY, DATEADD(DAY, 3, GETDATE())) IN (1, 7) THEN 0 ELSE 3 END AS days_added
UNION ALL
SELECT DATEADD(DAY, 4, GETDATE()) AS date_plus_4,
       CASE WHEN DATEPART(WEEKDAY, DATEADD(DAY, 4, GETDATE())) IN (1, 7) THEN 0 ELSE 4 END AS days_added
UNION ALL
SELECT DATEADD(DAY, 5, GETDATE()) AS date_plus_5,
       CASE WHEN DATEPART(WEEKDAY, DATEADD(DAY, 5, GETDATE())) IN (1, 7) THEN 0 ELSE 5 END AS days_added;


select * from rdate;

-- Select the final result
SELECT
    original_date,
    original_date + days_added AS result_date,
    days_added
FROM
    rdate
ORDER BY
    original_date;






-- ----------------------------------------------------------------------------------------------------------------------

-- Drop tables if they exist
   
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS enrollments;

/*
DROP SEQUENCE IF EXISTS students_seq;
DROP SEQUENCE IF EXISTS courses_seq;
DROP SEQUENCE IF EXISTS enrollments_seq;
   


-- Create sequences
CREATE SEQUENCE students_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE courses_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE enrollments_seq START WITH 1 INCREMENT BY 1;*/

-- Create tables
CREATE TABLE students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE
);

CREATE TABLE courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert data into students
INSERT INTO students (first_name, last_name, date_of_birth, gender, admission_date)
VALUES ('John', 'Doe', '1990-01-15', 'M', GETDATE());

INSERT INTO students (first_name, last_name, date_of_birth, gender, admission_date)
VALUES ('Jane', 'Smith', '1992-05-20', 'F', GETDATE());

INSERT INTO students (first_name, last_name, date_of_birth, gender, admission_date)
VALUES ('Bob', 'Johnson', '1988-08-10', 'M', GETDATE());

-- Insert data into courses
INSERT INTO courses (course_name, credits)
VALUES ('Mathematics', 3);

INSERT INTO courses (course_name, credits)
VALUES ('History', 4);

INSERT INTO courses (course_name, credits)
VALUES ('Computer Science', 5);

-- Insert data into enrollments
INSERT INTO enrollments ( student_id, course_id, enrollment_date, grade)
VALUES
    ( 1, 1, '2022-01-10', 'A'),
    (1, 2, '2022-01-15', 'B'),
    ( 2, 3, '2022-02-01', 'A'),
    ( 3, 1, '2022-02-10', 'C');

-- Select statements
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- Select with calculated age
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    EXTRACT(YEAR FROM cur_date) - EXTRACT(YEAR FROM date_of_birth) AS age
FROM
    students;

-- Select with age filter
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        admission_date,
        EXTRACT(YEAR FROM cur_date) - EXTRACT(YEAR FROM date_of_birth) AS age
    FROM
        students
)
WHERE
    EXTRACT(YEAR FROM cur_date) - EXTRACT(YEAR FROM date_of_birth) >= 18;

-- Drop table StudentEnrollmentInfo if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE StudentEnrollmentInfo';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Create table StudentEnrollmentInfo
CREATE TABLE StudentEnrollmentInfo AS
SELECT
    s.student_id,
    s.admission_date,
    e.enrollment_date,
    EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date) AS gap_data,
    COALESCE(EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date), 0) AS total_days,
    CASE
        WHEN EXTRACT(DAY FROM s.admission_date) = 1 
        THEN COALESCE(EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date), 0) - 1
        ELSE COALESCE(EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date), 0)
    END AS days_after_adjusted
FROM
    students s
JOIN
    enrollments e ON s.student_id = e.student_id
WHERE EXTRACT(YEAR FROM cur_date) - EXTRACT(YEAR FROM s.date_of_birth) >= 18
    AND EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date) <> 1;

-- Select from StudentEnrollmentInfo
SELECT * FROM StudentEnrollmentInfo se;

-- Adjusted days select
SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN TO_CHAR(se.admission_date, 'D') = 1 
        THEN se.total_days - 1
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

-- Truncate table StudentEnrollmentInfo
TRUNCATE TABLE StudentEnrollmentInfo;

-- Verify truncation and select
SELECT * FROM StudentEnrollmentInfo se;
SELECT * FROM students;
SELECT * FROM enrollments;

-- Check if enrollments table is empty
SELECT CASE WHEN COUNT(*) = 0 THEN 'yes' ELSE 'no' END AS is_table_empty FROM enrollments;

-- Check if StudentEnrollmentInfo table is empty
SELECT CASE WHEN COUNT(*) = 0 THEN 'yes' ELSE 'no' END AS is_table_empty FROM StudentEnrollmentInfo;

-- Select from courses
SELECT * FROM courses;

   
   
TRUNCATE TABLE enrollments;
SELECT * FROM students;
SELECT * FROM enrollments;
select case when count(*) = 0 then 'yes'else 'no'end as is_table_empty from enrollments;
SELECT * FROM courses;
SELECT * FROM courses;


-- -----------------------------------------------------------------------------------------------------------------------------------------

-- PostgreSQL(working) 

-- getting date details as day and day name e.t.c......

-- SELECT ISODOW('2022-02-23'::DATE) AS iso_day_of_week; (this is not working)


SELECT EXTRACT(ISODOW FROM cur_date) AS iso_day_of_week; -- get day of the date 

SELECT EXTRACT(ISODOW FROM '2022-02-23') AS iso_day_of_week; 

SELECT to_char(cur_date, 'Day') AS day_name; -- get day name

SELECT CURRENT_TIMESTAMP  AS out_cur_datetime;

-- Current date
SELECT cur_date AS our_currentdate;

-- Current time
SELECT cur_time AS our_currenttime;


-- SELECT GETDATE() AS cur_datetime; (redshift query)



-- -----------------------------------------------------------------------------------------------------------------------------------------

-- test this showing 1 hour more than current time.

SELECT NOW() AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Calcutta' AS IST_time;

SELECT cur_timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Calcutta' AS "Asia/Chennai_time";





-- Get the current system date
SELECT GETDATE();

-- Get the date 10 days from the current system date
SELECT GETDATE() + 10 AS "10 days from now";

-- Get the next Tuesday from a specific date (15-OCT-2024)
SELECT DATEADD(DAY, (DATEDIFF(DAY, 0, DATEADD(DAY, (3 + 7 - DATEPART(WEEKDAY, '2024-10-15')) % 7, '2024-10-15')) + 1) % 7, '2024-10-15') AS "NEXT TUE DAY from 15-OCT";

-- Get the next Tuesday from the current system date
SELECT DATEADD(DAY, (DATEDIFF(DAY, 0, DATEADD(DAY, (3 + 7 - DATEPART(WEEKDAY, GETDATE())) % 7, GETDATE())) + 1) % 7, GETDATE()) AS "NEXT TUE DAY from GETDATE";

-- Get the next Tuesday from 10 days before the current system date
SELECT DATEADD(DAY, (DATEDIFF(DAY, 0, DATEADD(DAY, (3 + 7 - DATEPART(WEEKDAY, GETDATE() - 10)) % 7, GETDATE() - 10)) + 1) % 7, GETDATE() - 10) AS "NEXT TUE DAY from GETDATE - 10";

-- Get the next Monday from 10 days before the current system date
SELECT DATEADD(DAY, (DATEDIFF(DAY, 0, DATEADD(DAY, (2 + 7 - DATEPART(WEEKDAY, GETDATE() - 10)) % 7, GETDATE() - 10)) + 1) % 7, GETDATE() - 10) AS "NEXT MON DAY from GETDATE - 10";

-- Get the next Monday from the current system date
SELECT DATEADD(DAY, (DATEDIFF(DAY, 0, DATEADD(DAY, (2 + 7 - DATEPART(WEEKDAY, GETDATE())) % 7, GETDATE())) + 1) % 7, GETDATE()) AS "NEXT MON DAY from GETDATE";

-- Get the date 3 days before the current system date and format the date components
SELECT 
    CAST(GETDATE() - 3 AS DATE) AS date_before_3,
    DATEPART(DAY, GETDATE() - 3) AS day_before_3,
    DATEPART(MONTH, GETDATE() - 3) AS month_before_3,
    DATEPART(YEAR, GETDATE() - 3) AS year_before_3;

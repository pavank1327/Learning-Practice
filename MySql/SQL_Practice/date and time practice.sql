-- SQL query:  (working correctly)

CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

-- Insert the current date. Adjust CURRENT_DATE according to your SQL dialect.

INSERT INTO rdate VALUES (DATE('now'), 0);

-- Insert additional rows for demonstration. Adjust this approach as needed.

INSERT INTO rdate (original_date, days_added)

SELECT DATE('now', '+1 day'), CASE WHEN strftime('%w', DATE('now', '+1 day')) IN ('0', '6') THEN 0 ELSE 1 END
UNION ALL
SELECT DATE('now', '+2 days'), CASE WHEN strftime('%w', DATE('now', '+2 days')) IN ('0', '6') THEN 0 ELSE 2 END
UNION ALL
SELECT DATE('now', '+3 days'), CASE WHEN strftime('%w', DATE('now', '+3 days')) IN ('0', '6') THEN 0 ELSE 3 END
UNION ALL
SELECT DATE('now', '+4 days'), CASE WHEN strftime('%w', DATE('now', '+4 days')) IN ('0', '6') THEN 0 ELSE 4 END
UNION ALL
SELECT DATE('now', '+5 days'), CASE WHEN strftime('%w', DATE('now', '+5 days')) IN ('0', '6') THEN 0 ELSE 5 END;

-- Select the final result
SELECT
    original_date,
    DATE(original_date, '+' || days_added || ' days') AS result_date,
    days_added
FROM
    rdate
ORDER BY
    original_date;




-- ----------------------------------------------------------------------------------------------------------------------------


--  MySQL (working correctly) 

CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

-- Insert initial record
INSERT INTO rdate VALUES (CURDATE(), 0);

-- Generate numbers from 1 to 5
INSERT INTO rdate (original_date, days_added)
SELECT 
    CURDATE() + INTERVAL n DAY,
    CASE 
        WHEN DAYOFWEEK(CURDATE() + INTERVAL n DAY) IN (1, 7) THEN 0
        ELSE n
    END
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL 
    SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers
WHERE 
    n <= 5;

-- Select the final result
SELECT 
    original_date,
    original_date + INTERVAL days_added DAY AS result_date, days_added
FROM 
    rdate
ORDER BY 
    original_date;



-- ------------------------------------------------------------------------------------------------------------------------------


-- another example:   MYSql (working correctly)


CREATE TABLE datedata (
    original_date DATE,
    days_added INT
);

-- Insert initial record
INSERT INTO datedata VALUES (CURDATE(), 0);

-- Generate numbers from 1 to 5
INSERT INTO datedata (original_date, days_added)
SELECT 
    CURDATE() + INTERVAL n DAY,
    CASE 
        WHEN DAYOFWEEK(CURDATE() + INTERVAL n DAY) IN (1, 7) THEN 0
        ELSE n
    END
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL 
    SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers
WHERE 
    n <= 5;

-- Select the final result
SELECT 
    -- original_date,
    -- original_date + INTERVAL days_added DAY AS result_date,
    -- days_added,
    DAYOFWEEK(original_date),
    DAYOFWEEK(original_date + INTERVAL days_added DAY) AS updated_day_of_week
FROM 
    datedata
ORDER BY 
    original_date;



-- ----------------------------------------------------------------------------------------------------------------------

-- MySQL:(working correctly)

-- Create tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample data
INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender, admission_date)
VALUES
    (1, 'John', 'Doe', '1990-01-15', 'M', CURRENT_DATE),
    (2, 'Jane', 'Smith', '1992-05-20', 'F', CURRENT_DATE),
    (3, 'Bob', 'Johnson', '1988-08-10', 'M', CURRENT_DATE);

INSERT INTO courses (course_id, course_name, credits)
VALUES
    (101, 'Mathematics', 3),
    (102, 'History', 4),
    (103, 'Computer Science', 5);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES
    (1001, 1, 101, '2022-01-10', 'A'),
    (1002, 1, 102, '2022-01-15', 'B'),
    (1003, 2, 103, '2022-02-01', 'A'),
    (1004, 3, 101, '2022-02-10', 'C');

-- Calculate age of students
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    YEAR(CURRENT_DATE) - YEAR(date_of_birth) AS age
FROM
    students;

-- Filter students by age
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        admission_date,
        YEAR(CURRENT_DATE) - YEAR(date_of_birth) AS age
    FROM
        students
) AS subquery
WHERE
    age >= 18;




/*-- Retrieve Details of Students with Admission Date Within 1 Year of Enrollment
-- Create a new table StudentEnrollmentInfo

CREATE TABLE StudentEnrollmentInfo AS
SELECT
     s.student_id,
     s.admission_date,
     e.enrollment_date,
     YEAR(e.enrollment_date) - YEAR(s.admission_date) AS total_days,
     CASE
         WHEN DAYOFWEEK(s.admission_date) = 1 THEN YEAR(e.enrollment_date) - YEAR(s.admission_date) - 1
         ELSE YEAR(e.enrollment_date) - YEAR(s.admission_date)
     END AS days_after_adjusted
FROM
    students s
JOIN
    enrollments e ON s.student_id = e.student_id
WHERE
     YEAR(e.enrollment_date) - YEAR(s.admission_date) < 1;*/

-- if the above select throws the following error 

/*BIGINT UNSIGNED value is out of range in 
'(year(`mycompiler`.`e`.`enrollment_date`) - year(`mycompiler`.`s`.`admission_date`))'*/





-- Retrieve details of students with admission date within 1 year of enrollment
-- Create a new table StudentEnrollmentInfo

CREATE TABLE StudentEnrollmentInfo AS
SELECT
    s.student_id,
    s.admission_date,
    e.enrollment_date,
    IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) AS total_days,
    CASE
        WHEN DAYOFWEEK(s.admission_date) = 1 THEN IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) - 1
        ELSE IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0)
    END AS days_after_adjusted
FROM
    students s
JOIN
    enrollments e ON s.student_id = e.student_id
WHERE
    IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) < 1;

-- Select data from StudentEnrollmentInfo
SELECT * FROM StudentEnrollmentInfo se;

-- Select specific columns from StudentEnrollmentInfo with adjusted days
SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN DAYOFWEEK(se.admission_date) = 1 THEN se.total_days - 1
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

-- Truncate tables (Optional)
-- Truncate tables if needed
TRUNCATE TABLE enrollments;
-- TRUNCATE TABLE courses;
-- TRUNCATE TABLE students;

-- Select data from tables
SELECT * FROM students;
SELECT * FROM enrollments;
SELECT * FROM courses;



-- ----------------------------------------------------------------------------------------------------------------------------------------

-- code without comments

CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

INSERT INTO rdate VALUES (DATE('now'), 0);

INSERT INTO rdate (original_date, days_added)
SELECT DATE('now', '+1 day'), CASE WHEN strftime('%w', DATE('now', '+1 day')) IN ('0', '6') THEN 0 ELSE 1 END
UNION ALL
SELECT DATE('now', '+2 days'), CASE WHEN strftime('%w', DATE('now', '+2 days')) IN ('0', '6') THEN 0 ELSE 2 END
UNION ALL
SELECT DATE('now', '+3 days'), CASE WHEN strftime('%w', DATE('now', '+3 days')) IN ('0', '6') THEN 0 ELSE 3 END
UNION ALL
SELECT DATE('now', '+4 days'), CASE WHEN strftime('%w', DATE('now', '+4 days')) IN ('0', '6') THEN 0 ELSE 4 END
UNION ALL
SELECT DATE('now', '+5 days'), CASE WHEN strftime('%w', DATE('now', '+5 days')) IN ('0', '6') THEN 0 ELSE 5 END;

SELECT
    original_date,
    DATE(original_date, '+' || days_added || ' days') AS result_date,
    days_added
FROM
    rdate
ORDER BY
    original_date;

CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

INSERT INTO rdate VALUES (CURDATE(), 0);

INSERT INTO rdate (original_date, days_added)
SELECT 
    CURDATE() + INTERVAL n DAY,
    CASE 
        WHEN DAYOFWEEK(CURDATE() + INTERVAL n DAY) IN (1, 7) THEN 0
        ELSE n
    END
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL 
    SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers
WHERE 
    n <= 5;

SELECT 
    original_date,
    original_date + INTERVAL days_added DAY AS result_date, days_added
FROM 
    rdate
ORDER BY 
    original_date;

CREATE TABLE datedata (
    original_date DATE,
    days_added INT
);

INSERT INTO datedata VALUES (CURDATE(), 0);

INSERT INTO datedata (original_date, days_added)
SELECT 
    CURDATE() + INTERVAL n DAY,
    CASE 
        WHEN DAYOFWEEK(CURDATE() + INTERVAL n DAY) IN (1, 7) THEN 0
        ELSE n
    END
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL 
    SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers
WHERE 
    n <= 5;

SELECT 
    DAYOFWEEK(original_date),
    DAYOFWEEK(original_date + INTERVAL days_added DAY) AS updated_day_of_week
FROM 
    datedata
ORDER BY 
    original_date;



-- ------------------------------------------------------------------------------------------------------
-- MySQL code(working)


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender, admission_date)
VALUES
    (1, 'John', 'Doe', '1990-01-15', 'M', CURRENT_DATE),
    (2, 'Jane', 'Smith', '1992-05-20', 'F', CURRENT_DATE),
    (3, 'Bob', 'Johnson', '1988-08-10', 'M', CURRENT_DATE);

INSERT INTO courses (course_id, course_name, credits)
VALUES
    (101, 'Mathematics', 3),
    (102, 'History', 4),
    (103, 'Computer Science', 5);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES
    (1001, 1, 101, '2022-01-10', 'A'),
    (1002, 1, 102, '2022-01-15', 'B'),
    (1003, 2, 103, '2022-02-01', 'A'),
    (1004, 3, 101, '2022-02-10', 'C');

SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    YEAR(CURRENT_DATE) - YEAR(date_of_birth) AS age
FROM
    students;

SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        admission_date,
        YEAR(CURRENT_DATE) - YEAR(date_of_birth) AS age
    FROM
        students
) AS subquery
WHERE
    age >= 18;

CREATE TABLE StudentEnrollmentInfo AS
SELECT
    s.student_id,
    s.admission_date,
    e.enrollment_date,
    IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) AS total_days,
    CASE
        WHEN DAYOFWEEK(s.admission_date) = 1 THEN IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) - 1
        ELSE IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0)
    END AS days_after_adjusted
FROM
    students s
JOIN
    enrollments e ON s.student_id = e.student_id
WHERE
    IFNULL(YEAR(e.enrollment_date), 0) - IFNULL(YEAR(s.admission_date), 0) < 1;

SELECT * FROM StudentEnrollmentInfo se;

SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN DAYOFWEEK(se.admission_date) = 1 THEN se.total_days - 1
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

TRUNCATE TABLE enrollments;
SELECT * FROM students;
SELECT * FROM enrollments;
SELECT * FROM courses;



-- -------------------------------------------------------------------------------------------------------------------------------------------	

-- PostgreSQL code (working)

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (first_name, last_name, date_of_birth, gender, admission_date)
VALUES
    ('John', 'Doe', '1990-01-15', 'M', CURRENT_DATE),
    ('Jane', 'Smith', '1992-05-20', 'F', CURRENT_DATE),
    ('Bob', 'Johnson', '1988-08-10', 'M', CURRENT_DATE);

INSERT INTO courses (course_name, credits)
VALUES
    ('Mathematics', 3),
    ('History', 4),
    ('Computer Science', 5);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES
    (1, 1, '2022-01-10', 'A'),
    (1, 2, '2022-01-15', 'B'),
    (2, 3, '2022-02-01', 'A'),
    (3, 1, '2022-02-10', 'C');

SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS age
FROM
    students;

SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        admission_date,
        EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS age
    FROM
        students
) AS subquery
WHERE
    age >= 18;

CREATE TABLE StudentEnrollmentInfo AS
SELECT
    s.student_id,
    s.admission_date,
    e.enrollment_date,
    COALESCE(EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date), 0) AS total_days,
    CASE
        WHEN EXTRACT(ISODOW FROM s.admission_date) = 1 
	THEN COALESCE(EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date), 0) - 1
        ELSE COALESCE(EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date), 0)
    END AS days_after_adjusted
FROM
    students s
JOIN
    enrollments e ON s.student_id = e.student_id
WHERE
    COALESCE(EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date), 0) < 1;

SELECT * FROM StudentEnrollmentInfo se;

SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN EXTRACT(ISODOW FROM se.admission_date) = 1 
	THEN se.total_days - 1
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

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


SELECT EXTRACT(ISODOW FROM CURRENT_DATE::DATE) AS iso_day_of_week; -- get day of the date 

SELECT EXTRACT(ISODOW FROM '2022-02-23'::DATE) AS iso_day_of_week; 

SELECT to_char(CURRENT_DATE::DATE, 'Day') AS day_name; -- get day name

SELECT CURRENT_TIMESTAMP AS current_datetime;

-- Current date
SELECT CURRENT_DATE AS current_date;

-- Current time
SELECT CURRENT_TIME AS current_time;


-- SELECT GETDATE() AS current_datetime; (redshift query)



-- -----------------------------------------------------------------------------------------------------------------------------------------

-- test this showing 1 hour more than current time.

SELECT NOW() AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Calcutta' AS IST_time;

SELECT current_timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Calcutta' AS "Asia/Chennai_time";

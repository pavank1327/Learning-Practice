/*-- SELECT COALESCE(NULL, 5, 10); -- Output: 5
-- -------------------------------------------------------------------------------
-- SELECT NVL(NULL, 5); -- Output: 5

-- Create Schema and Tables:   (Redshift/postgreSQL - working correctly)

-- CREATE SCHEMA student_info;
-- SET search_path TO student_info, public;

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
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    grade CHAR(1)
);


-- Insert Sample Data:


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


-- Calculate Age of Students:

SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS age
FROM
    students;


-- Filter Students by Age:

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


-- Retrieve Details of Students with Admission Date Within 1 Year of Enrollment:

WITH StudentEnrollmentInfo AS (
    SELECT
        s.student_id,
        s.admission_date,
        e.enrollment_date,
        EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date) AS total_days
    FROM
        students s
    JOIN
        enrollments e ON s.student_id = e.student_id
    WHERE
        EXTRACT(YEAR FROM e.enrollment_date) - EXTRACT(YEAR FROM s.admission_date) < 1
)

SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN EXTRACT(DOW FROM se.admission_date) = 0 THEN se.total_days - 1
        WHEN EXTRACT(DOW FROM se.admission_date) = 6 THEN se.total_days - 2
        WHEN EXTRACT(DOW FROM se.enrollment_date) = 0 THEN se.total_days - 1
        WHEN EXTRACT(DOW FROM se.enrollment_date) = 6 THEN se.total_days - 2
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;


-- Truncate Tables (Optional):

-- Truncate tables if needed
Truncate table enrollments CASCADE;
-- Truncate table courses CASCADE;
-- Truncate table students CASCADE;
	
select * from students;
select * from enrollments; 
select * from  courses;


CREATE TABLE credit_ids AS SELECT credits FROM courses;
    
select * From credit_ids;

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- MySQL working correctly 

-- Create Schema and Tables:
-- CREATE SCHEMA IF NOT EXISTS student_info;
-- USE student_info;

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

-- Insert Sample Data:
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

-- Calculate Age of Students:
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
        -- admission_date,extract(year from age(CURRENT_DATE, date_of_birth)) as age (work with postgre sql)
        -- AGE(CURRENT_DATE - date_of_birth) AS age
    YEAR(CURRENT_DATE()) - YEAR(date_of_birth) AS age
FROM
    students;

-- Filter Students by Age:
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        -- admission_date,extract(year from age(CURRENT_DATE, date_of_birth)) as age (work with postgre sql)
        YEAR(CURRENT_DATE()) - YEAR(date_of_birth) AS age
    FROM
        students
) AS subquery
WHERE
    age >= 18;

-- Retrieve Details of Students with Admission Date Within 1 Year of Enrollment:
WITH StudentEnrollmentInfo AS (
    SELECT
        s.student_id,
        s.admission_date,
        e.enrollment_date,
        YEAR(e.enrollment_date) - YEAR(s.admission_date) AS total_days    -- throws error in this statement as BIGINT UNSIGNED value is out of range
    FROM
        students s
    JOIN
        enrollments e ON s.student_id = e.student_id
    WHERE
        YEAR(e.enrollment_date) - YEAR(s.admission_date) < 1
)

SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN DAYOFWEEK(se.admission_date) = 1 THEN se.total_days - 1
        WHEN DAYOFWEEK(se.admission_date) = 7 THEN se.total_days - 2
        WHEN DAYOFWEEK(se.enrollment_date) = 1 THEN se.total_days - 1
        WHEN DAYOFWEEK(se.enrollment_date) = 7 THEN se.total_days - 2
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

-- Truncate Tables (Optional):
TRUNCATE TABLE enrollments;
-- TRUNCATE TABLE courses;
-- TRUNCATE TABLE students;

-- Select Data from Tables:
SELECT * FROM students;
SELECT * FROM enrollments;
SELECT * FROM courses;


CREATE TABLE credit_ids AS SELECT credits FROM courses;
    
select * From credit_ids;

-- ----------------------------------------------------------------------------------------------------------------

-- ERROR 1690 (22003) at line 78: BIGINT UNSIGNED value is out of range in 
-- '(year(`mycompiler`.`e`.`enrollment_date`) - year(`mycompiler`.`s`.admission_date`))'

-- then try this ( TIMESTAMPDIFF instead of year while working with dates) (MySQL)


-- Create Schema and Tables:
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

-- Insert Sample Data:
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

-- Calculate Age of Students:
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    admission_date,
    YEAR(CURRENT_DATE()) - YEAR(date_of_birth) AS age
FROM
    students;

-- Filter Students by Age:
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        date_of_birth,
        admission_date,
        YEAR(CURRENT_DATE()) - YEAR(date_of_birth) AS age
    FROM
        students
) AS subquery
WHERE
    age >= 18;

-- Retrieve Details of Students with Admission Date Within 1 Year of Enrollment:
WITH StudentEnrollmentInfo AS (
    SELECT
        s.student_id,
        s.admission_date,
        e.enrollment_date,
        TIMESTAMPDIFF(YEAR, s.admission_date, e.enrollment_date) AS total_days
    FROM
        students s
    JOIN
        enrollments e ON s.student_id = e.student_id
    WHERE
        TIMESTAMPDIFF(YEAR, s.admission_date, e.enrollment_date) < 1
)

SELECT
    se.student_id,
    se.admission_date,
    se.enrollment_date,
    se.total_days,
    CASE
        WHEN DAYOFWEEK(se.admission_date) = 1 THEN se.total_days - 1
        WHEN DAYOFWEEK(se.admission_date) = 7 THEN se.total_days - 2
        WHEN DAYOFWEEK(se.enrollment_date) = 1 THEN se.total_days - 1
        WHEN DAYOFWEEK(se.enrollment_date) = 7 THEN se.total_days - 2
        ELSE se.total_days
    END AS days_after_adjusted
FROM
    StudentEnrollmentInfo se;

-- Truncate Tables (Optional):
TRUNCATE TABLE enrollments;
-- TRUNCATE TABLE courses;
-- TRUNCATE TABLE students;

-- Select Data from Tables:
SELECT * FROM students;
SELECT * FROM enrollments;
SELECT * FROM courses;


CREATE TABLE credit_ids AS SELECT course_id,credits FROM courses;
    
select * From credit_ids;

desc credit_ids;

SELECT LAST_VALUE(credits) OVER (order by course_id) AS last_credit FROM credit_ids;

SELECT FIRST_VALUE(credits) OVER (order by course_id) AS first_credit FROM credit_ids; 

SELECT LAST_VALUE(credits) OVER (PARTITION BY credits order by course_id) AS last_credit FROM credit_ids;

SELECT FIRST_VALUE(credits) OVER (PARTITION BY credits order by course_id) AS first_credit FROM credit_ids;

-- need to work on first_value() and Last_value()



-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Another Example:using limit and count

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    full_name VARCHAR(100)
);

INSERT INTO employees (employee_id, first_name, last_name)
VALUES	
    (101, 'John', 'Doe'),
    (102, 'Jane', 'Smith'),
    (103, 'John', 'Johnson');


UPDATE employees
SET full_name = first_name || ' ' || last_name
WHERE employee_id IN (101, 102, 103);

select * from employees limit (select count(employee_id) - 2 from employees);--  where employee_id in (101,102,103);

select * from employees limit (select count(*) - 0 from employees); -- using count of all in table

select  distinct first_name from employees limit (select count(*) - 0 from employees); -- using count of all in table with distinct column


select  distinct -- employee_id,

first_name, last_name 

from employees limit (select count(*) - 0 from employees);
*/


-- --------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT NOT NULL
);
-- insert some values
INSERT INTO students VALUES (123, 'Ryan', 'M');
INSERT INTO students VALUES (234, 'Joanna', 'F');
-- fetch some values
-- SELECT * FROM students WHERE gender = 'M';

alter table students add column rank INTEGER;

INSERT INTO students VALUES (456, 'Ryan', 'M',27);

update  students set rank = 13 where id in (123);
update  students set rank = 16 where id in (234);

SELECT * FROM students;--  WHERE gender = 'M';
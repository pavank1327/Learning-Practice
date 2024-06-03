-- SQL query:  (working correctly)
DROP TABLE RDATE; 


CREATE TABLE rdate (
    original_date DATE,
    days_added INT
);

-- Insert the current date. Adjust CURRENT_DATE according to your SQL dialect.

-- INSERT INTO rdate VALUES (DATE('now'), 0);

-- Insert additional rows for demonstration. Adjust this approach as needed.

/*
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
*/

INSERT INTO rdate (original_date, days_added)
SELECT TRUNC(SYSDATE) + LEVEL AS original_date,
       CASE 
           WHEN TO_CHAR(TRUNC(SYSDATE) + LEVEL, 'D') IN (1, 7) THEN 0 
           ELSE LEVEL 
       END AS days_added
FROM dual
CONNECT BY LEVEL <= 5;


SELECT * FROM rdate;


SELECT
    original_date,
    original_date + days_added AS result_date,
    days_added
FROM
    rdate
ORDER BY
    original_date;



-- Select the final result
SELECT
    original_date,
    DATE(original_date, '+' || days_added || ' days') AS result_date,
    days_added
FROM
    rdate
ORDER BY
    original_date;




-- ----------------------------------------------------------------------------------------------------------------------




DROP TABLE students;
DROP TABLE courses;
DROP TABLE enrollments;
-- drop table tabnam;

DROP SEQUENCE students_seq;
DROP SEQUENCE courses_seq;
DROP SEQUENCE enrollments_seq;

CREATE SEQUENCE students_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE courses_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE enrollments_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE
);

CREATE TABLE courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100),
    credits NUMBER
);

CREATE TABLE enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender, admission_date)
VALUES (students_seq.NEXTVAL, 'John', 'Doe', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'M', CURRENT_DATE);

INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender, admission_date)
VALUES (students_seq.NEXTVAL, 'Jane', 'Smith', TO_DATE('1992-05-20', 'YYYY-MM-DD'), 'F', CURRENT_DATE);

INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender, admission_date)
VALUES (students_seq.NEXTVAL, 'Bob', 'Johnson', TO_DATE('1988-08-10', 'YYYY-MM-DD'), 'M', CURRENT_DATE);

INSERT   
    INTO courses (course_id, course_name, credits)
    VALUES(courses_seq.NEXTVAL, 'Mathematics', 3);
   INSERT INTO courses (course_id, course_name, credits)
    VALUES(courses_seq.NEXTVAL, 'History', 4);
   INSERT INTO courses (course_id, course_name, credits)
    VALUES(courses_seq.NEXTVAL, 'Computer Science', 5);

INSERT  
    INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
    VALUES(enrollments_seq.NEXTVAL, 1, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'A');
    INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
    VALUES(enrollments_seq.NEXTVAL, 1, 2, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'B');
    INSERT INTO enrollments(enrollment_id, student_id, course_id, enrollment_date, grade)
    VALUES(enrollments_seq.NEXTVAL, 2, 3, TO_DATE('2022-02-01', 'YYYY-MM-DD'), 'A');
    INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
    VALUES(enrollments_seq.NEXTVAL, 3, 1, TO_DATE('2022-02-10', 'YYYY-MM-DD'), 'C');

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

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
)
WHERE
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) >= 18; -- working
 
Drop table StudentEnrollmentInfo;
 
CREATE TABLE StudentEnrollmentInfo AS
SELECT
    s.student_id,
    s.admission_date,
    e.enrollment_date,
    EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date) as gap_data,
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
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM s.date_of_birth) >= 18
    and EXTRACT(YEAR FROM s.admission_date) - EXTRACT(YEAR FROM e.enrollment_date) <> 1; -- working 


SELECT * FROM StudentEnrollmentInfo se;

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

TRUNCATE TABLE StudentEnrollmentInfo;
SELECT * FROM StudentEnrollmentInfo se;
SELECT * FROM students;
SELECT * FROM enrollments;
SELECT CASE WHEN COUNT(*) = 0 THEN 'yes' ELSE 'no' END AS is_table_empty FROM enrollments;
SELECT CASE WHEN COUNT(*) = 0 THEN 'yes' ELSE 'no' END AS is_table_empty FROM StudentEnrollmentInfo;
SELECT * FROM courses;



SELECT datediff(YEAR,'2017/10/12','2019/10/12') AS no_of_years; -- this is not working in oracle

SELECT FLOOR(MONTHS_BETWEEN(TO_DATE('2019-10-12', 'YYYY-MM-DD'), TO_DATE('2017-10-12', 'YYYY-MM-DD')) / 12) AS no_of_years
FROM dual;

SELECT SYSDATE FROM dual;

SELECT SYSDATE + 10 "10 days from now" FROM dual;

SELECT NEXT_DAY('15-OCT-2024','TUESDAY') "NEXT TUE DAY from 15-OCT"
  FROM DUAL;
 
 SELECT NEXT_DAY(SYSDATE,'TUESDAY') "NEXT TUE DAY from SYSDATE"
  FROM DUAL;
 
SELECT NEXT_DAY(SYSDATE -10,'TUESDAY') "NEXT TUE DAY from SYSDATE - 10"
  FROM DUAL;
 
 SELECT NEXT_DAY(SYSDATE -10,'Monday') "NEXT MON DAY from SYSDATE - 10"
  FROM DUAL;
 
  SELECT NEXT_DAY(SYSDATE,'Monday') "NEXT MON DAY from SYSDATE"
  FROM DUAL;
 
 -- to get the specified day of week based on given date


 
SELECT 
    TRUNC(SYSDATE - 3) AS date_before_3,
    TO_CHAR(TRUNC(SYSDATE - 3), 'DD') AS day_before_3,
    TO_CHAR(TRUNC(SYSDATE - 3), 'MM') AS month_before_3,
    TO_CHAR(TRUNC(SYSDATE - 3), 'YYYY') AS year_before_3
FROM dual;


/*
SELECT 
    DATE_TRUNC('day', CURRENT_DATE - INTERVAL '3 days') AS date_before_3,
    EXTRACT(day FROM DATE_TRUNC('day', CURRENT_DATE - INTERVAL '3 days')) AS day_before_3,
    EXTRACT(month FROM DATE_TRUNC('day', CURRENT_DATE - INTERVAL '3 days')) AS month_before_3,
    EXTRACT(year FROM DATE_TRUNC('day', CURRENT_DATE - INTERVAL '3 days')) AS year_before_3;
    
    -- works with redshift
 */
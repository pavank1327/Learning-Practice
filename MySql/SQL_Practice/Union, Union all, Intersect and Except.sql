-- Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1)
);

-- Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert Sample Data into Students Table
INSERT INTO students (student_id, first_name, last_name, date_of_birth, gender)
VALUES
    (1, 'John', 'Doe', '1990-01-15', 'M'),
    (2, 'Jane', 'Smith', '1992-05-20', 'F'),
    (3, 'Bob', 'Johnson', '1988-08-10', 'M');

-- Insert Sample Data into Courses Table
INSERT INTO courses (course_id, course_name, credits)
VALUES
    (101, 'Mathematics', 3),
    (102, 'History', 4),
    (103, 'Computer Science', 5);

-- Insert Sample Data into Enrollments Table
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES
    (1001, 1, 101, '2022-01-10', 'A'),
    (1002, 1, 102, '2022-01-15', 'B'),
    (1003, 2, 103, '2022-02-01', 'A'),
    (1004, 3, 104, '2022-02-10', 'C'),
    (1005, 4, 104, '2022-02-11', 'D');
    
select * from courses;
    
    -- Query to retrieve unique course names from enrollments table
SELECT course_id FROM courses
UNION
SELECT course_id FROM enrollments as union_data;

-- Query to retrieve all course names from both courses and enrollments table
SELECT course_id FROM courses
UNION ALL
SELECT course_id FROM enrollments  as union_all_data;

SELECT course_id FROM courses
Intersect
SELECT course_id FROM enrollments as Intersect_data;

-- Query to retrieve all course names from both courses and enrollments table
SELECT course_id FROM courses
 Except
SELECT course_id FROM enrollments  as Except_data;-- Students Table


/*
















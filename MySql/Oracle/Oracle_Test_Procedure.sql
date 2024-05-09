-- Drop the table if it exists
DROP TABLE students;

-- Create the table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE
);

-- Truncate the table
TRUNCATE TABLE students;

-- Select data from the table (will return no rows after truncation)
SELECT * FROM students;

-- Select constraints for the table
SELECT * FROM user_constraints WHERE table_name = 'STUDENTS';

-- Insert data into the table
INSERT INTO students (student_id, first_name, last_name, date_of_birth)
VALUES
    (1, 'John', 'Doe', TO_DATE('1990-01-15', 'YYYY-MM-DD')),
    (2, 'Jane', 'Smith', TO_DATE('1992-05-20', 'YYYY-MM-DD')),
    (3, 'Bob', 'Johnson', TO_DATE('1988-08-10', 'YYYY-MM-DD'));

-- Drop the procedure if it exists
DROP PROCEDURE complex_procedure;

-- Create the procedure
CREATE OR REPLACE PROCEDURE complex_procedure AS
  -- Variables
  v_total NUMBER;
  v_name VARCHAR2(100);
  v_date DATE;
  v_result VARCHAR2(100);

BEGIN
  -- Cursor declaration
  FOR student_rec IN (SELECT student_id, first_name, last_name, date_of_birth FROM students) LOOP
    -- Assign values from cursor to variables
    v_name := student_rec.first_name || ' ' || student_rec.last_name;
    v_date := student_rec.date_of_birth;
    
    -- Calculate age using TRUNC() function
    v_result := 'Age of ' || v_name || ': ' || TRUNC(MONTHS_BETWEEN(SYSDATE, v_date) / 12);
    
    -- Print result
    DBMS_OUTPUT.PUT_LINE(v_result);
  END LOOP;

  -- Call a custom function (replace with actual function call)
  -- v_total := custom_function();

  -- Print the result of the function
  -- DBMS_OUTPUT.PUT_LINE('Result of custom function: ' || v_total);
  
  -- Call a built-in function
  v_result := TO_CHAR(SYSDATE, 'Day');
  DBMS_OUTPUT.PUT_LINE('Current day of the week: ' || v_result);

  -- Call a system procedure
  DBMS_OUTPUT.PUT_LINE('Current user: ' || USER);

  -- Call an exception
  RAISE_APPLICATION_ERROR(-20001, 'An error occurred in the procedure.');
  
EXCEPTION
  WHEN OTHERS THEN
    -- Handle exceptions
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END complex_procedure;
/

-- Execute the procedure
BEGIN
  complex_procedure; -- No inputs are needed for this procedure
END;
/
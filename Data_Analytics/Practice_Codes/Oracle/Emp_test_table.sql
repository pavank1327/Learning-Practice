    -- First, drop the existing table if it exists
    DROP TABLE employees;
    
    -- Create the employees table
    CREATE TABLE employees (
        employee_id NUMBER,
        first_name VARCHAR2(50),
        last_name VARCHAR2(50)
    );
    
    -- Insert sample data into the employees table
    INSERT INTO employees (employee_id, first_name, last_name) VALUES (1, 'John', 'Doe');
    INSERT INTO employees (employee_id, first_name, last_name) VALUES (2, 'Jane', 'Smith');
    INSERT INTO employees (employee_id, first_name, last_name) VALUES (3, 'Michael', 'Johnson');
    INSERT INTO employees (employee_id, first_name, last_name) VALUES (4, 'Emily', 'Williams');
   
   
select * from employees;
    
    -- Declare the cursor
    DECLARE
        CURSOR c_employee IS
            SELECT employee_id, first_name, last_name
            FROM employees;
    
        -- Declare variables to hold data fetched from the cursor
        v_employee_id employees.employee_id%TYPE;
        v_first_name employees.first_name%TYPE;
        v_last_name employees.last_name%TYPE;
    BEGIN
        -- Open the cursor
        OPEN c_employee;
    
        -- Fetch data from the cursor
        LOOP
            FETCH c_employee INTO v_employee_id, v_first_name, v_last_name;
            EXIT WHEN c_employee%NOTFOUND;
    
            -- Process the fetched data (in this example, just displaying it)
               
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id || 
                                 ', First Name: ' || v_first_name || 
                                 ', Last Name: ' || v_last_name);
        END LOOP;
    
        -- Close the cursor
        CLOSE c_employee;
    END;
    /
    
    
select * from employees;
    
    
    
    DECLARE
        CURSOR emp_cursor IS
            SELECT employee_id, first_name, last_name
            FROM employees;
        
        emp_id employees.employee_id%TYPE;
        emp_first_name employees.first_name%TYPE;
        emp_last_name employees.last_name%TYPE;
    BEGIN
        OPEN emp_cursor;
        LOOP
            FETCH emp_cursor INTO emp_id, emp_first_name, emp_last_name;
            EXIT WHEN emp_cursor%NOTFOUND;
            
            -- Process the fetched data (e.g., display)
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Name: ' || emp_first_name || ' ' || emp_last_name);
        END LOOP;
        CLOSE emp_cursor;
    END;
    /
    
    
select * from employees;
    

    
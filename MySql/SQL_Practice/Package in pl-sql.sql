Creating a package in PL/SQL:  

A PL/SQL package is a collection of related procedures, functions, variables, and other PL/SQL constructs that are grouped together to provide a modular and organized way to manage and encapsulate code. Below is an example of a simple PL/SQL package that contains a procedure and a function. 

  

Practice Code:  

-- Creating a simple PL/SQL package 

  

-- Declare the package specification 

CREATE OR REPLACE PACKAGE math_operations AS 

    -- Declare public procedures and functions 

    PROCEDURE add_two_numbers(p_num1 NUMBER, p_num2 NUMBER); 

    FUNCTION multiply_two_numbers(p_num1 NUMBER, p_num2 NUMBER) RETURN NUMBER; 

END math_operations; 

/ 

  

-- Declare the package body 

CREATE OR REPLACE PACKAGE BODY math_operations AS 

    -- Define the implementation of procedures and functions 

  

    -- Procedure to add two numbers 

    PROCEDURE add_two_numbers(p_num1 NUMBER, p_num2 NUMBER) AS 

        result NUMBER; 

    BEGIN 

        result := p_num1 + p_num2; 

        dbms_output.put_line('Result of ' || p_num1 || ' + ' || p_num2 || ' is: ' || result); 

    END add_two_numbers; 

  

    -- Function to multiply two numbers 

    FUNCTION multiply_two_numbers(p_num1 NUMBER, p_num2 NUMBER) RETURN NUMBER AS 

        result NUMBER; 

    BEGIN 

        result := p_num1 * p_num2; 

        RETURN result; 

    END multiply_two_numbers; 

END math_operations; 

/

  

  

  

-> Package is now created with a function and a procedure: 

  

After creating the package, you can use it as follows: 

  

-- Using the package 

  

-- Call the procedure from the package 

BEGIN 

    math_operations.add_two_numbers(5, 7); 

END; 

/ 

  

-- Call the function from the package 

DECLARE 

    result NUMBER; 

BEGIN 

    result := math_operations.multiply_two_numbers(3, 4); 

    dbms_output.put_line('Result of multiplication: ' || result); 

END; 

/ 

  

  

--> After creating package check that with different input values 

  

  

Note:  

This is a simple example, and packages can become more complex with additional procedures, functions and types.  

They provide a way to encapsulate and organize related functionality in PL/SQL. 

  

  

--> Save and execute the SQL Script:  

Save the above code into a .sql file, for example, math_operations_package.sql. Open your SQL client and execute the script using the "@ or START" command or use the SQL script execution feature of your SQL client. 

  

@path_to_your_file\math_operations_package.sql; 

-- or 

START path_to_your_file\math_operations_package.sql; 

  

  

  

--> Verify Package Creation:  

After executing the script, the package will be created in the database. You can verify its existence by querying the data dictionary views or using a tool like SQL Developer.

  

 

 

 

 

 

--> Verify package existence 

  

SELECT object_name, object_type 

FROM user_objects 

WHERE object_name = 'MATH_OPERATIONS'; 

  

Note:   

This process will save your PL/SQL package in the database, and you can use it in other PL/SQL programs or SQL scripts by referencing the package and its procedures/functions.

  

 

 
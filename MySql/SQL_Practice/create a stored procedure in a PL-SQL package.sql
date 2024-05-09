You can create PL/SQL stored procedures in a PL/SQL package using the New PL/SQL Package wizard. 

 

Before you begin 

 

Ensure the following requirements are met: 

Ensure that you have the required authorities and privileges for routine development. 

Complete the appropriate setup steps for routine development. 

 

About this task 

 

With the New PL/SQL Package wizard, you specify PL/SQL as the stored procedure language and select a template. Then you can edit the package specification and body in the routine editor. 

Procedure 

 

To create a stored procedure in a PL/SQL package: 

In the Data Project Explorer, right-click the PL/SQL Packages folder in a project and click New > PL/SQL Package. The New PL/SQL Package wizard opens. 

Complete the steps of the wizard. 

The wizard creates the PL/SQL package and adds it to the PL/SQL Packages folder; and the PL/SQL package specification opens in the Routine Editor. 

In the specification, add the stored procedure name and variables. For example: 

 

CREATE OR REPLACE PACKAGE emp_admin 
IS 
 
   ... 
   PROCEDURE hire_emp ( 
      p_empno         NUMBER, 
      p_ename         VARCHAR2, 
      p_job           VARCHAR2, 
      p_sal           NUMBER, 
      p_hiredate      DATE DEFAULT sysdate, 
      p_comm          NUMBER DEFAULT 0, 
      p_mgr           NUMBER, 
      p_deptno        NUMBER DEFAULT 10 
   ); 
   ... 
END emp_admin; 
 

 

Click the Body tab and edit the PL/SQL package body, to add the stored procedure. For example 

-- 
--  Package body for the 'emp_admin' package. 
-- 
CREATE OR REPLACE PACKAGE BODY emp_admin 
IS 
   -- 
   ... 
   --  Procedure that inserts a new employee record into the 'emp' table. 
   -- 
   PROCEDURE hire_emp ( 
      p_empno         NUMBER, 
      p_ename         VARCHAR2, 
      p_job           VARCHAR2, 
      p_sal           NUMBER, 
      p_hiredate      DATE    DEFAULT sysdate, 
      p_comm          NUMBER  DEFAULT 0, 
      p_mgr           NUMBER, 
      p_deptno        NUMBER  DEFAULT 10 
   ) 
   AS 
   BEGIN 
      INSERT INTO emp(empno, ename, job, sal, hiredate, comm, mgr, deptno) 
         VALUES(p_empno, p_ename, p_job, p_sal, 
                p_hiredate, p_comm, p_mgr, p_deptno);
   END; 
	 ... 
   -- 
   END; 

 

 

Save the package.

 

A PL/SQL stored procedure can be overloaded only if all routines with the same name and type are in the same PL/SQL package. In a PL/SQL package, a procedure or function can be overloaded by another procedure or function of the same type and name, but with a different number of parameters. A function in a package can be overloaded by another function with the same number of parameters if the data type of one of the parameters is different. An overloaded package or function in a PL/SQL package, shows the number of its parameters in parentheses: 

 

Procedure02(1)
Procedure02(2)



-- ----------------------------------------------------------------------------------------------



CREATE OR REPLACE PROCEDURE test_sp1(f1 int, f2 varchar(20))
AS $$
DECLARE
  min_val int;
BEGIN
  DROP TABLE IF EXISTS tmp_tbl;
  CREATE TEMP TABLE tmp_tbl(id int);
  INSERT INTO tmp_tbl values (f1),(10001),(10002);
  SELECT INTO min_val MIN(id) FROM tmp_tbl;
  RAISE INFO 'min_val = %, f2 = %', min_val, f2;
END;
$$ LANGUAGE plpgsql;

CALL test_sp1(123, 'example');


-- RENAME test_sp1 TO test_sp;

ALTER PROCEDURE test_sp1(f1 int, f2 varchar(20)) RENAME TO test_sp;

CALL test_sp(12, 'modified_example'); -- creating , renaming and calling the procedure correctly

-- ---------------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE test_sp2(f1 IN int, f2 INOUT varchar(256),
out_var OUT varchar(256))

AS 
$$
DECLARE
  f1_value int := 10; -- Example value for the IN parameter f1
  f2_value varchar(256) := 'Initial Value'; -- Example value for the INOUT parameter f2
  out_var_value varchar(256); -- Variable to store the value of the OUT parameter out_var
BEGIN
  -- Call the procedure
  CALL test_sp2(f1 := f1_value, f2 := f2_value, out_var := out_var_value);
  
  -- Display the value of out_var
  RAISE NOTICE 'Value of out_var: %', out_var_value;
  
  -- Display the updated value of f2
  RAISE NOTICE 'Updated value of f2: %', f2_value;
END;
$$;
LANGUAGE plpgsql;


-- CREATE LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE test_sp2(f1 IN int, f2 INOUT varchar(256), out_var OUT varchar(256))
AS 
$$
BEGIN
  -- Display the value of f2 before modification
  RAISE NOTICE 'Initial value of f2: %', f2;
  
  -- Modify f2 (INOUT parameter)
  f2 := f2 || ' Updated'; -- Example modification
  
  -- Assign a value to the OUT parameter
  out_var := 'Hello from test_sp2'; -- Example value
  
  -- Display the updated value of f2
  RAISE NOTICE 'Updated value of f2: %', f2;
END;
$$;
LANGUAGE plpgsql -- wrong code

-- -------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE test_sp2(f1 IN int, f2 INOUT varchar(256), out_var OUT varchar(256))
AS 
$$
BEGIN
  -- Display the value of f2 before modification
  RAISE NOTICE 'Initial value of f2: %', f2;
  
  -- Modify f2 (INOUT parameter)
  f2 := f2 || ' Updated'; -- Example modification
  
  -- Assign a value to the OUT parameter
  out_var := 'Hello from test_sp2'; -- Example value
  
  -- Display the updated value of f2
  RAISE NOTICE 'Updated value of f2: %', f2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE test_sp2_wrapper()
AS 
$$
DECLARE
  f1_value int := 10; -- Example value for the IN parameter f1
  f2_value varchar(256) := 'Initial Value'; -- Example value for the INOUT parameter f2
  out_var_value varchar(256); -- Variable to store the value of the OUT parameter out_var
BEGIN
  -- Call the procedure
  CALL test_sp2(f1 := f1_value, f2 := f2_value, out_var := out_var_value);
  
  -- Display the value of out_var
  RAISE NOTICE 'Value of out_var: %', out_var_value;
  
  -- Display the updated value of f2
  RAISE NOTICE 'Updated value of f2: %', f2_value;

END;
$$
LANGUAGE plpgsql;

CALL test_sp2_wrapper();
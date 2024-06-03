CONNECT SYS/wissen01 AS SYSDBA;


-- ALTER SESSION SET CONTAINER = PDB_NAME; -- Replace PDB_NAME with your actual PDB name

CREATE USER c##PAVAN IDENTIFIED BY "pavan";
GRANT CONNECT, RESOURCE TO PAVAN;
-- Optionally, grant DBA privileges (be cautious with this)
-- GRANT DBA TO PAVAN;


SET SERVEROUTPUT ON
CONNECT SYS/wissen01 AS SYSDBA
-- Ensure successful connection before running further commands
SELECT * FROM dual;

-- Switch to the PDB (replace PDB_NAME with your actual PDB name)
ALTER SESSION SET CONTAINER = PDB_NAME;

-- Create the user in the PDB
CREATE USER c##PAVAN IDENTIFIED BY "pavan";
-- GRANT CONNECT, RESOURCE TO PAVAN;
-- Optionally, grant DBA privileges (be cautious with this)
-- GRANT DBA TO PAVAN;

GRANT ALL PRIVILEGES TO c##PAVAN;


SET SERVEROUTPUT ON
CONNECT SYS/wissen01 AS SYSDBA
-- Ensure successful connection before running further commands
SELECT * FROM dual;

-- Switch to the PDB (replace PDB_NAME with your actual PDB name)
ALTER SESSION SET CONTAINER = PDB_NAME;

-- Create the user in the PDB
CREATE USER c##k IDENTIFIED BY "pavank";
-- GRANT CONNECT, RESOURCE TO PAVAN;
-- Optionally, grant DBA privileges (be cautious with this)
-- GRANT DBA TO PAVAN;

GRANT ALL PRIVILEGES TO c##k;





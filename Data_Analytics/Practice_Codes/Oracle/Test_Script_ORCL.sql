DROP TABLE  CLAIMS;
DROP TABLE  COURSES;
DROP TABLE  REAL_ESTATE_DATA_CHICAGO;
DROP TABLE  CUSTOMER;
DROP TABLE  FRUIT_SALES;
DROP TABLE  POLICY;
DROP TABLE  POLICYHOLDER;
DROP TABLE  PRACTICE_CUSTOMER_DATA_FILE_CSV;
DROP TABLE  PRODUCTS;
DROP TABLE  SALES;
DROP TABLE  STUDENTS;
DROP TABLE  STUDENTENROLLMENTINFO;

SELECT count(*) FROM ORDERS o;

-- SELECT count(*) FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING nhdfdc;--  WHERE "UniqueID " > 1000;

SELECT * FROM CLAIMS c ;
-- desc CLAIM;

SELECT * FROM COURSES c ;

SELECT * FROM REAL_ESTATE_DATA_CHICAGO redc ;

SELECT * FROM CUSTOMER c ;

SELECT * FROM FRUIT_SALES fs ;

SELECT * FROM POLICY p ;

SELECT * FROM POLICYHOLDER p ;

SELECT * FROM PRACTICE_CUSTOMER_DATA_FILE_CSV pcdfc ;

SELECT * FROM PRODUCTS p ;

SELECT * FROM SALES s ;

SELECT * FROM STUDENTS s ;

SELECT * FROM STUDENTENROLLMENTINFO s ;

DESC STUDENTENROLLMENTINFO; -- working IN sql_dev app NOT working IN dbeaver

DESCRIBE STUDENTENROLLMENTINFO; -- working IN sql_dev app NOT working IN dbeaver

SELECT * FROM USERS u ;

SELECT * FROM SHIPPERS s ;



-- STUDENTENROLLMENTINFO

CREATE TABLE STUDENTENROLLMENTINFO (
    STUDENT_ID NUMBER,
    ADMISSION_DATE DATE,
    ENROLLMENT_DATE DATE,
    GAP_DATA NUMBER,
    TOTAL_DAYS NUMBER,
    DAYS_AFTER_ADJUSTED NUMBER
);


INSERT INTO STUDENTENROLLMENTINFO (STUDENT_ID, ADMISSION_DATE, ENROLLMENT_DATE, GAP_DATA, TOTAL_DAYS, DAYS_AFTER_ADJUSTED)
VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'), 10, 100, 90);

INSERT INTO STUDENTENROLLMENTINFO (STUDENT_ID, ADMISSION_DATE, ENROLLMENT_DATE, GAP_DATA, TOTAL_DAYS, DAYS_AFTER_ADJUSTED)
VALUES (2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-12', 'YYYY-MM-DD'), 11, 110, 99);

INSERT INTO STUDENTENROLLMENTINFO (STUDENT_ID, ADMISSION_DATE, ENROLLMENT_DATE, GAP_DATA, TOTAL_DAYS, DAYS_AFTER_ADJUSTED)
VALUES (3, TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-15', 'YYYY-MM-DD'), 14, 120, 106);

INSERT INTO STUDENTENROLLMENTINFO (STUDENT_ID, ADMISSION_DATE, ENROLLMENT_DATE, GAP_DATA, TOTAL_DAYS, DAYS_AFTER_ADJUSTED)
VALUES (4, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), 4, 130, 126);

INSERT INTO STUDENTENROLLMENTINFO (STUDENT_ID, ADMISSION_DATE, ENROLLMENT_DATE, GAP_DATA, TOTAL_DAYS, DAYS_AFTER_ADJUSTED)
VALUES (5, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 19, 140, 121);

-- test emp_tbl table

DROP TABLE emp_tbl;

create table emp_tbl
(
emp_id int,
emp_name varchar(50),
emp_location varchar (50),
salary numeric(18,5)
);
 
insert into emp_tbl(emp_id,emp_name,emp_location,salary)
values (1010,'Anjan','Hyd',10000);
insert into emp_tbl(emp_id,emp_name,emp_location,salary)
values(1012,'Nanda','Hyd',10000);
insert into emp_tbl(emp_id,emp_name,emp_location,salary)
values(1013,'Aparna','Hyd',10000);
 
 
select * from emp_tbl where emp_tbl.emp_id is null;
 
delete from emp_tbl where emp_id=1010;

select * from emp_tbl;

TRUNCATE TABLE emp_tbl;

select * from emp_tbl;

drop table emp_tbl;

select * from emp_tbl;



-- NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING


desc NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING;

SELECT * FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING nh ;

SELECT nh."UniqueID "  FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING nh

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING nh
WHERE nh."UniqueID " IS NULL 
   OR nh."ParcelID" IS NOT NULL 
   OR nh."LandUse" IS NULL 
   OR nh."PropertyAddress" IS NULL 
   OR nh."SaleDate" IS NULL 
   OR nh."SalePrice" IS NULL 
   OR nh."LegalReference" IS NULL 
   OR nh."SoldAsVacant" IS NULL 
   OR nh."OwnerName" IS NULL 
   OR nh."OwnerAddress" IS NULL 
   OR nh."Acreage" IS NULL 
   OR nh."TaxDistrict" IS NULL 
   OR nh."LandValue" IS NULL 
   OR nh."BuildingValue" IS NULL 
   OR nh."TotalValue" IS NULL 
   OR nh."YearBuilt" IS NULL 
   OR nh."Bedrooms" IS NULL 
   OR nh."FullBath" IS NULL
   OR nh."HalfBath" IS NULL;

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING nh
WHERE nh."SalePrice" <> 0 
   OR "LandValue" <> 0 
   OR "BuildingValue" <> 0 
   OR "TotalValue" <> 0 
   OR "YearBuilt" <> 0 
   OR "Bedrooms" <> 0 
   OR "FullBath" <> 0 
   OR "HalfBath" <> 0;
  
SELECT "SalePrice" FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING;
 
  
 
SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE TO_DATE("SaleDate", 'YYYY-MM-DD') IS NULL
   AND "SaleDate" IS NOT NULL;


SELECT "UniqueID", COUNT(*)
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
GROUP BY "UniqueID"
HAVING COUNT(*) > 1;

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE "Acreage" < 0 OR "Acreage" > 100;

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE "TotalValue" != ("LandValue" + "BuildingValue");

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE "SoldAsVacant" NOT IN ('Yes', 'No');

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE "TaxDistrict" NOT IN ('District1', 'District2', 'District3');

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE "YearBuilt" <> 1800;

SELECT *
FROM NASHVILLE_HOUSING_DATA_FOR_DATA_CLEANING
WHERE LENGTH("OwnerName") > 64;

SELECT * FROM POLICYHOLDER p WHERE LENGTH ("POLICYHOLDERID") <> 0;

SELECT * FROM SUPPLIERS s WHERE "SupplierID" = 1;

SELECT "SupplierID" FROM SUPPLIERS s;



-- Calculation examples

-- Calculate profit based on given values
SELECT (17000/17.40)*(18.40-17.40) FROM dual;  -- 977

-- Repeat the calculation
SELECT (17000/17.40)*(18.40-17.40) FROM dual;  -- 977

-- Another profit calculation
SELECT (17000/18.40)*(19.40-18.40) FROM dual;  -- 923

-- Yet another profit calculation
SELECT (17000/19.40)*(20.40-19.40) FROM dual;  -- 876

-- Summing the calculated profits
SELECT 977 + 977 + 923 + 876 FROM dual;  -- 3753

-- Calculate profit with different values
SELECT (50000/17.40)*(18.40-17.40) FROM dual;  -- 2873

-- Repeat the calculation with different values
SELECT (50000/17.40)*(18.40-17.40) FROM dual;  -- 2873

-- Calculate another profit with different values
SELECT (50000/18.40)*(19.40-18.40) FROM dual;  -- 2717

-- Another profit calculation with different values
SELECT (50000/19.40)*(20.40-19.40) FROM dual;  -- 2577

-- Summing the calculated profits
SELECT 2873 + 2873 + 2717 + 2577 FROM dual;  -- 11040

-- Calculating total with initial amount
SELECT 50000 + 2873 + 2873 + 2717 + 2577 AS "safe_game" FROM dual;  -- 61040

-- Calculating profit with initial amount
SELECT (50000/17.40)*(18.40-17.40) FROM dual;  -- 2873

-- Recalculating profit with updated values
SELECT ((50000 + 2873)/17.40)*(18.40-17.40) FROM dual;  -- 3038

-- Recalculating profit with updated values again
SELECT ((50000 + 2873 + 3038)/18.40)*(19.40-18.40) FROM dual;  -- 3038

-- Recalculating profit with updated values once more
SELECT ((50000 + 2873 + 3038 + 3038)/19.40)*(20.40-19.40) FROM dual;  -- 3038

-- Summing the updated calculated profits
SELECT 2873 + 3038 + 3038 + 3038 FROM dual;  -- 11987

-- Calculating total with updated values
SELECT 50000 + 2873 + 3038 + 3038 + 3038 AS "risking_it" FROM dual;  -- 61987

-- Small value profit calculation
SELECT (2000/17.40)*(18.40-17.40) FROM dual;  -- 114

-- Recalculating small value profit with updated values
SELECT ((2000 + 114)/17.40)*(18.40-17.40) FROM dual;  -- 121

-- Recalculating small value profit again
SELECT ((2000 + 114 + 121)/18.40)*(19.40-18.40) FROM dual;  -- 121

-- Recalculating small value profit once more
SELECT ((2000 + 114 + 121 + 121)/19.40)*(20.40-19.40) FROM dual;  -- 121

-- Final total calculations
SELECT 50000 + 2873 + 2873 + 2717 + 2577 AS "safe_game" FROM dual;  -- 61040
SELECT 50000 + 2873 + 3038 + 3038 + 3038 AS "risking_it" FROM dual;  -- 61987
SELECT 2000 + 114 + 121 + 121 + 121 FROM dual;  -- 2477

-- Simple subtraction
SELECT (35 - 8 - 8) FROM dual;  -- 19

-- Another simple subtraction
SELECT 42325 - 30483 FROM dual;  -- 11842

-- Another simple subtraction
SELECT 43000 - 30483 FROM dual;  -- 12517

-- Division and multiplication
SELECT (10000/14.25)*4 FROM dual;  -- 2807.01754386
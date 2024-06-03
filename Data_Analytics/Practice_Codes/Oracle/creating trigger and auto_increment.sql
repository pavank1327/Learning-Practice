-- Create the invest table (if it doesn't already exist)
DROP TABLE invest ;
CREATE TABLE invest (
    id NUMBER PRIMARY KEY,
    calculated_value NUMBER,
    timestamp TIMESTAMP
);

-- Insert statement
INSERT INTO invest (id, calculated_value, timestamp)
VALUES (2, 1001, SYSTIMESTAMP);

-- Verify the insertion
SELECT * FROM invest;


DROP TABLE INVEST ;
-- Step 1: Create the invest table
CREATE TABLE invest (
    id NUMBER PRIMARY KEY,
    calculated_value NUMBER,
    timestamp TIMESTAMP
);

-- Step 2: Create the sequence for the id column
drop SEQUENCE invest_seq;

CREATE SEQUENCE invest_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

drop TRIGGER invest_before_insert;
-- Step 3: Create the trigger to auto-populate id and timestamp
CREATE OR REPLACE TRIGGER invest_before_insert
BEFORE INSERT ON invest
FOR EACH ROW
BEGIN
  :NEW.id := invest_seq.NEXTVAL;
  :NEW.timestamp := SYSTIMESTAMP;
END;
/

-- trigger execution not working in dbever, but working in sql dev app

-- Step 4: Insert data into the calculated_value column
INSERT INTO invest (calculated_value) VALUES ((100000 / 172.35) * (174.90 - 172.35));
INSERT INTO invest (calculated_value) VALUES ((700000 / 172.35) * (174.90 - 172.35));
INSERT INTO invest (calculated_value) VALUES ((600000 / 172.35) * (175.00 - 172.35));
INSERT INTO invest (calculated_value) VALUES ((800000 / 172.35) * (176.00 - 172.35));

commit;

-- truncate table invest;
-- commit;
    
    
-- TRUNCATE TABLE INVEST ;
-- drop TABLE INVEST;
    
-- Step 5: Verify the insertion
SELECT count(*) FROM invest;--  order by id;
SELECT * FROM invest order by id;
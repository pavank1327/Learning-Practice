create table number(num4 varchar);

insert into number (num4) values (1.0000);

select * From number;


SELECT CAST(num4 AS decimal(1,0)) as non_decimal_data FROM number; 
-- removing 0's after decimal

-- ---------------------------------------------------------------------------------------------------

CREATE TABLE numbers (num1 int);

ALTER TABLE numbers
ADD COLUMN num2 DECIMAL(8, 4);

INSERT INTO numbers (num1, num2) VALUES (1, 1111.0000);


SELECT * FROM numbers; -- Output the inserted value


SELECT CAST(num2 AS decimal(4,0)) as non_decimal_data FROM numbers; 

-- SELECT num1 FROM numbers; -- Output the values in the num1 column


-- ---------------------------------------------------------------------------------------------------

CREATE TABLE numbers 
(	
  num1 DECIMAL(5, 4)
);


INSERT INTO numbers (num1) VALUES (1.127::DECIMAL(5, 4));


SELECT * FROM numbers; -- Output the inserted value

SELECT CAST(num1 AS DECIMAL(5, 4)) AS num1_cast FROM numbers;

SELECT CAST(num1 AS DECIMAL(5, 2)) AS num1_cast FROM numbers;

SELECT CAST(num1 AS DECIMAL(5, 1)) FROM numbers;

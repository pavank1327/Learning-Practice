-- Remove the users table
DROP TABLE IF EXISTS users;

-- Remove the event table
DROP TABLE IF EXISTS event;

-- Remove the sales table
DROP TABLE IF EXISTS sales;

-- Recreate the users table without primary key and foreign key constraints
CREATE TABLE users (
    userid INTEGER primary key NOT NULL,
    username CHAR(8),
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    city VARCHAR(30),
    state CHAR(2),
    email VARCHAR(100),
    phone CHAR(14),
    likesports BOOLEAN,
    liketheatre BOOLEAN,
    likeconcerts BOOLEAN,
    likejazz BOOLEAN,
    likeclassical BOOLEAN,
    likeopera BOOLEAN,
    likenotclassical BOOLEAN,
    likebroadway BOOLEAN,
    likemusicals BOOLEAN
);

-- Recreate the event table without primary key and foreign key constraints
CREATE TABLE event (
    eventid INTEGER primary key NOT NULL,
    venueid SMALLINT NOT NULL,
    catid SMALLINT NOT NULL,
    dateid SMALLINT NOT NULL,
    eventname VARCHAR(200),
    starttime TIMESTAMP
    -- ,    foreign key (starttime) REFERENCES sales(saletime)

    -- sales table is not defined first so f_key creation is not accepted need to check how to CREATE
    
);


-- Recreate the sales table without primary key and foreign key constraints
CREATE TABLE sales (
    salesid INTEGER primary key  NOT NULL,
    listid INTEGER NOT NULL,
    sellerid INTEGER NOT NULL,
    buyerid INTEGER NOT NULL,
    eventid INTEGER NOT NULL,
    dateid SMALLINT NOT NULL,
    qtysold SMALLINT NOT NULL,
    pricepaid DECIMAL(8,2),
    commission DECIMAL(8,2),
    saletime TIMESTAMP,
    foreign key (eventid) REFERENCES event(eventid) 
);

/*
-- alter table event add  foreign key (starttime) REFERENCES sales(saletime); -- this is also not working need to learn how to do it


CREATE TABLE users (
    userid INTEGER PRIMARY KEY NOT NULL,
    username CHAR(8),
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    city VARCHAR(30),
    state CHAR(2),
    email VARCHAR(100),
    phone CHAR(14),
    likesports BOOLEAN,
    liketheatre BOOLEAN,
    likeconcerts BOOLEAN,
    likejazz BOOLEAN,
    likeclassical BOOLEAN,
    likeopera BOOLEAN,
    likenotclassical BOOLEAN,
    likebroadway BOOLEAN,
    likemusicals BOOLEAN
);

CREATE TABLE sales (
    salesid INTEGER PRIMARY KEY NOT NULL,
    listid INTEGER NOT NULL,
    sellerid INTEGER NOT NULL,
    buyerid INTEGER NOT NULL,
    eventid INTEGER NOT NULL,
    dateid SMALLINT NOT NULL,
    qtysold SMALLINT NOT NULL,
    pricepaid DECIMAL(8,2),
    commission DECIMAL(8,2),
    saletime TIMESTAMP,
    FOREIGN KEY (sellerid) REFERENCES users(userid),
    FOREIGN KEY (buyerid) REFERENCES users(userid)
    -- CONSTRAINT fk_event FOREIGN KEY (eventid, dateid) REFERENCES event(eventid, dateid)
);


CREATE TABLE event (
    eventid INTEGER PRIMARY KEY NOT NULL,
    venueid SMALLINT NOT NULL,
    catid SMALLINT NOT NULL,
    dateid SMALLINT NOT NULL,
    eventname VARCHAR(200),
    starttime TIMESTAMP,
    FOREIGN KEY (eventid) REFERENCES sales(eventid),
    FOREIGN KEY (dateid) REFERENCES sales(dateid)
);
*/


-- Select all records from the recreated tables
SELECT * FROM sales;SELECT * FROM event;SELECT * FROM users;

-- Inserting data into the users table
INSERT INTO users (userid, username, firstname, lastname, city, state, email, phone, 
likesports, liketheatre, likeconcerts, likejazz, likeclassical, likeopera, likenotclassical, likebroadway, likemusicals)
VALUES
(1, 'johndoe', 'John', 'Doe', 'Seattle', 'WA', 'john.doe@example.com', '555-123-4567', 
true, true, true, true, true, false, true, true, true),
(2, 'janedoe', 'Jane', 'Doe', 'New York', 'NY', 'jane.doe@example.com', '555-987-6543', 
true, true, true, false, true, true, false, true, true),
(3, 'bobsmith', 'Bob', 'Smith', 'Los Angeles', 'CA', 'bob.smith@example.com', '555-432-1234',
false, true, true, true, true, true, true, true, true);

-- Inserting data into the event table
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(1, 101, 101, 123, 'The Big Game', '2023-02-12 18:00:00'::timestamp),
(2, 102, 102, 124, 'The Opera', '2023-03-15 19:30:00'::timestamp),
(3, 103, 103, 125, 'The Classic Rock Concert', '2023-04-20 20:00:00'::timestamp),
(4, 101, 101, 126, 'The Playoffs', '2023-05-14 14:00:00'::timestamp),
(5, 104, 102, 127, 'The Musical', '2023-06-10 16:00:00'::timestamp);

-- Inserting data into the sales table
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(1, 101, 1, 2, 1, 123, 2, 200.00, 20.00, '2023-02-11 18:00:00'::timestamp),
(2, 102, 2, 3, 2, 124, 1, 150.00, 15.00, '2023-03-14 19:00:00'::timestamp),
(3, 103, 3, 1, 3, 125, 1,  75.00,  7.50, '2023-04-20 19:00:00'::timestamp),
(4, 104, 2, 3, 4, 126, 2, 300.00, 30.00, '2023-05-14 13:00:00'::timestamp),
(5, 105, 3, 2, 5, 127, 1, 100.00, 10.00, '2023-06-10 15:00:00'::timestamp);

SELECT * FROM sales;SELECT * FROM event;SELECT * FROM users;

-- Find top 10 buyers by quantity.
SELECT u.firstname, u.lastname, q.total_quantity
FROM (
  SELECT
    buyerid,
    SUM(qtysold) AS total_quantity
  FROM
    sales
  GROUP BY
    buyerid
  ORDER BY
    total_quantity DESC
) q
JOIN
  users u
ON
  q.buyerid = u.userid
ORDER BY
  q.total_quantity DESC

FETCH FIRST 10 ROWS ONLY; -- this code is also included study it

-- Find events in the 99.9 percentile in terms of all time gross sales.
SELECT
  e.eventname,
  q.total_price
FROM
  (
    SELECT
      eventid,
      SUM(pricepaid) AS total_price,
      NTILE(1000) OVER (ORDER BY SUM(pricepaid) DESC) AS percentile
    FROM
      sales
    GROUP BY
      eventid
  ) q
JOIN
  event e
ON
  q.eventid = e.eventid
WHERE
  q.percentile = 1
ORDER BY
  q.total_price DESC;

select starttime from event;
  
select saletime from sales;

select e.starttime,s.saletime as commom_time
from event e
inner join sales s on e.starttime <= s.saletime; 


SELECT count(*)
FROM event
CROSS JOIN sales;

select count(*) from sales,event;  
 


SELECT count(*)
FROM event
CROSS JOIN sales cross join users;


  
select * from event,sales,users;


SELECT * FROM event e
inner JOIN sales s ON e.eventid = s.eventid 
inner JOIN users u ON s.buyerid = u.userid; 



SELECT count(*) as using_join
-- u.firstname, u.lastname, e.eventname, s.qtysold, s.pricepaid, s.saletime
FROM event e
JOIN sales s ON e.dateid = s.dateid
JOIN sales s1 ON s1.eventid = e.eventid;



SELECT count(*) as using_and
-- u.firstname, u.lastname, e.eventname, s.qtysold, s.pricepaid, s.saletime
FROM event e
JOIN sales s ON e.dateid = s.dateid
and s.eventid = e.eventid;

-- -------------------------------------------------------------------------------------------------

CREATE TABLE fruit_sales (
  item_name varchar(50),
  sale_price numeric(10, 2),
  fruit_sale_date_at timestamp
);

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_date_at) VALUES
  ('Apple', 1.50, '2023-07-23 10:02:21'::timestamp),
  ('Banana', 1.00, '2023-07-23 10:23:00'::timestamp),
  ('Apple', 1.50, '2023-07-23 11:35:10'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:45:51'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:58:20'::timestamp);
  

SELECT date_trunc('year', '2023-07-23 07:08:30'::date)as year;

SELECT date_trunc('MONTH', '2023-07-23 07:08:30'::date)as mon;

SELECT date_trunc('day', '2023-07-23 07:08:30'::date)as which_day;

SELECT date_trunc('minute', '2023-07-23 07:08:30'::date) as minutes;
  
SELECT date_trunc('hour', fruit_sale_hour_at) as fruit_sale_hour_at,
   SUM(sale_price) AS sum_of_fruit_sales
   FROM fruit_sales
GROUP BY fruit_sale_hour_at;

-- ------------------------------------------------------------------------------------------------

CREATE TABLE datelist (
  datevalue DATE,
  timestampvalue TIMESTAMP
);

INSERT INTO datelist (datevalue, timestampvalue)
VALUES (CURRENT_DATE, CURRENT_TIMESTAMP);

SELECT datevalue, timestampvalue FROM datelist;


-- -------------------------------------------------------------------------------------------------


-- not working in postgre SQL

/*SELECT DATEDIFF('2024-04-05', '2024-01-29') AS DateDiff;
SELECT TIMESTAMPDIFF(MONTH, '2024-01-29', '2024-04-05') AS MonthDiff;
*/
-- -------------------------------------------------------------------------------------------------

-- Postgre SQL format working

SELECT ('2024-04-05'::date - '2024-01-29'::date) AS DateDiff;
SELECT EXTRACT(MONTH FROM AGE('2024-04-05'::date, '2024-01-29'::date)) AS MonthDiff;

-- -------------------------------------------------------------------------------------------------


CREATE DATABASE db_1;
CREATE USER user_1 WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE db_1 TO user_1;

-- -------------------------------------------------------------------------------------------------


CREATE TABLE fruit_sales (
  item_name varchar(50),
  sale_price numeric(10, 2),
  fruit_sale_hour_at timestamp
);

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_date_at) VALUES
  ('Apple', 1.50, '2023-07-23 10:02:21'::timestamp),
  ('Banana', 1.00, '2023-07-23 10:23:00'::timestamp),
  ('Apple', 1.50, '2023-07-23 11:35:10'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:45:51'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:58:20'::timestamp);
  

SELECT date_trunc('year', '2023-07-23 07:08:30'::date)as year;

SELECT date_trunc('MONTH', '2023-07-23 07:08:30'::date)as mon;

SELECT date_trunc('day', '2023-07-23 07:08:30'::date)as which_day;

SELECT date_trunc('minute', '2023-07-23 07:08:30'::date) as minutes;
  
SELECT date_trunc('hour', fruit_sale_hour_at) as fruit_sale_hour_at,
   SUM(sale_price) AS sum_of_fruit_sales
   FROM fruit_sales
GROUP BY fruit_sale_hour_at;


-- ------------------------------------------------------------------------------------------


CREATE TABLE fruit_sales (
  item_name varchar(50),
  sale_price numeric(10, 2),
  fruit_sale_date_at timestamp
);

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_date_at) VALUES
  ('Apple', 1.50, '2023-07-23 10:02:21'::timestamp),
  ('Banana', 1.00, '2023-07-23 10:23:00'::timestamp),
  ('Apple', 1.50, '2023-07-23 11:35:10'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:45:51'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:58:20'::timestamp);

SELECT date_trunc('year', '2023-07-23 07:08:30'::date) AS which_year;
SELECT date_trunc('month', '2023-07-23 07:08:30'::date) AS mon;
SELECT date_trunc('day', '2023-07-23 07:08:30'::date) AS which_day;
SELECT date_trunc('minute', '2023-07-23 07:08:30'::date) AS minutes;
-- combined statements written as above are not working need to check

SELECT date_trunc('hour', fruit_sale_hour_at) AS fruit_sale_hour_at,
       SUM(sale_price) AS sum_of_fruit_sales
FROM fruit_sales
GROUP BY fruit_sale_hour_at;


SELECT CONCAT('Hour:', EXTRACT(HOUR FROM fruit_sale_hour_at)) AS fruit_sale_hour
-- ,SUM(sale_price) AS sum_of_fruit_sales
FROM fruit_sales order by fruit_sale_hour_at desc;



-- instead of date_trunc() -- Extract() is working for individual statements as taken below

SELECT date_trunc('year', fruit_sale_date_at) AS fruit_sale_year,
   SUM(sale_price) AS sum_of_fruit_sales
FROM fruit_sales
GROUP BY fruit_sale_date_at;

SELECT EXTRACT(YEAR FROM fruit_sale_date_at) AS fruit_sale_year_using_extract
FROM fruit_sales;
SELECT EXTRACT(month FROM fruit_sale_date_at) AS fruit_sale_month_using_extract
FROM fruit_sales;
SELECT EXTRACT(day FROM fruit_sale_date_at) AS fruit_sale_day_using_extract
FROM fruit_sales;
SELECT EXTRACT(hour FROM fruit_sale_date_at) AS fruit_sale_hour_using_extract
FROM fruit_sales;

-- -------------------------------------------------------------------------------------------------------------


create table number(num4 varchar);

insert into number (num4) values (1.0000);

select * From number;


SELECT CAST(num4 AS decimal(1,0)) as non_decimal_data FROM number; 
-- removing 0's after decimal
-- ---------------------------------------------------------------------------------------------------

CREATE TABLE numbers 
(
  num1 DECIMAL(5, 4)
);


INSERT INTO numbers (num1) VALUES (1.0000::DECIMAL(5, 4));


SELECT * FROM numbers; -- Output the inserted value

SELECT CAST(num1 AS DECIMAL(5, 4)) AS num1_cast FROM numbers;


-- SELECT CAST(num1 AS DECIMAL(5, 4)) FROM numbers;

-- ---------------------------------------------------------------------------------------------------

CREATE TABLE numbers (num1 int);

ALTER TABLE numbers
ADD COLUMN num2 DECIMAL(8, 4);

INSERT INTO numbers (num1, num2) VALUES (1, 1111.0000);


SELECT * FROM numbers; -- Output the inserted value


SELECT CAST(num2 AS decimal(4,0)) as non_decimal_data FROM numbers;

-- SELECT num1 FROM numbers; -- Output the values in the num1 column
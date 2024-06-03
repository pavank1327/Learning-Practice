DROP TABLE users;
DROP TABLE event;
DROP TABLE sales;



-- Creating the users table
CREATE TABLE users (
    userid INTEGER PRIMARY KEY,
    username CHAR(8),
    firstname VARCHAR2(30),
    lastname VARCHAR2(30),
    city VARCHAR2(30),
    state CHAR(2),
    email VARCHAR2(100),
    phone CHAR(14),
    likesports NUMBER(1),
    liketheatre NUMBER(1),
    likeconcerts NUMBER(1),
    likejazz NUMBER(1),
    likeclassical NUMBER(1),
    likeopera NUMBER(1),
    likenotclassical NUMBER(1),
    likebroadway NUMBER(1),
    likemusicals NUMBER(1)
);

-- Creating the event table
CREATE TABLE event (
    eventid INTEGER PRIMARY KEY,
    venueid NUMBER NOT NULL,
    catid NUMBER NOT NULL,
    dateid NUMBER NOT NULL,
    eventname VARCHAR2(200),
    starttime TIMESTAMP
);

-- Creating the sales table
CREATE TABLE sales (
    salesid INTEGER PRIMARY KEY,
    listid INTEGER NOT NULL,
    sellerid INTEGER NOT NULL,
    buyerid INTEGER NOT NULL,
    eventid INTEGER NOT NULL,
    dateid NUMBER NOT NULL,
    qtysold NUMBER NOT NULL,
    pricepaid NUMBER(8,2),
    commission NUMBER(8,2),
    saletime TIMESTAMP
);

-- Inserting data into the users table
INSERT INTO users (userid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre, likeconcerts, likejazz, likeclassical, likeopera, likenotclassical, likebroadway, likemusicals)
VALUES
(1, 'johndoe', 'John', 'Doe', 'Seattle', 'WA', 'john.doe@example.com', '555-123-4567', 1, 1, 1, 1, 1, 0, 1, 1, 1);
INSERT INTO users (userid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre, likeconcerts, likejazz, likeclassical, likeopera, likenotclassical, likebroadway, likemusicals)
VALUES
(2, 'janedoe', 'Jane', 'Doe', 'New York', 'NY', 'jane.doe@example.com', '555-987-6543', 1, 1, 1, 0, 1, 1, 0, 1, 1);
INSERT INTO users (userid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre, likeconcerts, likejazz, likeclassical, likeopera, likenotclassical, likebroadway, likemusicals)
VALUES
(3, 'bobsmith', 'Bob', 'Smith', 'Los Angeles', 'CA', 'bob.smith@example.com', '555-432-1234', 0, 1, 1, 1, 1, 1, 1, 1, 1);

-- Inserting data into the event table
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(1, 101, 101, 123, 'The Big Game', TO_TIMESTAMP('2023-02-12 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(2, 102, 102, 124, 'The Opera', TO_TIMESTAMP('2023-03-15 19:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(3, 103, 103, 125, 'The Classic Rock Concert', TO_TIMESTAMP('2023-04-20 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(4, 101, 101, 126, 'The Playoffs', TO_TIMESTAMP('2023-05-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO event (eventid, venueid, catid, dateid, eventname, starttime)
VALUES
(5, 104, 102, 127, 'The Musical', TO_TIMESTAMP('2023-06-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserting data into the sales table
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(1, 101, 1, 2, 1, 123, 2, 200.00, 20.00, TO_TIMESTAMP('2023-02-11 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(2, 102, 2, 3, 2, 124, 1, 150.00, 15.00, TO_TIMESTAMP('2023-03-14 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(3, 103, 3, 1, 3, 125, 1,  75.00,  7.50, TO_TIMESTAMP('2023-04-20 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(4, 104, 2, 3, 4, 126, 2, 300.00, 30.00, TO_TIMESTAMP('2023-05-14 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO sales (salesid, listid, sellerid, buyerid, eventid, dateid, qtysold, pricepaid, commission, saletime)
VALUES
(5, 105, 3, 2, 5, 127, 1, 100.00, 10.00, TO_TIMESTAMP('2023-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));


SELECT * FROM sales;
SELECT * FROM event;
SELECT * FROM users;

SELECT *
FROM sales
WHERE saletime BETWEEN TO_DATE('2023-04-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS') AND SYSDATE;

SELECT *
FROM sales
WHERE saletime BETWEEN TO_DATE('2023-04-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS') 
AND 
TO_DATE('2023-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS');



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

FETCH FIRST 10 ROWS ONLY; -- this code is also included study it-- statement not working with SQL 

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

-- -------------------------------------------------------------------------------------------------

DROP TABLE fruit_sales;
CREATE TABLE fruit_sales 
(
  item_name varchar(50),
  sale_price numeric(10, 2),
  fruit_sale_hour_at timestamp
);

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) 
VALUES ('Apple', 1.50, TO_TIMESTAMP('2023-07-23 10:02:21', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) 
VALUES ('Banana', 1.00, TO_TIMESTAMP('2023-07-23 10:23:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) 
VALUES ('Apple', 1.50, TO_TIMESTAMP('2023-07-23 11:35:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) 
VALUES ('Banana', 1.00, TO_TIMESTAMP('2023-07-23 11:45:51', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) 
VALUES ('Banana', 1.00, TO_TIMESTAMP('2023-07-23 11:58:20', 'YYYY-MM-DD HH24:MI:SS'));


/*SELECT date_trunc('year', '2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS') FROM dual;
  
SELECT date_trunc('minute', '2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS');*/ -- NOT working WITH oracle


-- Truncate to year
SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'YEAR') AS truncated_year
FROM dual;

-- Truncate to minute
SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'MI') AS truncated_minute
FROM dual;

SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'YEAR') AS truncated_year FROM dual
UNION 
SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'MI') AS truncated_minute 
FROM dual; -- USING UNION

SELECT truncated_year, truncated_minute
FROM (
    SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'YEAR') AS truncated_year
    FROM dual
) -- year_query
JOIN (
    SELECT TRUNC(TO_DATE('2023-07-23 07:08:30', 'YYYY-MM-DD HH24:MI:SS'), 'MI') AS truncated_minute 
    FROM dual
) ON 1 = 1;
-- minute_query ON 1 = 1; -- ON 1 = 1 for cartesian join

  
/*SELECT date_trunc('hour', fruit_sale_hour_at) as fruit_sale_hour_at,
   SUM(sale_price) AS sum_of_fruit_sales
   FROM fruit_sales
GROUP BY fruit_sale_hour_at;*/ -- NOT working WITH oracle


SELECT TRUNC(fruit_sale_hour_at, 'HH') AS fruit_sale_hour_at,
       SUM(sale_price) AS sum_of_fruit_sales
FROM fruit_sales
GROUP BY TRUNC(fruit_sale_hour_at, 'HH');

-- nSELECT sale_price FROM  fruit_sales;


 
SELECT (17000/17.40)*(18.40-17.40) FROM dual; -- 977

SELECT (17000/17.40)*(18.40-17.40) FROM dual; -- 977

SELECT (17000/18.40)*(19.40-18.40) FROM dual; -- 923

SELECT (17000/19.40)*(20.40-19.40) FROM dual; -- 876

SELECT 977+977+923+876 FROM dual; -- 3753

SELECT (50000/17.40)*(18.40-17.40) FROM dual; -- 2873

SELECT (50000/17.40)*(18.40-17.40) FROM dual; -- 2873

SELECT (50000/18.40)*(19.40-18.40) FROM dual; -- 2717

SELECT (50000/19.40)*(20.40-19.40) FROM dual; -- 2577

SELECT 2873+2873+2717+2577 FROM dual; -- 11040

SELECT 50000+2873+2873+2717+2577 "safe_game" FROM dual; -- 61040


SELECT (4000/14.40)*(19.15-14.40) FROM dual; 

SELECT ((50000)/14.40)*(18.40-14.40) FROM dual;-- 2873

SELECT ((50000+28730)/17.40)*(18.40-17.40) FROM dual; -- 2873 3038

SELECT ((50000+28730+30380)/18.40)*(19.40-18.40) FROM dual; -- 2717 3038

SELECT ((50000+28730+30380+30380)/19.40)*(20.40-19.40) FROM dual; -- 2577 3038

-- SELECT 2873+2873+2717+2577 FROM dual; -- 11040

SELECT 2873+3038+3038+3038 FROM dual; -- 11987
SELECT 28730+30380+30380+30380 FROM dual; -- 119870

SELECT 50000+2873+3038+3038+3038 "risking_it" FROM dual; -- 61987



SELECT (2000/17.40)*(18.40-17.40) FROM dual; -- 114

SELECT ((2000+114)/17.40)*(18.40-17.40) FROM dual; -- 121

SELECT ((2000+114+121)/18.40)*(19.40-18.40) FROM dual; -- 121

SELECT ((2000+114+121+121)/19.40)*(20.40-19.40) FROM dual; -- 121


SELECT 50000+2873+2873+2717+2577 "safe_game" FROM dual; -- 61040
SELECT 50000+2873+3038+3038+3038 "risking_it" FROM dual; -- 61987
SELECT 2000+114+121+121+121 "total" FROM dual;


SELECT (35-8-8) FROM dual;


SELECT (13000/19.15)*(20.15-19.40) FROM dual;

SELECT (13000/18.00)*(19.15-18.00) FROM dual;


SELECT (62*15.75)-(62*16.75) FROM dual; 


SELECT 50000+(50000/15.50)*(20.10-15.50) FROM dual;
SELECT 50000+(50000/7.50)*(20.10-7.50) FROM dual;


SELECT (10000/20.10)*(21.10-20.10) FROM dual; -- 497.512437810945273631840796019900497512

SELECT (24000/20.10)*(21.10-20.10) FROM dual; -- 1194.02985074626865671641791044776119403


SELECT 43310-37457l FROM dual;







DROP TABLE snapshot_date_counts;

CREATE TABLE snapshot_date_counts (
    snapshot_date DATE,
    count NUMBER
);

INSERT INTO snapshot_date_counts (snapshot_date, count)
VALUES 
    (TO_DATE('01-01-2021', 'DD-MM-YYYY'), 10);
   INSERT INTO snapshot_date_counts (snapshot_date, count)
VALUES 
    (TO_DATE('15-06-2021', 'DD-MM-YYYY'), 20);
   INSERT INTO snapshot_date_wcounts (snapshot_date, count)
VALUES 
    (TO_DATE('10-12-2022', 'DD-MM-YYYY'), 15);
   INSERT INTO snapshot_date_counts (snapshot_date, count)
VALUES 
    (TO_DATE('31-12-2023', 'DD-MM-YYYY'), 25);


SELECT SNAPSHOT_DATE, COUNT(*)
FROM snapshot_date_counts
WHERE SNAPSHOT_DATE BETWEEN to_date('01-01-2021', 'DD-MM-YYYY') AND to_date('31-12-2023', 'DD-MM-YYYY')
GROUP BY SNAPSHOT_DATE
ORDER BY SNAPSHOT_DATE DESC;


SELECT SNAPSHOT_DATE, COUNT(*)
FROM snapshot_date_counts
WHERE SNAPSHOT_DATE BETWEEN to_date('01-01-2021', 'DD-MM-YYYY') AND sysdate
GROUP BY SNAPSHOT_DATE
ORDER BY SNAPSHOT_DATE DESC;


SELECT SNAPSHOT_DATE, COUNT(*)
FROM snapshot_date_counts
WHERE SNAPSHOT_DATE >= to_date('01-01-2021', 'DD-MM-YYYY') AND 
SNAPSHOT_DATE <= sysdate
GROUP BY SNAPSHOT_DATE
ORDER BY SNAPSHOT_DATE DESC;

-- SELECT SYSDATE  FROM dual;


SELECT NLS_CHARSET_DECL_LEN(200, nls_charset_id('ja16eucfixed')) 
  FROM DUAL; 
 
 
/*NLS_CHARSET_DECL_LEN(200,NLS_CHARSET_ID('JA16EUCFIXED'))
--------------------------------------------------------
                                                     100*/
 
SELECT NLS_CHARSET_DECL_LEN(10000, nls_charset_id('pavankumachr7777')) 
  FROM DUAL;  -- this will NOT WORK because the charset IS NOT valid IN oracle

SELECT DISTINCT value AS character_set
FROM   v$nls_valid_values
WHERE  parameter = 'CHARACTERSET'
ORDER BY value;  -- TO GET the list OF CHARACTER SETS IN oracle

SELECT NLS_CHARSET_DECL_LEN(10000, nls_charset_id(SELECT DISTINCT value AS character_set
FROM   v$nls_valid_values
WHERE  parameter = 'CHARACTERSET'
ORDER BY value)) 
  FROM DUAL;
  
DROP TABLE charset_lengths;
CREATE TABLE charset_lengths (
  character_set VARCHAR2(100),
  length NUMBER
);


DECLARE
  v_charset VARCHAR2(100);
  v_len     NUMBER;
  CURSOR c_charsets IS
    SELECT DISTINCT value AS character_set
    FROM   v$nls_valid_values
    WHERE  parameter = 'CHARACTERSET'
    ORDER BY value;
BEGIN
  FOR rec IN c_charsets LOOP
    v_charset := rec.character_set;
    v_len := NLS_CHARSET_DECL_LEN(10000, NLS_CHARSET_ID(v_charset));
    INSERT INTO charset_lengths (character_set, length) VALUES (v_charset, v_len);
  END LOOP;
END;


SELECT * FROM charset_lengths; 
/*DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS sales;*/

CREATE TABLE users (
    userid INTEGER NOT NULL,
    -- distkey,
    -- sortkey,
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

CREATE TABLE event (
    eventid INTEGER NOT NULL,
    -- distkey,
    venueid SMALLINT NOT NULL,
    catid SMALLINT NOT NULL,
    dateid SMALLINT NOT NULL,
    -- sortkey,
    eventname VARCHAR(200),
    starttime TIMESTAMP
);

CREATE TABLE sales (
    salesid INTEGER NOT NULL,
    listid INTEGER NOT NULL,
    -- distkey,
    sellerid INTEGER NOT NULL,
    buyerid INTEGER NOT NULL,
    eventid INTEGER NOT NULL,
    dateid SMALLINT NOT NULL,
    -- sortkey,
    qtysold SMALLINT NOT NULL,
    pricepaid DECIMAL(8,2),
    commission DECIMAL(8,2),
    saletime TIMESTAMP
);

-- Inserting data into the users table
INSERT INTO users (userid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre, likeconcerts, likejazz, likeclassical, likeopera, likenotclassical, likebroadway, likemusicals)
VALUES
(1, 'johndoe', 'John', 'Doe', 'Seattle', 'WA', 'john.doe@example.com', '555-123-4567', true, true, true, true, true, false, true, true, true),
(2, 'janedoe', 'Jane', 'Doe', 'New York', 'NY', 'jane.doe@example.com', '555-987-6543', true, true, true, false, true, true, false, true, true),
(3, 'bobsmith', 'Bob', 'Smith', 'Los Angeles', 'CA', 'bob.smith@example.com', '555-432-1234', false, true, true, true, true, true, true, true, true);

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

SELECT * FROM sales;
SELECT * FROM event;
SELECT * FROM users;

SELECT * FROM sales;
SELECT * FROM event;
SELECT * FROM users;

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

CREATE TABLE fruit_sales (
  item_name varchar(50),
  sale_price numeric(10, 2),
  fruit_sale_hour_at timestamp
);

INSERT INTO fruit_sales (item_name, sale_price, fruit_sale_hour_at) VALUES
  ('Apple', 1.50, '2023-07-23 10:02:21'::timestamp),
  ('Banana', 1.00, '2023-07-23 10:23:00'::timestamp),
  ('Apple', 1.50, '2023-07-23 11:35:10'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:45:51'::timestamp),
  ('Banana', 1.00, '2023-07-23 11:58:20'::timestamp);

SELECT date_trunc('year', '2023-07-23 07:08:30'::date);
  
SELECT date_trunc('minute', '2023-07-23 07:08:30'::date);

  
SELECT date_trunc('hour', fruit_sale_hour_at) as fruit_sale_hour_at,
   SUM(sale_price) AS sum_of_fruit_sales
   FROM fruit_sales
GROUP BY fruit_sale_hour_at;
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


  
  
select * from event,sales,users;



SELECT count(*) as using_join
-- u.firstname, u.lastname, e.eventname, s.qtysold, s.pricepaid, s.saletime
FROM event e
JOIN sales s ON e.dateid = s.dateid
JOIN sales s1 ON s1.eventid = e.eventid;



SELECT count(*) as using_and

-- u.firstname, u.lastname, e.eventname, s.qtysold, s.pricepaid, s.saletime
FROM event e
JOIN sales s ON e.dateid = s.dateid
and s.eventid = e.eventid ;
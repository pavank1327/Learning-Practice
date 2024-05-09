use Pavank

-- Create the Details table
drop table IF EXISTS Details

use PavanK
create TABLE Details
(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    date1 DATE,
    value1 DECIMAL(10, 2),
    date2 DATE,
    value2 DECIMAL(10, 2)

);

use PavanK
select * from Details;


USE PavanK;

-- Inserting data into the Details table
INSERT INTO Details (id, name, date1, value1, date2, value2) 
VALUES (1, 'John', '2024-04-30', 100.50, '2024-05-01', 200.75);

INSERT INTO Details (id, name, date1, value1, date2, value2) 
VALUES (2, 'Alice', '2024-04-29', 150.75, '2024-04-30', 250.25);

INSERT INTO Details (id, name, date1, value1, date2, value2) 
VALUES (3, 'Bob', '2024-04-28', 300.25, '2024-04-29', 400.50);


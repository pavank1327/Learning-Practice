drop table orders;
-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Insert sample data into the orders table
INSERT ALL 
INTO orders (order_id, customer_name, order_date, total_amount)
VALUES(1, 'John Doe', DATE '2024-05-01', 100.50)
INTO orders (order_id, customer_name, order_date, total_amount)
VALUES(2, 'Jane Smith', DATE '2024-05-02', 75.25)
INTO orders (order_id, customer_name, order_date, total_amount)
VALUES(3, 'Alice Johnson', DATE '2024-05-03', 200.00)
INTO orders (order_id, customer_name, order_date, total_amount)
VALUES(4, 'Bob Brown', DATE '2024-05-04', 150.75)
-- Repeat this process for each row...
SELECT * FROM DUAL;

select * from orders;

ALTER TABLE orders
ADD processed_flag CHAR(10) DEFAULT 'FALSE';

select * from orders;
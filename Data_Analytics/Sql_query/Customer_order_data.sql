use PavanK

-- Drop the foreign key constraint
ALTER TABLE Orders
DROP CONSTRAINT customer_id; 

-- Replace FK_Orders_Customer with the actual name of your foreign key constraint

-- Drop the Customer table

use Pavank
DROP TABLE Customer;


Drop table  Orders;




use Pavank
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255),
    -- Add other columns as needed
);

select * from Customer;


use Pavank
INSERT INTO Customer (customer_id, first_name, last_name, email, phone_number, address)
VALUES
    (1, 'John', 'Doe', 'john.doe@email.com', '1234567890', '123 Main St'),
    (2, 'Jane', 'Smith', 'jane.smith@email.com', '9876543210', '456 Oak St');
-- Add more rows as needed

use Pavank
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    -- Add other columns as needed

    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

use Pavank
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
    (101, 1, '2023-12-09', 50.99),
    (102, 2, '2023-12-10', 75.50);
-- Add more rows as needed


use Pavank
select * from Customer;

use Pavank
select * from Orders;




use Pavank
CREATE TABLE Customer_entry (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255),
	entry_date date
    -- Add other columns as needed
);



use Pavank
INSERT INTO Customer_entry(customer_id, first_name, last_name, email, phone_number, address,entry_date)
VALUES
    (1, 'John', 'Doe', 'john.doe@email.com', '1234567890', '123 Main St','2023-12-09'),
    (2, 'Jane', 'Smith', 'jane.smith@email.com', '9876543210', '456 Oak St','2023-12-09');


select * from Customer_entry;









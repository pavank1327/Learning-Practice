Create Lookup Table (products):


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT,
    price DECIMAL(10, 2)
);

INSERT INTO products VALUES
    (1, 'Laptop', 101, 999.99),
    (2, 'Smartphone', 102, 499.99),
    -- ... other product entries ...


Create Fact Table (sales):


CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity_sold INT,
    amount DECIMAL(10, 2),
    date_id DATE
);

INSERT INTO sales VALUES
    (1001, 1, 5, 4999.95, '2024-02-26'),
    (1002, 2, 10, 4999.90, '2024-02-26'),
    -- ... other sales entries ...


Perform a Lookup:

If you want to get information about a sale along with details about the product, you can perform a query that involves joining the sales and products tables:


SELECT
    s.transaction_id,
    p.product_name,
    s.quantity_sold,
    s.amount,
    s.date_id
FROM
    sales s
JOIN
    products p ON s.product_id = p.product_id;


This query combines data from the fact table (sales) with the lookup table (products) using the common column product_id.
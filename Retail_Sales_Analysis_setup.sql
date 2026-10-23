CREATE DATABASE retail_sales_analysis;
USE retail_sales_analysis;
SELECT DATABASE();
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);
show tables;
INSERT INTO customers
    (customer_id, customer_name, city, signup_date)
VALUES
    (1, 'Rahul', 'Delhi', '2025-01-10'),
    (2, 'Priya', 'Noida', '2025-02-15'),
    (3, 'Aman', 'Delhi', '2025-03-20'),
    (4, 'Neha', 'Ghaziabad', '2025-04-05'),
    (5, 'Simran', 'Noida', '2025-05-12'),
    (6, 'Karan', 'Delhi', '2025-06-18');

select * from customers;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO products
    (product_id, product_name, category, price)
VALUES
    (101, 'Laptop', 'Electronics', 55000.00),
    (102, 'Mouse', 'Electronics', 800.00),
    (103, 'Office Chair', 'Furniture', 4500.00),
    (104, 'Desk', 'Furniture', 7000.00),
    (105, 'Headphones', 'Electronics', 2000.00),
    (106, 'Notebook', 'Stationery', 100.00);
    
select * from Products;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
INSERT INTO orders
    (order_id, customer_id, product_id, quantity, order_date)
VALUES
    (1001, 1, 101, 1, '2025-06-01'),
    (1002, 2, 102, 2, '2025-06-03'),
    (1003, 3, 103, 1, '2025-06-05'),
    (1004, 1, 105, 2, '2025-06-08'),
    (1005, 4, 104, 1, '2025-06-10'),
    (1006, 5, 106, 5, '2025-06-12'),
    (1007, 2, 101, 1, '2025-06-15'),
    (1008, 6, 105, 1, '2025-06-18'),
    (1009, 3, 102, 3, '2025-06-20'),
    (1010, 1, 104, 1, '2025-06-22');
    
select * from orders;
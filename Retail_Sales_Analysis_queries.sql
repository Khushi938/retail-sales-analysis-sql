-- =========================================
-- PROJECT: Retail Sales Analysis
-- PURPOSE: Analyse customers, products and revenue
-- =========================================

/*
OBJECTIVE:
Analyse customer spending, product performance,
category revenue, and daily sales trends.

TOOLS:
MySQL, MySQL Workbench

SQL CONCEPTS:
JOIN, GROUP BY, HAVING, CTEs,
DENSE_RANK(), LAG(), aggregate functions.

DATA:
6 customers, 6 products, 10 orders.
This is a sample dataset created for practice.
*/
-- SECTION 1: Create database
CREATE DATABASE IF NOT EXISTS retail_sales_analysis;

USE retail_sales_analysis;

-- SECTION 2: Customer analysis
-- SECTION 3: Product analysis
-- SECTION 4: Revenue analysis
-- SECTION 5: Customer spending
-- SECTION 6: Advanced SQL analysis

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    o.quantity * p.price AS revenue,
    o.order_date
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;

-- Write a query that displays each product name and its total revenue.
SELECT
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY Product_name
ORDER BY total_revenue DESC;
-- Which product category generates the most revenue?
SELECT
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Which customer spent the most money?

SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Find customers who never ordered

SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Which customers have generated more than ₹10,000 in total spending?

SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING total_spent >10000
ORDER BY total_spent DESC;

-- How much revenue did the business generate on each order date?
SELECT
    o.order_date,
    SUM(o.quantity * p.price) AS daily_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- Find the highest-revenue date directly

SELECT
    o.order_date,
    SUM(o.quantity * p.price) AS daily_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY o.order_date
ORDER BY daily_revenue DESC
LIMIT 1;

-- Rank products by total revenue without collapsing the results into a single row.

WITH product_sales AS (
    SELECT
        p.product_name,
        SUM(o.quantity * p.price) AS total_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    total_revenue,
    DENSE_RANK() OVER (
    ORDER BY total_revenue DESC
) AS revenue_rank
FROM product_sales;

-- calculate how much revenue changed between consecutive order dates.

WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(o.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY o.order_date
),
sales_with_previous AS (
    SELECT
        order_date,
        daily_revenue,
        LAG(daily_revenue) OVER (
            ORDER BY order_date
        ) AS previous_revenue
    FROM daily_sales
)
SELECT
    order_date,
    daily_revenue,
    previous_revenue,
    daily_revenue - previous_revenue AS revenue_change
FROM sales_with_previous
ORDER BY order_date;

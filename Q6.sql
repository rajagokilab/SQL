-- Create Database
CREATE DATABASE Q6_ecommerce;
SHOW DATABASES;

USE Q6_ecommerce;

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert stationery products into Products table
INSERT INTO Products (product_id, product_name) VALUES
(1, 'Ballpoint Pen'),
(2, 'Notebook'),
(3, 'Stapler'),
(4, 'Highlighter'),
(5, 'Sticky Notes'),
(6, 'Paper Clips'),
(7, 'Eraser'),
(8, 'Ruler'),
(9, 'Glue Stick'),
(10, 'Marker Pen');

-- Insert orders with dates across quarters into Orders table
INSERT INTO Orders (order_id, order_date) VALUES
(101, '2025-02-10'),  -- Q1
(102, '2025-05-15'),  -- Q2
(103, '2025-08-20'),  -- Q3
(104, '2025-11-05');  -- Q4

-- Insert order details into OrderDetails table
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 101, 1, 100, 0.50),    -- Order 101, Q1: Ballpoint Pen
(2, 101, 2, 50, 2.00),     -- Order 101, Q1: Notebook
(3, 102, 3, 20, 5.00),     -- Order 102, Q2: Stapler
(4, 102, 4, 30, 1.50),     -- Order 102, Q2: Highlighter
(5, 103, 5, 40, 1.00),     -- Order 103, Q3: Sticky Notes
(6, 103, 6, 100, 0.10),    -- Order 103, Q3: Paper Clips
(7, 104, 7, 25, 0.30),     -- Order 104, Q4: Eraser
(8, 104, 8, 10, 0.75),     -- Order 104, Q4: Ruler
(9, 104, 9, 15, 1.20),     -- Order 104, Q4: Glue Stick
(10, 104, 10, 20, 1.50);   -- Order 104, Q4: Marker Pen

-- Q6: Compare Q1, Q2, Q3, Q4 revenues.
-- This query calculates the total revenue for each quarter.
-- It uses a Common Table Expression (CTE) named 'quarters' to ensure all four quarters are
-- present in the output, even if there's no revenue for a particular quarter.
-- It then LEFT JOINs this CTE with the Orders, OrderDetails, and Products tables
-- to sum up the revenue (quantity * unit_price) for each quarter.
-- COALESCE is used to display 0 instead of NULL for quarters with no revenue.
WITH quarters AS (
  SELECT 1 AS quarter UNION ALL
  SELECT 2 UNION ALL
  SELECT 3 UNION ALL
  SELECT 4
)
SELECT
  q.quarter,
  COALESCE(SUM(od.quantity * od.unit_price), 0) AS revenue
FROM quarters q
LEFT JOIN Orders o
  ON QUARTER(o.order_date) = q.quarter
LEFT JOIN OrderDetails od
  ON o.order_id = od.order_id
LEFT JOIN Products p
  ON od.product_id = p.product_id -- This join is not strictly necessary for revenue calculation if unit_price is in OrderDetails
GROUP BY
  q.quarter
ORDER BY
  q.quarter;
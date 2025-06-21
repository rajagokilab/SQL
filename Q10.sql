-- Create Database
CREATE DATABASE Q10_ecommerce;

-- Use the created database
USE Q10_ecommerce;

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    category VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Returns table
CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    order_detail_id INT,
    returned_quantity INT,
    return_date DATE,
    reason VARCHAR(255),
    FOREIGN KEY (order_detail_id) REFERENCES OrderDetails(order_detail_id)
);

-- Insert Orders
INSERT INTO Orders (order_id, order_date) VALUES
(1, '2025-06-01'),
(2, '2025-06-02'),
(3, '2025-06-03'),
(4, '2025-06-04'), -- New Order
(5, '2025-06-05'); -- New Order

-- Insert OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, category, quantity) VALUES
(101, 1, 1001, 'Electronics', 3),
(102, 1, 1002, 'Books', 2),
(103, 2, 1001, 'Electronics', 1),
(104, 3, 1003, 'Clothing', 4),
(105, 4, 1004, 'Home Goods', 5), -- New Order Detail
(106, 4, 1005, 'Books', 1),     -- New Order Detail
(107, 5, 1001, 'Electronics', 2), -- New Order Detail for existing product_id 1001
(108, 5, 1003, 'Clothing', 3);   -- New Order Detail for existing product_id 1003

-- Insert Returns (2 returns for product 1001 and 1 for 1003)
INSERT INTO Returns (return_id, order_detail_id, returned_quantity, return_date, reason) VALUES
(201, 101, 1, '2025-06-05', 'Defective item'),
(202, 103, 1, '2025-06-06', 'Wrong item'),
(203, 104, 2, '2025-06-07', 'Size issue'),
(204, 105, 1, '2025-06-08', 'Damaged in transit'), -- New Return
(205, 107, 1, '2025-06-09', 'Customer changed mind'); -- New Return for product 1001
-- Note: product 1005 has no returns

-- Query to calculate return rate per product
-- This query calculates the total units sold, total units returned, and the return rate percentage
-- for each product. It uses a LEFT JOIN to include returns data, even if a product has no returns.
-- COALESCE is used to treat NULL values (for products with no returns) as 0.
-- NULLIF is used in the return rate calculation to prevent division by zero.
SELECT
    od.product_id,
    SUM(od.quantity) AS TotalSoldUnits,
    COALESCE(SUM(r.returned_quantity), 0) AS TotalReturnedUnits,
    CONCAT(
      ROUND(
        COALESCE(SUM(r.returned_quantity), 0) * 100.0 / NULLIF(SUM(od.quantity), 0),
        2
      ), '%'
    ) AS ReturnRatePercent
FROM
    OrderDetails od
LEFT JOIN
    Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY
    od.product_id
ORDER BY
    ReturnRatePercent DESC;

-- Query to calculate return rate per category
-- This query calculates the total units sold, total units returned, and the return rate percentage
-- for each product category. It uses a LEFT JOIN to include returns data, even if a category has no returns.
-- COALESCE is used to treat NULL values (for categories with no returns) as 0.
-- NULLIF is used in the return rate calculation to prevent division by zero.
SELECT
    od.category,
    SUM(od.quantity) AS TotalSoldUnits,
    COALESCE(SUM(r.returned_quantity), 0) AS TotalReturnedUnits,
    CONCAT(
      ROUND(
        COALESCE(SUM(r.returned_quantity), 0) * 100.0 / NULLIF(SUM(od.quantity), 0),
        2
      ), '%'
    ) AS ReturnRatePercent
FROM
    OrderDetails od
LEFT JOIN
    Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY
    od.category
ORDER BY
    ReturnRatePercent DESC;
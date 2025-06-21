
CREATE DATABASE Q9_ecommerce;
-- SHOW DATABASES;
USE Q9_ecommerce;
-- Create Promotions table
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY,
    product_id INT,
    discount_percent DECIMAL(5,2)
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
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert sample data into Promotions
INSERT INTO Promotions (promotion_id, product_id, discount_percent) VALUES
(1, 1001, 10.00),  -- Product 1001 has 10% discount
(2, 1002, 0.00),   -- Product 1002 no discount
(3, 1003, 20.00);  -- Product 1003 has 20% discount

-- Insert sample data into Orders
INSERT INTO Orders (order_id, order_date) VALUES
(5001, '2025-06-01'),
(5002, '2025-06-02'),
(5003, '2025-06-03');

-- Insert sample data into OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price) VALUES
(9001, 5001, 1001, 2, 500.00),  -- 2 units of product 1001 (discounted)
(9002, 5001, 1002, 1, 300.00),  -- 1 unit product 1002 (no discount)
(9003, 5002, 1003, 3, 200.00),  -- 3 units product 1003 (discounted)
(9004, 5003, 1002, 2, 300.00);  -- 2 units product 1002 (no discount)

SELECT
    CASE 
        WHEN p.discount_percent > 0 THEN 'With Discount'
        ELSE 'Without Discount'
    END AS DiscountStatus,
    SUM(od.quantity * od.price) AS TotalSales,
    COUNT(DISTINCT o.order_id) AS NumberOfOrders,
    COUNT(DISTINCT od.product_id) AS NumberOfProductsSold
FROM 
    OrderDetails od
JOIN 
    Orders o ON od.order_id = o.order_id
LEFT JOIN 
    Promotions p ON od.product_id = p.product_id
GROUP BY 
    DiscountStatus;


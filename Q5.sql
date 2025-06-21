CREATE DATABASE  Q5_ecommerce;
USE Q5_ecommerce;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    stock_quantity INT,
    reorder_level INT
);

INSERT INTO Products (product_id, product_name, stock_quantity, reorder_level) VALUES
(11, 'Idli Maker', 7, 5),
(12, 'Dosa Tawa', 4, 3),
(13, 'Filter Coffee Powder', 25, 10),
(14, 'Sambar Masala', 12, 8),
(15, 'Coconut Chutney Mix', 6, 4),
(16, 'Rasam Powder', 15, 10),
(17, 'Medu Vada Batter', 3, 5),
(18, 'Pongal Rice', 10, 7),
(19, 'Murukku', 20, 12),
(20, 'Banana Leaf Plates', 30, 15);
-- Q5

SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level,
    CASE 
        WHEN stock_quantity <= reorder_level THEN 'LOW STOCK ALERT'
        ELSE 'Stock OK'
    END AS stock_status
FROM Products
WHERE stock_quantity <= reorder_level;






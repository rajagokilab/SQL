CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;
DROP database ECOMMERCE;
-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Customers
INSERT INTO Customers (customer_id, name, email) VALUES
(1, 'Karthi', 'karthi@example.com'),
(2, 'Anu', 'anu@example.com'),
(3, 'Ravi', 'ravi@example.com');

-- Products (Grocery)
INSERT INTO Products (product_id, name, price) VALUES
(201, 'Rice - Ponni Boiled', 40.00),
(202, 'Toor Dal', 120.50),
(203, 'Coconut Oil', 180.00),
(204, 'Turmeric Powder', 25.00),
(205, 'Green Chilli', 10.00);

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(3001, 1, '2025-06-10'),
(3002, 1, '2025-06-18'),
(3003, 2, '2025-06-20'),
(3004, 3, '2025-06-22');

-- OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(3001, 201, 2),  
(3001, 203, 1), 
(3002, 205, 5), 
(3003, 202, 3), 
(3003, 204, 1),  
(3004, 201, 1),
(3004, 205, 10);


-- Q2
WITH MonthlyProductSales AS (
    SELECT
        MONTH(o.order_date) AS order_month,
        p.product_id,
        p.name AS product_name,
        SUM(od.quantity) AS total_quantity_sold
    FROM Orders o
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    GROUP BY MONTH(o.order_date), p.product_id, p.name
),

TopMonthlySales AS (
    SELECT
        order_month,
        MAX(total_quantity_sold) AS max_quantity
    FROM MonthlyProductSales
    GROUP BY order_month
)

SELECT
    mps.order_month,
    mps.product_id,
    mps.product_name,
    mps.total_quantity_sold
FROM MonthlyProductSales mps
JOIN TopMonthlySales tms ON mps.order_month = tms.order_month
                        AND mps.total_quantity_sold = tms.max_quantity
ORDER BY mps.order_month;





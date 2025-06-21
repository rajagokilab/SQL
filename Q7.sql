
CREATE DATABASE Q7_ecommerce;
-- SHOW DATABASES;
USE Q7_ecommerce;
-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
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
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert data into Categories
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books');

-- Insert data into Products
INSERT INTO Products (product_id, product_name, category_id) VALUES
(101, 'Smartphone', 1),
(102, 'Laptop', 1),
(103, 'T-shirt', 2),
(104, 'Jeans', 2),
(105, 'Novel', 3),
(106, 'Notebook', 3);

-- Insert data into Orders
INSERT INTO Orders (order_id, order_date) VALUES
(1001, '2025-06-01'),
(1002, '2025-06-05'),
(1003, '2025-06-10');

-- Insert data into OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 1, 500.00),  
(2, 1001, 103, 2, 20.00),  
(3, 1002, 102, 1, 1200.00), 
(4, 1002, 104, 1, 40.00),   
(5, 1002, 105, 3, 15.00),  
(6, 1003, 106, 5, 5.00);   

-- Q7
SELECT
    c.category_name,
    AVG(order_totals.order_value) AS avg_order_value
FROM
    Categories c
JOIN
    Products p ON c.category_id = p.category_id
JOIN
    (
        SELECT
            od.order_id,
            od.product_id,
            SUM(od.quantity * od.unit_price) AS order_value
        FROM
            OrderDetails od
        GROUP BY
            od.order_id,
            od.product_id
    ) AS order_totals ON p.product_id = order_totals.product_id
GROUP BY
    c.category_name
ORDER BY
    avg_order_value DESC;


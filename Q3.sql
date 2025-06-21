CREATE DATABASE Q3_ECOMMERCE;
USE Q3_ECOMMERCE;

-- Customers Table with region and city
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    region VARCHAR(100),
    city VARCHAR(100)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Q3
SELECT
    c.region,
    c.city,
    SUM(od.quantity * p.price) AS total_sales_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.region, c.city
ORDER BY c.region, c.city;


-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers with region and city
INSERT INTO Customers (customer_id, name, email, region, city) VALUES
(1, 'Karthi', 'karthi@example.com', 'Tamil Nadu', 'Chennai'),
(2, 'Anu', 'anu@example.com', 'Karnataka', 'Bangalore'),
(3, 'Ravi', 'ravi@example.com', 'Kerala', 'Kochi');

-- Insert Products (Grocery)
INSERT INTO Products (product_id, name, price) VALUES
(201, 'Rice - Ponni Boiled', 40.00),
(202, 'Toor Dal', 120.50),
(203, 'Coconut Oil', 180.00),
(204, 'Turmeric Powder', 25.00),
(205, 'Green Chilli', 10.00);

-- Insert Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(3001, 1, '2025-06-10'),
(3002, 1, '2025-06-18'),
(3003, 2, '2025-06-20'),
(3004, 3, '2025-06-22');

-- Insert OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(3001, 201, 2),  
(3001, 203, 1), 
(3002, 205, 5), 
(3003, 202, 3), 
(3003, 204, 1),  
(3004, 201, 1),
(3004, 205, 10);



-- Q3

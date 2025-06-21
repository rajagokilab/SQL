
CREATE DATABASE Q8_ecommerce;
-- SHOW DATABASES;
USE Q8_ecommerce;
-- Create Categories table
-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Customers with South Indian short names
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Arun'),
(2, 'Karthi'),
(3, 'Latha'),
(4, 'Mani');

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2025-06-01'),
(102, 2, '2025-06-02'),
(103, 1, '2025-06-10'),
(104, 3, '2025-06-11'),
(105, 2, '2025-06-15');

-- Query repeat customers
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    COUNT(o.OrderID) AS OrderCount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, 
    c.CustomerName
HAVING 
    COUNT(o.OrderID) > 1;



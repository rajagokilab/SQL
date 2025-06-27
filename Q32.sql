CREATE DATABASE Q31_ExpenseTracker;
USE Q31_ExpenseTracker;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
INSERT INTO Users (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
INSERT INTO Categories (name) VALUES
('Food'),
('Rent'),
('Transportation'),
('Utilities'),
('Entertainment'),
('Miscellaneous');
CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10, 2),
    description VARCHAR(255),
    expense_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
INSERT INTO Expenses (user_id, category_id, amount, description, expense_date) VALUES
-- Alice's Expenses
(1, 1, 150.00, 'Groceries at Walmart', '2025-06-01'),
(1, 2, 900.00, 'Monthly rent', '2025-06-05'),
(1, 3, 50.00, 'Bus pass', '2025-06-10'),
(1, 4, 100.00, 'Electricity bill', '2025-06-12'),
(1, 5, 60.00, 'Movie tickets', '2025-06-20'),

-- Bob's Expenses
(2, 1, 120.00, 'Dining out', '2025-06-03'),
(2, 2, 850.00, 'Apartment rent', '2025-06-04'),
(2, 3, 40.00, 'Fuel', '2025-06-07'),
(2, 5, 25.00, 'Streaming service', '2025-06-08'),
(2, 6, 30.00, 'Stationery', '2025-06-09');

SELECT 
    c.name AS category_name,
    SUM(e.amount) AS total_spent
FROM 
    Expenses e
JOIN 
    Categories c ON e.category_id = c.category_id
JOIN 
    Users u ON e.user_id = u.user_id
WHERE 
    u.name = 'Alice Smith'
GROUP BY 
    c.name
ORDER BY 
    total_spent DESC;






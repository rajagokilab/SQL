CREATE DATABASE ExpenseTracker;
USE ExpenseTracker;
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
(1, 1, 150.00, 'Groceries at Walmart', '2025-06-01'),
(1, 2, 900.00, 'Monthly apartment rent', '2025-06-05'),
(1, 3, 50.00, 'Bus pass', '2025-06-10'),
(2, 1, 120.00, 'Dining out', '2025-06-03'),
(2, 5, 60.00, 'Netflix subscription', '2025-06-08');
SELECT u.name, SUM(e.amount) AS total_spent
FROM Expenses e
JOIN Users u ON e.user_id = u.user_id
WHERE u.name = 'Alice Smith' AND MONTH(e.expense_date) = 6 AND YEAR(e.expense_date) = 2025;


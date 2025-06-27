CREATE DATABASE Q33_ExpenseTracker;
USE Q33_ExpenseTracker;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
INSERT INTO Users (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');
CREATE TABLE Cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    card_type VARCHAR(50),      
    bank_name VARCHAR(100),
    card_number VARCHAR(16),    
    issued_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Cards (user_id, card_type, bank_name, card_number, issued_date) VALUES
(1, 'Credit', 'Chase Bank', '1234567812345678', '2022-01-15'),
(1, 'Debit', 'Bank of America', '8765432187654321', '2021-09-10'),
(2, 'Credit', 'Wells Fargo', '1111222233334444', '2023-05-01');
CREATE TABLE CardTransactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    card_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    merchant_name VARCHAR(100),
    category VARCHAR(50),           -- e.g., Food, Travel, Online
    location VARCHAR(100),
    FOREIGN KEY (card_id) REFERENCES Cards(card_id)
);
INSERT INTO CardTransactions (card_id, transaction_date, amount, merchant_name, category, location) VALUES
-- Alice's Credit Card (Chase)
(1, '2025-06-01', 150.00, 'Walmart', 'Groceries', 'New York'),
(1, '2025-06-10', 60.00, 'Netflix', 'Entertainment', 'Online'),
(1, '2025-06-15', 300.00, 'Apple Store', 'Electronics', 'New York'),

-- Alice's Debit Card (BOA)
(2, '2025-06-05', 100.00, 'CVS Pharmacy', 'Health', 'New York'),
(2, '2025-06-25', 45.00, 'Uber', 'Transportation', 'New York'),

-- Bob's Credit Card (Wells Fargo)
(3, '2025-06-03', 500.00, 'Amazon', 'Online Shopping', 'Online'),
(3, '2025-06-20', 85.00, 'Spotify', 'Entertainment', 'Online');

SELECT
    c.card_id,
    c.card_type,
    c.bank_name,
    SUM(t.amount) AS total_spent
FROM
    CardTransactions t
JOIN
    Cards c ON t.card_id = c.card_id
GROUP BY
    c.card_id,
    c.card_type,
    c.bank_name
ORDER BY
    total_spent DESC;





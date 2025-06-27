CREATE DATABASE AccountLedgerDB;
USE AccountLedgerDB;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
INSERT INTO Users (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    account_name VARCHAR(100),
    account_type VARCHAR(50),   -- e.g., 'Savings', 'Current'
    opening_balance DECIMAL(12, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Accounts (user_id, account_name, account_type, opening_balance) VALUES
(1, 'Alice Savings', 'Savings', 5000.00),
(2, 'Bob Current', 'Current', 10000.00);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_date DATE,
    description VARCHAR(255),
    debit DECIMAL(12, 2),
    credit DECIMAL(12, 2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
INSERT INTO Transactions (account_id, transaction_date, description, debit, credit) VALUES
-- Alice's Account
(1, '2025-06-01', 'Salary', 0.00, 3000.00),
(1, '2025-06-05', 'Electricity Bill', 200.00, 0.00),
(1, '2025-06-10', 'Grocery Shopping', 150.00, 0.00),

-- Bob's Account
(2, '2025-06-02', 'Freelance Payment', 0.00, 5000.00),
(2, '2025-06-08', 'Rent Payment', 1200.00, 0.00);
SELECT 
    t.transaction_date,
    t.description,
    t.debit,
    t.credit,
    SUM(IFNULL(t.credit, 0) - IFNULL(t.debit, 0)) OVER (PARTITION BY t.account_id ORDER BY t.transaction_date) 
        + a.opening_balance AS running_balance
FROM 
    Transactions t
JOIN 
    Accounts a ON t.account_id = a.account_id
WHERE 
    a.account_id = 1
ORDER BY 
    t.transaction_date;






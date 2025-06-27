CREATE DATABASE FraudDetectionDB;
USE FraudDetectionDB;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    account_number VARCHAR(20),
    account_type VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    from_account INT,
    to_account INT,
    amount DECIMAL(12, 2),
    transfer_time DATETIME,
    FOREIGN KEY (from_account) REFERENCES Accounts(account_id),
    FOREIGN KEY (to_account) REFERENCES Accounts(account_id)
);
-- Users
INSERT INTO Users (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

-- Accounts
INSERT INTO Accounts (user_id, account_number, account_type) VALUES
(1, 'A123456789', 'Savings'),
(2, 'B987654321', 'Savings');

-- Transfers
INSERT INTO Transfers (from_account, to_account, amount, transfer_time) VALUES
(1, 2, 120000.00, '2025-06-27 09:00:00'),
(1, 2, 130000.00, '2025-06-27 09:03:00'),
(1, 2, 140000.00, '2025-06-27 09:05:00'), 
(1, 2, 80000.00,  '2025-06-27 10:00:00');

SELECT 
    t1.transfer_id,
    t1.from_account,
    t1.to_account,
    t1.amount,
    t1.transfer_time
FROM 
    Transfers t1
JOIN 
    Transfers t2 ON t1.from_account = t2.from_account
WHERE 
    t1.amount > 100000 AND 
    t2.amount > 100000 AND 
    t1.transfer_id <> t2.transfer_id AND
    ABS(TIMESTAMPDIFF(MINUTE, t1.transfer_time, t2.transfer_time)) <= 10
ORDER BY 
    t1.transfer_time;




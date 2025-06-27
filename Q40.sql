-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS BalanceDropWarning;
USE BalanceDropWarning;

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Accounts Table to track balances
CREATE TABLE IF NOT EXISTS Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    Balance DECIMAL(15, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Thresholds Table (optional, can be global or per customer)
CREATE TABLE IF NOT EXISTS BalanceThresholds (
    ThresholdID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ThresholdAmount DECIMAL(15, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Alerts Table for warnings
CREATE TABLE IF NOT EXISTS BalanceAlerts (
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountID INT,
    AlertDate DATETIME,
    AlertStatus VARCHAR(20), -- e.g. 'Sent', 'Pending', 'Resolved'
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Sample Data Inserts
INSERT INTO Customers (Name, Email, Phone) VALUES
('Alice Smith', 'alice@example.com', '123-456-7890'),
('Bob Johnson', 'bob@example.com', '234-567-8901');

INSERT INTO Accounts (CustomerID, Balance) VALUES
(1, 150.00),
(2, 80.00);

-- Set threshold per customer (e.g., warn if balance < 100)
INSERT INTO BalanceThresholds (CustomerID, ThresholdAmount) VALUES
(1, 100.00),
(2, 100.00);

-- Query to find accounts below threshold without an alert yet
SELECT 
    a.AccountID,
    c.CustomerID,
    c.Name,
    a.Balance,
    t.ThresholdAmount
FROM Accounts a
JOIN Customers c ON a.CustomerID = c.CustomerID
JOIN BalanceThresholds t ON c.CustomerID = t.CustomerID
LEFT JOIN BalanceAlerts al ON a.AccountID = al.AccountID
WHERE a.Balance < t.ThresholdAmount
  AND (al.AlertStatus IS NULL OR al.AlertStatus != 'Sent');

-- Insert alerts for those who have balance below threshold and no alert sent yet
INSERT INTO BalanceAlerts (CustomerID, AccountID, AlertDate, AlertStatus)
SELECT 
    a.CustomerID,
    a.AccountID,
    NOW(),
    'Sent'
FROM Accounts a
JOIN BalanceThresholds t ON a.CustomerID = t.CustomerID
LEFT JOIN BalanceAlerts al ON a.AccountID = al.AccountID AND al.AlertStatus = 'Sent'
WHERE a.Balance < t.ThresholdAmount
  AND al.AlertID IS NULL;

CREATE DATABASE IF NOT EXISTS PnL_Summary;
USE PnL_Summary;

-- Table for different accounts (Revenue, Expense, etc.)
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    AccountName VARCHAR(100),
    AccountType VARCHAR(20)  -- 'Revenue' or 'Expense'
);

-- Table for transactions (revenue or expense entries)
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(15, 2),
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
INSERT INTO Accounts (AccountName, AccountType) VALUES
('Sales Revenue', 'Revenue'),
('Service Revenue', 'Revenue'),
('Cost of Goods Sold', 'Expense'),
('Rent Expense', 'Expense'),
('Salaries Expense', 'Expense');

INSERT INTO Transactions (AccountID, TransactionDate, Amount, Description) VALUES
(1, '2025-06-01', 50000.00, 'Product sales'),
(2, '2025-06-02', 15000.00, 'Service income'),
(3, '2025-06-05', 20000.00, 'Materials bought'),
(4, '2025-06-10', 5000.00, 'Office rent June'),
(5, '2025-06-15', 12000.00, 'Employee salaries June');
SELECT 
    a.AccountType,
    a.AccountName,
    SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
WHERE t.TransactionDate BETWEEN '2025-06-01' AND '2025-06-30'
GROUP BY a.AccountType, a.AccountName
ORDER BY a.AccountType, a.AccountName;
SELECT 
    SUM(CASE WHEN a.AccountType = 'Revenue' THEN t.Amount ELSE 0 END) AS TotalRevenue,
    SUM(CASE WHEN a.AccountType = 'Expense' THEN t.Amount ELSE 0 END) AS TotalExpense,
    SUM(CASE WHEN a.AccountType = 'Revenue' THEN t.Amount ELSE 0 END) 
      - SUM(CASE WHEN a.AccountType = 'Expense' THEN t.Amount ELSE 0 END) AS NetProfit
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
WHERE t.TransactionDate BETWEEN '2025-06-01' AND '2025-06-30';



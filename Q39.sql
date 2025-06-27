-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS Branch_Performance;
USE Branch_Performance;

-- Create Branches Table
CREATE TABLE IF NOT EXISTS Branches (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100),
    Location VARCHAR(100)
);

-- Create BranchTargets Table
CREATE TABLE IF NOT EXISTS BranchTargets (
    TargetID INT PRIMARY KEY AUTO_INCREMENT,
    BranchID INT,
    TargetMonth DATE,
    TargetAmount DECIMAL(15, 2),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Create BranchPerformance Table
CREATE TABLE IF NOT EXISTS BranchPerformance (
    PerformanceID INT PRIMARY KEY AUTO_INCREMENT,
    BranchID INT,
    PerformanceMonth DATE,
    ActualAmount DECIMAL(15, 2),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Insert Sample Data into Branches
INSERT INTO Branches (BranchName, Location) VALUES
('Downtown', 'New York'),
('Uptown', 'New York'),
('Midtown', 'New York');

-- Insert Sample Data into BranchTargets (June 2025)
INSERT INTO BranchTargets (BranchID, TargetMonth, TargetAmount) VALUES
(1, '2025-06-01', 100000.00),
(2, '2025-06-01', 80000.00),
(3, '2025-06-01', 90000.00);

-- Insert Sample Data into BranchPerformance (June 2025)
INSERT INTO BranchPerformance (BranchID, PerformanceMonth, ActualAmount) VALUES
(1, '2025-06-01', 95000.00),
(2, '2025-06-01', 85000.00),
(3, '2025-06-01', 87000.00);

-- Query: Branch Performance vs Targets for June 2025
SELECT 
    b.BranchName,
    t.TargetAmount,
    p.ActualAmount,
    (p.ActualAmount - t.TargetAmount) AS Variance,
    ROUND((p.ActualAmount / t.TargetAmount) * 100, 2) AS AchievementPercent
FROM Branches b
JOIN BranchTargets t ON b.BranchID = t.BranchID AND t.TargetMonth = '2025-06-01'
JOIN BranchPerformance p ON b.BranchID = p.BranchID AND p.PerformanceMonth = '2025-06-01'
ORDER BY AchievementPercent DESC;

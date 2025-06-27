CREATE DATABASE EMIScheduleDB;
USE EMIScheduleDB;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
INSERT INTO Users (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    principal_amount DECIMAL(12, 2),
    annual_interest_rate DECIMAL(5, 2),  -- e.g., 12.5%
    loan_term_months INT,
    start_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Loans (user_id, principal_amount, annual_interest_rate, loan_term_months, start_date) VALUES
(1, 120000.00, 12.0, 12, '2025-07-01'),
(2, 60000.00, 10.5, 6, '2025-07-15');
CREATE TABLE EMISchedule (
    emi_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    due_date DATE,
    principal_component DECIMAL(10, 2),
    interest_component DECIMAL(10, 2),
    total_emi DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);
INSERT INTO EMISchedule (loan_id, due_date, principal_component, interest_component, total_emi) VALUES
(1, '2025-08-01', 8967.23, 1200.00, 10167.23),
(1, '2025-09-01', 9030.23, 1137.00, 10167.23),
(1, '2025-10-01', 9094.02, 1073.21, 10167.23);

SELECT 
    e.due_date,
    e.total_emi,
    e.principal_component,
    e.interest_component,
    e.status
FROM 
    EMISchedule e
JOIN 
    Loans l ON e.loan_id = l.loan_id
WHERE 
    l.loan_id = 1
ORDER BY e.due_date;


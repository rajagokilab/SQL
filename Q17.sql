
CREATE DATABASE HiringSourceEffectiveness;
-- SHOW DATABASES;
USE HiringSourceEffectiveness;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    hire_date DATE,
    source VARCHAR(50) -- e.g., 'Referral', 'Job Portal', 'Campus', 'Agency'
);
INSERT INTO Employees (employee_id, name, hire_date, source) VALUES
(1, 'Aarav Sharma', '2022-01-15', 'Referral'),
(2, 'Diya Patel', '2022-02-20', 'Job Portal'),
(3, 'Raj Verma', '2022-03-05', 'Referral'),
(4, 'Sneha Iyer', '2022-04-01', 'Campus'),
(5, 'Vikram Reddy', '2022-04-10', 'Job Portal'),
(6, 'Neha Das', '2022-05-12', 'Agency'),
(7, 'Karan Mehta', '2022-06-01', 'Referral');
SELECT 
    source,
    COUNT(*) AS total_hires
FROM 
    Employees
GROUP BY 
    source
ORDER BY 
    total_hires DESC;


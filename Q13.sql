CREATE DATABASE Tenure_by_Department;
USE Tenure_by_Department;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    join_date DATE,
    resign_date DATE -- NULL if still working
);
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR');
INSERT INTO Employees (employee_id, name, department_id, join_date, resign_date) VALUES
(1, 'Aarav Sharma', 1, '2021-01-10', '2023-06-15'),
(2, 'Diya Patel', 1, '2020-07-01', NULL),
(3, 'Raj Verma', 2, '2022-03-20', '2023-12-31'),
(4, 'Sneha Iyer', 2, '2021-05-05', NULL),
(5, 'Vikram Reddy', 3, '2023-01-01', '2024-01-01');
SELECT 
    d.department_name,
    ROUND(AVG(DATEDIFF(
        COALESCE(e.resign_date, CURRENT_DATE),
        e.join_date
    ) / 30.0), 2) AS avg_months_worked
FROM 
    Employees e
JOIN 
    Departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_name;






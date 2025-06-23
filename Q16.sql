-- Create Database
CREATE DATABASE Gender_Diversity_Report;
SHOW DATABASES;

USE  Gender_Diversity_Report;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10), -- e.g., 'Male', 'Female'
    department_id INT
);
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100)
);
INSERT INTO Departments (department_id, name) VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Marketing');

INSERT INTO Employees (employee_id, name, gender, department_id) VALUES
(1, 'Aarav Sharma', 'Male', 1),
(2, 'Diya Patel', 'Female', 1),
(3, 'Raj Verma', 'Male', 2),
(4, 'Sneha Iyer', 'Female', 2),
(5, 'Vikram Reddy', 'Male', 3),
(6, 'Neha Das', 'Female', 3),
(7, 'Karan Mehta', 'Male', 1);
SELECT 
    d.name AS department,
    e.gender,
    COUNT(*) AS employee_count
FROM 
    Employees e
JOIN 
    Departments d ON e.department_id = d.department_id
GROUP BY 
    d.name, e.gender
ORDER BY 
    d.name, e.gender;



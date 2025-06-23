
CREATE DATABASE PerformanceReviewAggregation;
-- SHOW DATABASES;
USE PerformanceReviewAggregation;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT
);
CREATE TABLE PerformanceReviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    review_date DATE,
    rating DECIMAL(3, 2),  -- e.g., 4.5 out of 5
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR');
INSERT INTO Employees (employee_id, name, department_id) VALUES
(1, 'Aarav Sharma', 1),
(2, 'Diya Patel', 1),
(3, 'Raj Verma', 2),
(4, 'Sneha Iyer', 3);
INSERT INTO PerformanceReviews (employee_id, review_date, rating) VALUES
(1, '2023-01-01', 4.5),
(1, '2024-01-01', 4.0),
(2, '2023-01-01', 3.5),
(3, '2023-01-01', 4.8),
(4, '2023-01-01', 4.2);
SELECT 
    d.department_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM 
    PerformanceReviews r
JOIN 
    Employees e ON r.employee_id = e.employee_id
JOIN 
    Departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_name
ORDER BY 
    average_rating DESC;



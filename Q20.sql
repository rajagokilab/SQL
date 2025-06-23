-- Create Database
CREATE DATABASE AnnualAppraisalReport;

-- Use the created database
USE AnnualAppraisalReport;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT
);
INSERT INTO Employees (employee_id, name, department_id) VALUES
(1, 'Aarav Sharma', 1),
(2, 'Diya Patel', 2),
(3, 'Raj Verma', 1),
(4, 'Sneha Iyer', 3);

CREATE TABLE Appraisals (
    appraisal_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    year INT,
    rating DECIMAL(3,2),
    comments TEXT
);
INSERT INTO Appraisals (appraisal_id, employee_id, year, rating, comments) VALUES
(1, 1, 2023, 4.5, 'Excellent teamwork'),
(2, 1, 2023, 4.2, 'Good leadership'),
(3, 2, 2023, 3.8, 'Meets expectations'),
(4, 3, 2023, 4.0, 'Consistent performance'),
(5, 3, 2024, 4.3, 'Improved skills'),
(6, 4, 2024, 4.7, 'Outstanding results');

SELECT 
    e.employee_id,
    e.name,
    e.department_id,
    a.year,
    ROUND(AVG(a.rating), 2) AS avg_rating,
    COUNT(*) AS total_appraisals,
    GROUP_CONCAT(a.comments SEPARATOR '; ') AS comments_summary
FROM 
    Employees e
JOIN 
    Appraisals a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id, e.name, e.department_id, a.year
ORDER BY 
    e.employee_id, a.year;


CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    old_title VARCHAR(100),
    new_title VARCHAR(100),
    promotion_date DATE
);
INSERT INTO Promotions (promotion_id, employee_id, old_title, new_title, promotion_date) VALUES
(1, 1, 'Junior Engineer', 'Engineer', '2022-03-01'),
(2, 1, 'Engineer', 'Senior Engineer', '2023-05-15'),
(3, 2, 'HR Assistant', 'HR Executive', '2023-07-10'),
(4, 3, 'Marketing Intern', 'Marketing Executive', '2022-01-01'),
(5, 3, 'Marketing Executive', 'Marketing Manager', '2024-02-10');

SELECT 
    p.employee_id,
    COUNT(*) AS total_promotions,
    MAX(p.promotion_date) AS last_promotion_date,
    SUBSTRING_INDEX(
      GROUP_CONCAT(p.new_title ORDER BY p.promotion_date DESC),
      ',', 1
    ) AS latest_title
FROM 
    Promotions p
GROUP BY 
    p.employee_id
ORDER BY 
    total_promotions DESC;


CREATE DATABASE EmployeePromotionHistory;
-- SHOW DATABASES;
USE  EmployeePromotionHistory;
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    old_title VARCHAR(100),
    new_title VARCHAR(100),
    promotion_date DATE
);
INSERT INTO Promotions (employee_id, old_title, new_title, promotion_date) VALUES
(1, 'Junior Engineer', 'Engineer', '2021-03-01'),
(1, 'Engineer', 'Senior Engineer', '2023-05-15'),
(2, 'HR Assistant', 'HR Executive', '2022-07-10'),
(3, 'Marketing Intern', 'Marketing Executive', '2022-01-01'),
(3, 'Marketing Executive', 'Marketing Manager', '2024-02-10');
-- Get total promotions and latest new_title per employee
SELECT 
    p.employee_id,
    COUNT(*) AS total_promotions,
    MAX(p.promotion_date) AS last_promotion_date,
    (
        SELECT new_title
        FROM Promotions p2
        WHERE p2.employee_id = p.employee_id
        ORDER BY p2.promotion_date DESC
        LIMIT 1
    ) AS latest_title
FROM 
    Promotions p
GROUP BY 
    p.employee_id
ORDER BY 
    total_promotions DESC;



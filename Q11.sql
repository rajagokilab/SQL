CREATE DATABASE Attendance;
USE Attendance;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE AttendanceLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
INSERT INTO Employees (employee_id, name) VALUES
(1, 'Aarav Sharma'),
(2, 'Diya Patel'),
(3, 'Raj Verma'),
(4, 'Sneha Iyer'),
(5, 'Vikram Reddy');
INSERT INTO AttendanceLogs (employee_id, date, status) VALUES
(1, '2025-06-01', 'Present'),
(1, '2025-06-02', 'Absent'),
(1, '2025-06-03', 'Present'),
(2, '2025-06-01', 'Present'),
(2, '2025-06-02', 'Present'),
(2, '2025-06-03', 'Present'),
(3, '2025-06-01', 'Absent'),
(3, '2025-06-02', 'Absent'),
(3, '2025-06-03', 'Present'),
(4, '2025-06-01', 'Present'),
(4, '2025-06-02', 'Present'),
(5, '2025-06-01', 'Absent'),
(5, '2025-06-02', 'Absent');
-- 11
SELECT 
    e.employee_id,
    e.name,
    DATE_FORMAT(a.date, '%Y-%m') AS month,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS present_days,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS absent_days
FROM 
    Employees e
JOIN 
    AttendanceLogs a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id, e.name, DATE_FORMAT(a.date, '%Y-%m')
ORDER BY 
    e.employee_id, month;



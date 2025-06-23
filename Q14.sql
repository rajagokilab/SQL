CREATE DATABASE  Leave_Balance_System;
USE Leave_Balance_System;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE LeaveRequests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    leave_days INT,
    leave_type VARCHAR(50), -- e.g., 'Sick', 'Casual', 'Earned'
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
INSERT INTO Employees (employee_id, name) VALUES
(1, 'Aarav Sharma'),
(2, 'Diya Patel'),
(3, 'Raj Verma');
INSERT INTO LeaveRequests (employee_id, leave_days, leave_type) VALUES
(1, 2, 'Sick'),
(1, 3, 'Casual'),
(1, 1, 'Sick'),
(2, 4, 'Earned'),
(2, 1, 'Casual'),
(3, 2, 'Sick');
SELECT 
    e.employee_id,
    e.name,
    lr.leave_type,
    SUM(lr.leave_days) AS total_leave_used
FROM 
    Employees e
JOIN 
    LeaveRequests lr ON e.employee_id = lr.employee_id
GROUP BY 
    e.employee_id, e.name, lr.leave_type
ORDER BY 
    e.employee_id, lr.leave_type;











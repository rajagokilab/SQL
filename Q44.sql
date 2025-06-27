-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS AdmissionsTrend;
USE AdmissionsTrend;

-- Students Table with AdmissionDate
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100),
    AdmissionDate DATE
);

-- Insert Sample Data (various admission years)
INSERT INTO Students (StudentName, AdmissionDate) VALUES
('Alice Smith', '2022-09-15'),
('Bob Johnson', '2023-01-20'),
('Charlie Lee', '2023-06-10'),
('Diana Evans', '2024-03-05'),
('Ethan White', '2024-08-25'),
('Fiona Brown', '2025-02-12');

-- Query: Admissions Count Per Year
SELECT 
    YEAR(AdmissionDate) AS AdmissionYear,
    COUNT(*) AS TotalAdmissions
FROM Students
GROUP BY YEAR(AdmissionDate)
ORDER BY AdmissionYear;

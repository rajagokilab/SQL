-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS AttendanceTracker;
USE AttendanceTracker;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100),
    Email VARCHAR(100)
);

-- Classes Table (individual class sessions)
CREATE TABLE IF NOT EXISTS Classes (
    ClassID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    ClassDate DATE
);

-- Attendance Table (records attendance per student per class)
CREATE TABLE IF NOT EXISTS Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    ClassID INT,
    Present BOOLEAN,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Insert Sample Students
INSERT INTO Students (StudentName, Email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

-- Insert Sample Classes
INSERT INTO Classes (CourseName, ClassDate) VALUES
('Mathematics', '2025-06-01'),
('Mathematics', '2025-06-02'),
('Mathematics', '2025-06-03');

-- Insert Sample Attendance Records
INSERT INTO Attendance (StudentID, ClassID, Present) VALUES
(1, 1, TRUE),
(1, 2, TRUE),
(1, 3, FALSE),
(2, 1, TRUE),
(2, 2, FALSE),
(2, 3, FALSE);

-- Query: Calculate Attendance Rate % per Student
SELECT 
    s.StudentName,
    COUNT(a.AttendanceID) AS TotalClasses,
    SUM(CASE WHEN a.Present THEN 1 ELSE 0 END) AS ClassesAttended,
    ROUND((SUM(CASE WHEN a.Present THEN 1 ELSE 0 END) / COUNT(a.AttendanceID)) * 100, 2) AS AttendancePercent
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
GROUP BY s.StudentName
ORDER BY AttendancePercent DESC;

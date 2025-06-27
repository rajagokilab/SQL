-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS CourseCompletion;
USE CourseCompletion;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100),
    Email VARCHAR(100)
);

-- Courses Table
CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    TotalModules INT -- total number of modules to complete course
);

-- Enrollments Table (tracks which student is enrolled in which course)
CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Progress Table (tracks modules completed per enrollment)
CREATE TABLE IF NOT EXISTS Progress (
    ProgressID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT,
    ModulesCompleted INT,
    LastUpdated DATE,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

-- Sample Data Inserts

INSERT INTO Students (StudentName, Email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

INSERT INTO Courses (CourseName, TotalModules) VALUES
('Intro to SQL', 10),
('Advanced Python', 15);

INSERT INTO Enrollments (StudentID, CourseID, EnrollDate) VALUES
(1, 1, '2025-06-01'),
(1, 2, '2025-06-05'),
(2, 1, '2025-06-03');

INSERT INTO Progress (EnrollmentID, ModulesCompleted, LastUpdated) VALUES
(1, 7, '2025-06-20'),
(2, 15, '2025-06-25'),
(3, 10, '2025-06-22');

-- Query: Course Completion Status per Student and Course

SELECT 
    s.StudentName,
    c.CourseName,
    p.ModulesCompleted,
    c.TotalModules,
    ROUND((p.ModulesCompleted / c.TotalModules) * 100, 2) AS CompletionPercent,
    CASE
        WHEN p.ModulesCompleted >= c.TotalModules THEN 'Completed'
        ELSE 'In Progress'
    END AS CompletionStatus
FROM Progress p
JOIN Enrollments e ON p.EnrollmentID = e.EnrollmentID
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentName, c.CourseName;

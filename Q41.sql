-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS GradeBook;
USE GradeBook;

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
    Credits INT
);

-- Grades Table (records grades per student per course)
CREATE TABLE IF NOT EXISTS Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    Grade DECIMAL(4,2),  -- e.g. 85.50
    GradeDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Sample Students
INSERT INTO Students (StudentName, Email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

-- Insert Sample Courses
INSERT INTO Courses (CourseName, Credits) VALUES
('Mathematics', 4),
('History', 3),
('Science', 4);

-- Insert Sample Grades
INSERT INTO Grades (StudentID, CourseID, Grade, GradeDate) VALUES
(1, 1, 88.5, '2025-06-01'),
(1, 2, 92.0, '2025-06-02'),
(1, 3, 85.0, '2025-06-03'),
(2, 1, 78.0, '2025-06-01'),
(2, 2, 80.5, '2025-06-02'),
(2, 3, 82.0, '2025-06-03');

-- Query: Summary - Average Grade Per Student Across All Courses
SELECT 
    s.StudentName,
    ROUND(AVG(g.Grade), 2) AS AverageGrade,
    COUNT(g.GradeID) AS CoursesTaken
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
GROUP BY s.StudentName
ORDER BY AverageGrade DESC;

-- Query: Summary - Average Grade Per Course
SELECT 
    c.CourseName,
    ROUND(AVG(g.Grade), 2) AS AverageGrade,
    COUNT(g.GradeID) AS StudentsEnrolled
FROM Grades g
JOIN Courses c ON g.CourseID = c.CourseID
GROUP BY c.CourseName
ORDER BY AverageGrade DESC;

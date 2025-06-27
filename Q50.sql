-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS AssignmentStatus;
USE AssignmentStatus;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100)
);

-- Assignments Table
CREATE TABLE IF NOT EXISTS Assignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentTitle VARCHAR(100),
    DueDate DATE
);

-- Submissions Table (tracks submissions by students)
CREATE TABLE IF NOT EXISTS Submissions (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    AssignmentID INT,
    SubmissionDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID)
);

-- Sample Data Inserts
INSERT INTO Students (StudentName) VALUES
('Alice Smith'),
('Bob Johnson'),
('Charlie Lee');

INSERT INTO Assignments (AssignmentTitle, DueDate) VALUES
('Math Homework 1', '2025-06-10'),
('History Essay', '2025-06-15'),
('Science Project', '2025-06-20');

INSERT INTO Submissions (StudentID, AssignmentID, SubmissionDate) VALUES
(1, 1, '2025-06-09'),
(1, 2, '2025-06-14'),
(2, 1, '2025-06-11'),
(3, 3, '2025-06-20');

-- Query: Assignment Submission Status for each student and assignment
SELECT
    s.StudentName,
    a.AssignmentTitle,
    a.DueDate,
    CASE 
        WHEN sub.SubmissionDate IS NOT NULL THEN 'Submitted'
        ELSE 'Not Submitted'
    END AS SubmissionStatus,
    sub.SubmissionDate
FROM Students s
CROSS JOIN Assignments a
LEFT JOIN Submissions sub ON s.StudentID = sub.StudentID AND a.AssignmentID = sub.AssignmentID
ORDER BY s.StudentName, a.DueDate;

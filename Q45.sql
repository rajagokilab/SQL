-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS SubjectMarks;
USE SubjectMarks;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100)
);

-- Subjects Table
CREATE TABLE IF NOT EXISTS Subjects (
    SubjectID INT PRIMARY KEY AUTO_INCREMENT,
    SubjectName VARCHAR(100)
);

-- Marks Table (records marks per student per subject)
CREATE TABLE IF NOT EXISTS Marks (
    MarkID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SubjectID INT,
    MarksObtained DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Sample Data Inserts
INSERT INTO Students (StudentName) VALUES
('Alice Smith'),
('Bob Johnson'),
('Charlie Lee');

INSERT INTO Subjects (SubjectName) VALUES
('Mathematics'),
('History'),
('Science');

INSERT INTO Marks (StudentID, SubjectID, MarksObtained) VALUES
(1, 1, 85.5),
(1, 2, 78.0),
(1, 3, 92.0),
(2, 1, 75.0),
(2, 2, 80.0),
(2, 3, 85.5),
(3, 1, 90.0),
(3, 2, 85.5),
(3, 3, 88.0);

-- Query: Subject-wise Average Marks
SELECT 
    sub.SubjectName,
    ROUND(AVG(m.MarksObtained), 2) AS AverageMarks
FROM Marks m
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
GROUP BY sub.SubjectName
ORDER BY AverageMarks DESC;

-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS ScholarshipChecker;
USE ScholarshipChecker;

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

-- Marks Table
CREATE TABLE IF NOT EXISTS Marks (
    MarkID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SubjectID INT,
    MarksObtained DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Insert Sample Data
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
(3, 1, 50.0),
(3, 2, 45.0),
(3, 3, 55.0);

-- Scholarship eligibility threshold
SET @ScholarshipThreshold = 80;

-- Query: Students eligible for scholarship
SELECT 
    s.StudentName,
    ROUND(AVG(m.MarksObtained), 2) AS AverageMarks,
    CASE 
        WHEN AVG(m.MarksObtained) >= @ScholarshipThreshold THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS ScholarshipStatus
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
GROUP BY s.StudentName
ORDER BY AverageMarks DESC;

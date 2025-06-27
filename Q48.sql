-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS PassFailReport;
USE PassFailReport;

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
(1, 3, 45.0),
(2, 1, 55.0),
(2, 2, 60.0),
(2, 3, 70.5),
(3, 1, 40.0),
(3, 2, 38.0),
(3, 3, 42.0);

-- Pass mark threshold
SET @PassMark = 50;

-- Query: Pass/Fail Report per Student and Subject
SELECT
    s.StudentName,
    sub.SubjectName,
    m.MarksObtained,
    CASE 
        WHEN m.MarksObtained >= @PassMark THEN 'Pass'
        ELSE 'Fail'
    END AS Result
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
ORDER BY s.StudentName, sub.SubjectName;

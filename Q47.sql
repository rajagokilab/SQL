-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS StudentRanking;
USE StudentRanking;

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

-- Marks Table (stores marks per student per subject)
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

-- Query: Student Rank List by Total Marks
SELECT 
    s.StudentName,
    ROUND(SUM(m.MarksObtained), 2) AS TotalMarks,
    (
        SELECT COUNT(DISTINCT ROUND(SUM(m2.MarksObtained), 2))
        FROM Marks m2
        JOIN Students s2 ON m2.StudentID = s2.StudentID
        GROUP BY s2.StudentName
        HAVING ROUND(SUM(m2.MarksObtained), 2) > ROUND(SUM(m.MarksObtained), 2)
    ) + 1 AS `Rank`
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
GROUP BY s.StudentName
ORDER BY `Rank`
LIMIT 0, 50000;


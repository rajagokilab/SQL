-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS FacultyRatings;
USE FacultyRatings;

-- Faculty Table
CREATE TABLE IF NOT EXISTS Faculty (
    FacultyID INT PRIMARY KEY AUTO_INCREMENT,
    FacultyName VARCHAR(100),
    Department VARCHAR(100)
);

-- Ratings Table (stores ratings given by students)
CREATE TABLE IF NOT EXISTS Ratings (
    RatingID INT PRIMARY KEY AUTO_INCREMENT,
    FacultyID INT,
    StudentID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    RatingDate DATE,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- Sample Data Inserts
INSERT INTO Faculty (FacultyName, Department) VALUES
('Dr. Alice Smith', 'Mathematics'),
('Dr. Bob Johnson', 'History'),
('Dr. Carol Lee', 'Science');

INSERT INTO Ratings (FacultyID, StudentID, Rating, RatingDate) VALUES
(1, 101, 5, '2025-06-01'),
(1, 102, 4, '2025-06-02'),
(2, 101, 3, '2025-06-01'),
(2, 103, 4, '2025-06-03'),
(3, 104, 5, '2025-06-02'),
(3, 101, 4, '2025-06-04');

-- Query: Average Rating Per Faculty
SELECT 
    f.FacultyName,
    f.Department,
    ROUND(AVG(r.Rating), 2) AS AverageRating,
    COUNT(r.RatingID) AS NumberOfRatings
FROM Faculty f
LEFT JOIN Ratings r ON f.FacultyID = r.FacultyID
GROUP BY f.FacultyID, f.FacultyName, f.Department
ORDER BY AverageRating DESC;

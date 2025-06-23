CREATE DATABASE Employee_Turnover_Rate_Report;
USE Employee_Turnover_Rate_Report;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE,
    resign_date DATE  -- NULL if still working
);
INSERT INTO Employees (employee_id, name, join_date, resign_date) VALUES
(1, 'Aarav Sharma', '2021-03-15', '2023-04-01'),
(2, 'Diya Patel', '2021-06-10', NULL),
(3, 'Raj Verma', '2022-01-05', '2023-12-15'),
(4, 'Sneha Iyer', '2022-07-20', NULL),
(5, 'Vikram Reddy', '2023-02-11', '2024-01-10'),
(6, 'Neha Das', '2023-04-25', NULL),
(7, 'Karan Mehta', '2024-03-01', NULL);

WITH years AS (
  SELECT 2021 AS yr UNION ALL
  SELECT 2022 UNION ALL
  SELECT 2023 UNION ALL
  SELECT 2024
),
joined AS (
  SELECT YEAR(join_date) AS join_year, COUNT(*) AS join_count
  FROM Employees
  GROUP BY YEAR(join_date)
),
resigned AS (
  SELECT YEAR(resign_date) AS resign_year, COUNT(*) AS resign_count
  FROM Employees
  WHERE resign_date IS NOT NULL
  GROUP BY YEAR(resign_date)
),
headcount AS (
  SELECT 
    y.yr,
    COUNT(*) AS avg_headcount
  FROM years y
  JOIN Employees e
    ON YEAR(e.join_date) <= y.yr AND (e.resign_date IS NULL OR YEAR(e.resign_date) >= y.yr)
  GROUP BY y.yr
)

SELECT 
  y.yr AS year,
  COALESCE(r.resign_count, 0) AS resigned,
  h.avg_headcount,
  ROUND(COALESCE(r.resign_count, 0) * 100.0 / NULLIF(h.avg_headcount, 0), 2) AS turnover_percentage
FROM 
  years y
LEFT JOIN resigned r ON y.yr = r.resign_year
LEFT JOIN headcount h ON y.yr = h.yr
ORDER BY y.yr;

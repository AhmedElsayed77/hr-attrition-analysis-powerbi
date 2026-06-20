-- ============================================================
-- Task (7):
-- -- Attrition and average monthly income by Department and Job Role Query
-- ============================================================


-- ============================================================
-- SECTION 1: CREATE TABLES (Star Schema structure)
-- ============================================================
CREATE DATABASE HR_Attrition;
USE HR_Attrition;

CREATE TABLE Dim_Department (
    DepartmentID INT PRIMARY KEY,
    Department VARCHAR(50)
);

CREATE TABLE Dim_JobRole (
    JobRoleID INT PRIMARY KEY,
    JobRole VARCHAR(50)
);

CREATE TABLE Fact_Employee (
    EmployeeNumber INT PRIMARY KEY,
    Attrition VARCHAR(5),
    DepartmentID INT,
    JobRoleID INT,
    MonthlyIncome DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Dim_Department(DepartmentID),
    FOREIGN KEY (JobRoleID) REFERENCES Dim_JobRole(JobRoleID)
);

-- ============================================================
-- SECTION 2: INSERT SAMPLE DATA
-- ============================================================
INSERT INTO Dim_Department VALUES
(1, 'Human Resources'),
(2, 'Research & Development'),
(3, 'Sales');

INSERT INTO Dim_JobRole VALUES
(1, 'Healthcare Representative'),
(2, 'Human Resources'),
(3, 'Laboratory Technician'),
(4, 'Manager'),
(5, 'Manufacturing Director'),
(6, 'Research Director'),
(7, 'Research Scientist'),
(8, 'Sales Executive'),
(9, 'Sales Representative');

INSERT INTO Fact_Employee VALUES
(1, 'Yes', 3, 9, 2500.00),
(2, 'No', 3, 9, 3200.00),
(3, 'Yes', 2, 3, 3100.00),
(4, 'No', 2, 7, 3300.00),
(5, 'Yes', 3, 8, 6800.00),
(6, 'No', 1, 2, 4200.00);


-- ============================================================
-- SECTION 3: Main Query (the actual task requirement)
-- Join the fact table with Department and Job Role dimensions.
-- Calculate attrition count and average Monthly Income for
-- each Department and JobRole. Sort by attrition count DESC.
-- ============================================================

SELECT
    d.Department AS DepartmentName,
    jr.JobRole AS JobRoleName,
    COUNT(CASE WHEN f.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(AVG(f.MonthlyIncome), 2) AS AvgMonthlyIncome
FROM Fact_Employee f
JOIN Dim_Department d ON f.DepartmentID = d.DepartmentID
JOIN Dim_JobRole jr ON f.JobRoleID = jr.JobRoleID
GROUP BY d.Department, jr.JobRole
ORDER BY AttritionCount DESC;
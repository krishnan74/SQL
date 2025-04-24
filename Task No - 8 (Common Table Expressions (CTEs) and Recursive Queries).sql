-- Create an Employees table with manager hierarchy
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    ManagerID INTEGER 
);

-- Insert sample hierarchical employee data
INSERT INTO Employees (EmployeeID, FirstName, LastName, ManagerID)
VALUES
(1, 'Nick', 'Fury', NULL),            -- Top-level manager
(2, 'Tony', 'Stark', 1),              -- Reports to Nick
(3, 'Steve', 'Rogers', 1),            -- Reports to Nick
(4, 'Peter', 'Parker', 2),            -- Reports to Tony
(5, 'Natasha', 'Romanoff', 3),        -- Reports to Steve
(6, 'Wanda', 'Maximoff', 3),          -- Reports to Steve
(7, 'Sam', 'Wilson', 3);              -- Reports to Steve

-- 1. Non-recursive CTE: List all employees who report to 'Steve Rogers'
WITH SteveTeam AS (
    SELECT EmployeeID, FirstName, LastName
    FROM Employees
    WHERE ManagerID = (
        SELECT EmployeeID FROM Employees
        WHERE FirstName = 'Steve' AND LastName = 'Rogers'
    )
)
SELECT * FROM SteveTeam;

-- 2. Recursive CTE: Display the entire org chart starting from 'Nick Fury'
WITH RECURSIVE OrgChart AS (
    -- Anchor member: start with the top-level manager
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive member: get employees who report to previous level
    SELECT 
        E.EmployeeID,
        E.FirstName,
        E.LastName,
        E.ManagerID,
        OC.Level + 1
    FROM Employees E
    JOIN OrgChart OC ON E.ManagerID = OC.EmployeeID
)
SELECT 
    EmployeeID,
    FirstName || ' ' || LastName AS EmployeeName,
    ManagerID,
    Level
FROM OrgChart
ORDER BY Level, EmployeeName;

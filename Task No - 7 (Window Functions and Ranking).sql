DROP TABLE Employees;

-- Create the Employees table with Department and Salary
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    Department TEXT,
    Salary REAL
);

-- Insert sample employee data
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'Tony', 'Stark', 'Engineering', 150000.00),
(2, 'Bruce', 'Wayne', 'Engineering', 150000.00),
(3, 'Rachel', 'Green', 'Sales', 90000.00),
(4, 'Monica', 'Geller', 'Sales', 90000.00),
(5, 'Walter', 'White', 'Research', 110000.00),
(6, 'Jon', 'Snow', 'Research', 92000.00),
(7, 'Joey', 'Tribbiani', 'Sales', 85000.00);

-- 1. Use ROW_NUMBER() to assign a unique row number per department based on salary
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum
FROM Employees;

-- 2. Use RANK() to assign rank based on salary, allowing for gaps
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    RANK() OVER ( ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 3. Use DENSE_RANK() to assign ranks without gaps
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Employees;

-- 4. Use LAG() and LEAD() to compare salaries with previous and next employees in each department
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,
    LAG(Salary, 1) OVER (PARTITION BY Department ORDER BY Salary DESC) AS PrevSalary,
    LEAD(Salary, 1) OVER (PARTITION BY Department ORDER BY Salary DESC) AS NextSalary
FROM Employees;

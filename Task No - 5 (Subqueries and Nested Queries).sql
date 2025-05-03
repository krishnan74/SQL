-- Create the Employees table with Department included
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Insert sample data into Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'Tony', 'Stark', 'Engineering', 150000.00),
(2, 'Bruce', 'Wayne', 'Engineering', 140000.00),
(3, 'Rachel', 'Green', 'Sales', 90000.00),
(4, 'Monica', 'Geller', 'Sales', 88000.00),
(5, 'Walter', 'White', 'Research', 110000.00),
(6, 'Jon', 'Snow', 'Research', 92000.00);

-- Subquery in WHERE clause: Select employees earning more than their department's average salary
SELECT * FROM Employees E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE Department = E.Department
);

-- Subquery in SELECT list: Show each employee and the average salary of their department
SELECT 
    FirstName,
    LastName,
    Department,
    Salary,
    (SELECT AVG(Salary) 
     FROM Employees 
     WHERE Department = E.Department) AS DepartmentAvgSalary
FROM Employees E;

-- Non-correlated subquery: Get employees with salary greater than the overall average salary
SELECT * FROM Employees
WHERE Salary > (
    SELECT AVG(Salary) FROM Employees
);

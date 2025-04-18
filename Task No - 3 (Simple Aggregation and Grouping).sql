-- Create a table named Employees with appropriate columns
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    JobTitle VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

-- Insert 6 records into the Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, JobTitle, Department, HireDate, Salary)
VALUES 
(1, 'Tony', 'Stark', 'Software Engineer', 'Engineering', '2015-05-02', 150000.00),
(2, 'Rachel', 'Green', 'Project Manager', 'Sales', '2018-09-22', 90000.00),
(3, 'Jon', 'Snow', 'Data Analyst', 'Analytics', '2020-11-01', 75000.00),
(4, 'Walter', 'White', 'Chemistry Consultant', 'Research', '2013-03-30', 110000.00),
(5, 'Leslie', 'Knope', 'HR Specialist', 'Human Resources', '2019-06-15', 82000.00),
(6, 'Bruce', 'Wayne', 'Software Engineer', 'Engineering', '2016-08-18', 140000.00);

-- Count the number of employees per department
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;

-- Calculate the average salary per department
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department;

-- Sum total salary per department and filter departments with total salary greater than 200000
SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 200000;

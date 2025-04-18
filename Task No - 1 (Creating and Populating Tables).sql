-- Create a table named Employees with approriate columns
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    JobTitle VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

-- Insert 5 records into the Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, JobTitle, HireDate, Salary)
VALUES 
(1, 'Tony', 'Stark', 'Software Engineer', '2015-05-02', 150000.00),
(2, 'Rachel', 'Green', 'Project Manager', '2018-09-22', 90000.00),
(3, 'Jon', 'Snow', 'Data Analyst', '2020-11-01', 75000.00),
(4, 'Walter', 'White', 'Chemistry Consultant', '2013-03-30', 110000.00),
(5, 'Leslie', 'Knope', 'HR Specialist', '2019-06-15', 82000.00);

-- Select all records from the Employees table
SELECT * FROM Employees;

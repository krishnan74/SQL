-- Create a table named Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- Create a table named Orders with a foreign key reference to Customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email)
VALUES
(1, 'Monica', 'Geller', 'monica@example.com'),
(2, 'Chandler', 'Bing', 'chandler@example.com'),
(3, 'Ross', 'Geller', 'ross@example.com'),
(4, 'Joey', 'Tribbiani', 'joey@example.com');

-- Insert sample data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-01-15', 250.00),
(102, 2, '2023-02-10', 175.50),
(103, 1, '2023-03-05', 320.00),
(104, 3, '2023-03-20', 89.99);

-- INNER JOIN: Get customer names along with their order details
SELECT 
    Customers.FirstName,
    Customers.LastName,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- LEFT JOIN: Get all customers and their orders if there is any
SELECT 
    Customers.FirstName,
    Customers.LastName,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

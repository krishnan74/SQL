-- Create an Orders table with date fields
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    OrderDate DATE,
    TotalAmount REAL
);

-- Insert sample data into Orders table
INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount)
VALUES
(1, 'Chandler Bing', '2024-03-10', 250.00),
(2, 'Monica Geller', '2024-03-25', 180.00),
(3, 'Ross Geller', '2024-04-01', 320.00),
(4, 'Rachel Green', '2024-04-15', 275.00),
(5, 'Joey Tribbiani', '2024-04-18', 100.00);

-- 1. Calculate the number of days since each order was placed
SELECT 
    OrderID,
    CustomerName,
    OrderDate,
    JULIANDAY('now') - JULIANDAY(OrderDate) AS DaysSinceOrder
FROM Orders;

-- 2. Add 7 days to each order date
SELECT 
    OrderID,
    CustomerName,
    OrderDate,
    DATE(OrderDate, '+7 days') AS ExpectedDeliveryDate
FROM Orders;

-- 3. Filter orders placed in the last 30 days
SELECT * FROM Orders
WHERE OrderDate >= DATE('now', '-30 days');

-- 4. Format the OrderDate as dd-mm-yyyy using strftime
SELECT 
    OrderID,
    CustomerName,
    STRFTIME('%d-%m-%Y', OrderDate) AS FormattedDate
FROM Orders;

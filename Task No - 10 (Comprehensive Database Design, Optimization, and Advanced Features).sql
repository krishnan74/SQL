-- 1. Schema Design

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    IsActive BIT DEFAULT 1
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending'
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PriceAtOrder DECIMAL(10,2) NOT NULL CHECK (PriceAtOrder >= 0),
    UNIQUE (OrderID, ProductID)
);

-- OrderLogs Table
CREATE TABLE OrderLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    OldStatus VARCHAR(20),
    NewStatus VARCHAR(20),
    ChangedAt DATETIME DEFAULT GETDATE()
);

-- 2. Indexing
CREATE INDEX idx_orders_customerid ON Orders(CustomerID);
CREATE INDEX idx_orderdetails_orderid ON OrderDetails(OrderID);
CREATE INDEX idx_orderdetails_productid ON OrderDetails(ProductID);
CREATE INDEX idx_products_name ON Products(Name);

-- Insert Customer
INSERT INTO Customers (Name, Email, Address)
VALUES ('Das', 'das@example.com', '123 Main St');

-- Insert a product (ensure this runs BEFORE the transaction)
INSERT INTO Products (Name, Description, Price, Stock)
VALUES ('Widget', 'A useful widget', 19.99, 100);

-- 3. Triggers

-- Trigger: update stock on OrderDetails insert
CREATE TRIGGER trg_UpdateStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.Stock = p.Stock - i.Quantity
    FROM Products p
    JOIN inserted i ON p.ProductID = i.ProductID;
END;

-- Trigger: log status change in Orders
CREATE TRIGGER trg_LogOrderStatusChange
ON Orders
AFTER UPDATE
AS
BEGIN
    INSERT INTO OrderLogs (OrderID, OldStatus, NewStatus)
    SELECT i.OrderID, d.Status, i.Status
    FROM inserted i
    JOIN deleted d ON i.OrderID = d.OrderID
    WHERE i.Status <> d.Status;
END;

-- 4. Sample Transaction
BEGIN TRANSACTION;

-- Insert Order
INSERT INTO Orders (CustomerID) VALUES (1);
DECLARE @OrderID INT = SCOPE_IDENTITY();

-- Insert Order Detail
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, PriceAtOrder)
VALUES (@OrderID, 1, 2, 19.99);

-- Commit
COMMIT;

-- 5. View: Customer Order Summary
CREATE VIEW CustomerOrderSummary AS
SELECT
    c.CustomerID,
    c.Name,
    o.OrderID,
    o.OrderDate,
    SUM(od.Quantity * od.PriceAtOrder) AS TotalOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name, o.OrderID, o.OrderDate;

-- 6. Testing

-- Add a customer
INSERT INTO Customers (Name, Email, Address)
VALUES ('Leo', 'leo@example.com', '123 Main St');

-- Add a product
INSERT INTO Products (Name, Description, Price, Stock)
VALUES ('Widget', 'A useful widget', 19.99, 100);

-- View stock
SELECT Stock FROM Products WHERE ProductID = 1;

-- Update order status
UPDATE Orders SET Status = 'Shipped' WHERE OrderID = 1;

-- View order logs
SELECT * FROM OrderLogs;

-- View order summary
SELECT * FROM CustomerOrderSummary;
-- Create the Orders table for demonstration
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

-- Insert some test data
INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount)
VALUES
(1, 'Thor', '2024-03-01', 200.00),
(2, 'Loki', '2024-03-15', 450.00),
(3, 'Hulk', '2024-04-05', 120.00),
(4, 'Banner', '2024-04-20', 300.00);

-- Create stored procedure to get total sales in a given date range
CREATE PROCEDURE GetTotalSalesByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        SUM(TotalAmount) AS TotalSales,
        COUNT(*) AS TotalOrders
    FROM Orders
    WHERE OrderDate BETWEEN @StartDate AND @EndDate;
END;

-- Execute the stored procedure
EXEC GetTotalSalesByDateRange @StartDate = '2024-03-01', @EndDate = '2024-04-01';


-- Create a scalar function to calculate discount
CREATE FUNCTION dbo.CalculateDiscount (@TotalAmount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Discount DECIMAL(10,2);

    IF @TotalAmount >= 400
        SET @Discount = @TotalAmount * 0.10; -- 10%
    ELSE IF @TotalAmount >= 200
        SET @Discount = @TotalAmount * 0.05; -- 5%
    ELSE
        SET @Discount = 0;

    RETURN @Discount;
END;

-- Test the function
SELECT 
    OrderID,
    CustomerName,
    TotalAmount,
    dbo.CalculateDiscount(TotalAmount) AS Discount
FROM Orders;

-- Create retail_sales table
CREATE TABLE retail_sales (
    TransactionID INT,
    OrderDate DATE,
    CustomerID NVARCHAR(50),
    Gender NVARCHAR(10),
    Age INT,
    ProductCategory NVARCHAR(50),
    Quantity INT,
    PricePerUnit DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2)
);
BULK INSERT retail_sales
FROM 'D:\Portfolio Projects\Retail Sales Analysis\retail_sales_dataset.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


-- Check first 10 rows
SELECT TOP 10 * FROM retail_sales;

-- Summary statistics
SELECT
    COUNT(*) AS total_rows,
    AVG(Quantity) AS avg_quantity,
    AVG(PricePerUnit) AS avg_price_per_unit,
    AVG(TotalAmount) AS avg_total_amount,
    AVG(Age) AS avg_age
FROM retail_sales;



--Sales Trends Over Time
SELECT
    FORMAT(OrderDate, 'yyyy-MM') AS month,
    SUM(TotalAmount) AS total_sales
FROM retail_sales
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY month;

--Top-Selling Product Categories
SELECT
    ProductCategory,
    SUM(Quantity) AS total_quantity,
    SUM(TotalAmount) AS total_sales
FROM retail_sales
GROUP BY ProductCategory
ORDER BY total_sales DESC;

--Sales by Gender
SELECT
    Gender,
    SUM(TotalAmount) AS total_sales
FROM retail_sales
GROUP BY Gender;


--Sales by Age Group
SELECT
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_group,
    SUM(TotalAmount) AS total_sales
FROM retail_sales
GROUP BY CASE
    WHEN Age < 20 THEN 'Under 20'
    WHEN Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50+'
END;


-- Calculate total orders per customer
WITH CustomerOrderCount AS (
    SELECT
        CustomerID,
        COUNT(TransactionID) AS TotalOrders
    FROM retail_sales
    GROUP BY CustomerID
)
-- Calculate the average orders per customer
SELECT
    AVG(TotalOrders) AS AvgOrdersPerCustomer
FROM CustomerOrderCount;

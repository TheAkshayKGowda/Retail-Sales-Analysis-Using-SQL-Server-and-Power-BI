# Retail Sales Analysis Using SQL Server and Power BI

## Project Overview
This project focuses on analyzing retail sales data to gain insights into customer purchasing behaviors, product performance, and sales trends. The analysis is performed using SQL Server for data storage and querying, and Power BI for data visualization and reporting.

### Dataset
The dataset consists of retail sales transactions with the following fields:

TransactionID: Unique identifier for each transaction.
OrderDate: Date of the transaction.
CustomerID: Unique identifier for each customer.
Gender: Gender of the customer.
Age: Age of the customer.
ProductCategory: Category of the purchased product.
Quantity: Quantity of the purchased product.
PricePerUnit: Price per unit of the product.
TotalAmount: Total amount of the transaction.

### Project Steps

1. Data Preparation
SQL Server Table Creation: Create a table retail_sales in SQL Server to store the data.
Data Insertion: Insert the provided data into the retail_sales table.

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
2. Data Analysis
Exploration

-- Check first 10 rows
SELECT TOP 10 * FROM retail_sales;
Summary Statistics
sql
Copy code
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


3. Data Visualization with Power BI

### Key Insights

1.Monthly Sales Trends: Monthly sales trends helped identify peak sales periods.
2.Top-Selling Product Category: Electronics emerged as the top-selling product category.
3.Sales by Gender: Female customers accounted for a larger proportion of sales.
4.Sales by Age Group: The 50+ age group had the highest total sales.

##Conclusion
This project demonstrates how SQL Server and Power BI can be used together to analyze and visualize retail sales data, providing valuable insights for business decision-making.

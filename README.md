# RETAIL_PROJECT_SQLP1

## Retail Sales Analysis SQL Project
### Project Overview
- **Project Title**: Retail Sales Analysis
- **Database**: SQL_PROJECT

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
### 1. Database Setup
Database Creation: The project starts by creating a database named `retail_project`.
Table Creation: A table named retail_data is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

### 2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_data_v1;
SELECT COUNT(DISTINCT customer_id) FROM retail_data_v1;
SELECT DISTINCT category FROM retail_data_v1;

SELECT * FROM retail_data_v1
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- REPALCEING NULL VALUES FOR AGE COLUMN
UPDATE REAIL_DATA_V1
SET AGE = (SELECT AVG(AGE) FROM REAIL_DATA_V1)
WHERE AGE IS NULL;

-- DROPING THE COULUMN WHERE SALES INFO IN MISSING
DELETE FROM REAIL_DATA_V1 WHERE QUANTIY IS NULL;

SELECT * FROM REAIL_DATA_V1
```


### 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:
- Q.1 **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
 SELECT * FROM REAIL_DATA_V1 
WHERE SALE_DATE = '2022-11-05';
```

- Q.2 **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**

```sql 
SELECT * FROM REAIL_DATA_V1
 WHERE CATEGORY = 'CLOTHING' AND QUANTIY >= 4 AND MONTH(SALE_DATE)=11 AND YEAR(SALE_DATE)=2022;
 ```

- Q.3 **Write a SQL query to calculate the total sales (total_sale) for each category.**

```sql
 SELECT CATEGORY,FORMAT(SUM(TOTAL_SALE),'C2') AS TOTAL_SALES
 FROM REAIL_DATA_V1 GROUP BY CATEGORY;
```


- Q.4 **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**

```sql
 SELECT AVG(AGE) AS AVG_AGE FROM REAIL_DATA_V1
 WHERE CATEGORY = 'BEAUTY';
 ```

- Q.5 **Write a SQL query to find all transactions where the total_sale is greater than 1000.**

```sql
SELECT * FROM REAIL_DATA_V1
 WHERE TOTAL_SALE > 1000;
 ```

- Q.6 **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**

```sql
SELECT CATEGORY, GENDER, COUNT(CUSTOMER_ID)
FROM REAIL_DATA_V1
GROUP BY CATEGORY, GENDER
ORDER BY 1,2;
```

- Q.7 **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**

```sql
-- AVERAGE SALES FOR EACH MONTH
SELECT YEAR(SALE_DATE)AS YEAR,
 MONTH(SALE_DATE)AS MONTH,
FORMAT(AVG(TOTAL_SALE),'C2') AS AVG_SALE
 FROM REAIL_DATA_V1
GROUP BY YEAR(SALE_DATE), MONTH(SALE_DATE)
ORDER BY 1,2;

-- BEST SELLING MONTH IN EACH YEAR

WITH CTE_1 AS
 (SELECT YEAR(SALE_DATE)AS YEAR,
 MONTH(SALE_DATE)AS MONTH,
AVG(TOTAL_SALE) AS AVG_SALE 
FROM REAIL_DATA_V1
 GROUP BY YEAR(SALE_DATE), MONTH(SALE_DATE) 
),
CTE_2 AS(
SELECT YEAR,
 MAX(AVG_SALE) AS MAX_SALES
 FROM CTC GROUP BY YEAR)

SELECT A.* FROM CTC _1 AS A
 LEFT JOIN
CTE_2 as B
ON A.AVG_SALE = CTE.MAX_SALES AND A.YEAR=CTE.YEAR
 WHERE MAX_SALES IS NOT NULL;
 ```
 
- Q.8 **Write a SQL query to find the top 5 customers based on the highest total sales**

```sql
SELECT TOP 5  * FROM REAIL_DATA_V1
ORDER BY TOTAL_SALE DESC;
```

- Q.9 **Write a SQL query to find the number of unique customers who purchased items from each category.**

```sql
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS #_N_SUBS
 FROM REAIL_DATA_V1
GROUP BY CATEGORY;
 ```

- Q.10 **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**

```sql
WITH CTE AS
 (SELECT * ,
         CASE WHEN DATEPART(HOUR,SALE_TIME) <12 THEN 'MORNING'
WHEN DATEPART(HOUR,SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTER_NOON'
 ELSE 'EVENING'
END AS WORIKING_SHIFT
FROM REAIL_DATA_V1)

SELECT WORIKING_SHIFT,
      COUNT(TRANSACTIONS_ID) AS #_PURCHESED
 FROM CTE GROUP BY WORIKING_SHIFT;
 ```

### Findings
- Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
- Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

### Reports
- Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
- Trend Analysis: Insights into sales trends across different months and shifts.
- Customer Insights: Reports on top customers and unique customer counts per category.

### Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

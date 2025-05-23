-- SQL RETAIL SALES ANALYSIS -P1
CREATE DATABASE RETAIL_PROJECT;

USE RETAIL_PROJECT;

-- IMPORT THE CSV
SELECT * FROM RETAIL_DATA;

SELECT * INTO REAIL_DATA_V1 FROM RETAIL_DATA;

-- DATA CLEANING
--======================================

--CHECK FOR NULL VALUES IN COLUMNS
SELECT * FROM REAIL_DATA_V1
WHERE TRANSACTIONS_ID IS NULL
		OR 
		SALE_DATE IS NULL
		OR 
		SALE_TIME IS NULL
		OR 
		CUSTOMER_ID IS NULL
		OR
		GENDER IS NULL
		OR 
		AGE IS NULL
		OR
		CATEGORY IS NULL
		OR 
		QUANTIY IS NULL
		OR 
		PRICE_PER_UNIT IS NULL
		OR 
		COGS IS NULL
		OR 
		TOTAL_SALE IS NULL;

SELECT AVG(AGE) AS MOD_AGE FROM REAIL_DATA_V1;


-- REPALCEING NULL VALUES FOR AGE COLUMN
UPDATE REAIL_DATA_V1
SET AGE = (SELECT AVG(AGE) FROM REAIL_DATA_V1)
WHERE AGE IS NULL;


-- DROPING THE COULUMN WHERE SALES INFO IN MISSING
DELETE FROM REAIL_DATA_V1 WHERE QUANTIY IS NULL;

SELECT * FROM REAIL_DATA_V1

--DATA EXPLORATION
--=========================

--NUMBER OF CUSTOMER WE HAVE
SELECT COUNT(DISTINCT CUSTOMER_ID) AS SUBS FROM REAIL_DATA_V1;

--HOW MANY CATEGORY WE HAVE
SELECT DISTINCT CATEGORY FROM REAIL_DATA_V1;

-- DATA ANALYSIS &  BUSINESS KEY PROBLEMS AND ANSWER
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM REAIL_DATA_V1 WHERE SALE_DATE = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM REAIL_DATA_V1 WHERE CATEGORY = 'CLOTHING' AND QUANTIY >= 4 AND MONTH(SALE_DATE)=11 AND YEAR(SALE_DATE)=2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT CATEGORY,FORMAT(SUM(TOTAL_SALE),'C2') AS TOTAL_SALES FROM REAIL_DATA_V1 GROUP BY CATEGORY;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(AGE) AS AVG_AGE FROM REAIL_DATA_V1 WHERE CATEGORY = 'BEAUTY';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM REAIL_DATA_V1 WHERE TOTAL_SALE > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT CATEGORY, GENDER, COUNT(CUSTOMER_ID) FROM REAIL_DATA_V1 GROUP BY CATEGORY, GENDER ORDER BY 1,2;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR(SALE_DATE)AS YEAR, MONTH(SALE_DATE)AS MONTH, FORMAT(AVG(TOTAL_SALE),'C2') AS AVG_SALE FROM REAIL_DATA_V1 GROUP BY YEAR(SALE_DATE), MONTH(SALE_DATE) ORDER BY 1,2;
--BEST SELLING MONTH IN EACH YEAR 
WITH CTC AS (SELECT YEAR(SALE_DATE)AS YEAR, MONTH(SALE_DATE)AS MONTH, AVG(TOTAL_SALE) AS AVG_SALE 
FROM REAIL_DATA_V1 GROUP BY YEAR(SALE_DATE), MONTH(SALE_DATE) 
),
CTE AS(
SELECT YEAR, MAX(AVG_SALE) AS MAX_SALES FROM CTC GROUP BY YEAR)

SELECT A.* FROM CTC AS A  LEFT JOIN CTE ON A.AVG_SALE = CTE.MAX_SALES AND A.YEAR=CTE.YEAR WHERE MAX_SALES IS NOT NULL;
 
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT TOP 5  * FROM REAIL_DATA_V1 ORDER BY TOTAL_SALE DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS #_N_SUBS FROM REAIL_DATA_V1 GROUP BY CATEGORY;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH CTE AS (SELECT * , CASE WHEN DATEPART(HOUR,SALE_TIME) <12 THEN 'MORNING'
				WHEN DATEPART(HOUR,SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTER_NOON'
				ELSE 'EVENING'

			END AS WORIKING_SHIFT
FROM REAIL_DATA_V1)

SELECT WORIKING_SHIFT, COUNT(TRANSACTIONS_ID) AS #_PURCHESED FROM CTE GROUP BY WORIKING_SHIFT;




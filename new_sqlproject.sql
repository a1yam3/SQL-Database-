CREATE DATABASE new_sqlproject;

-- create table and define varibles
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
		(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(15),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
				
		);

		
		
SELECT * FROM retail_sales
LIMIT 10


-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales



SELECT DISTINCT category FROM retail_sales

-- QUERIES

-- Find total sales for each Year.

SELECT 
	EXTRACT(YEAR FROM sale_date) AS year,
	SUM(total_sale) AS total_sales
	FROM retail_sales
	GROUP BY year
	ORDER BY year;

--Total sales for each Quarter.	

SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY year
ORDER BY year;

-- Find Transaction IDs with Total Sales more than 1,000.
SELECT 
    transactions_id,
    total_sale
FROM retail_sales
WHERE total_sale > 10000;

-- Find the Average sale of each Month and the Best Selling Month in each Year.
SELECT 
	year,
	month,
	avg_sale
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	AVG(total_sale)as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC) as rank
	FROM retail_sales
	GROUP BY 1,2
) as t1
WHERE rank = 1

--Find Total Sale and Total Quantity for each Category.
SELECT 
    category,
    SUM(total_sale) AS total_amt,
    SUM(quantity) AS total_quant
FROM retail_sales
GROUP BY category
ORDER BY total_amount DESC;

--Find Average Age of Customers in each Category.
SELECT
	category,
    AVG(age) AS avg_age
FROM retail_sales
GROUP BY category;

-- Find Total Sales for each Gender under each Category.
SELECT 
	category,
	gender,
	SUM(total_sale) AS total_sale
FROM retail_sale
GROUP BY category, gender
ORDER BY category;

-- Find Top 5 Customer IDs With Highest Sales in December 2022 with Category.
SELECT
	customer_id,
	category,
	total_sale
FROM retail_sales
WHERE sale_date = '2022-12'
ORDER BY total_sale DESC
LIMIT 5;

--Find the Top 5 most repeating Customer IDs in 2022.
SELECT 
	customer_id,
	COUNT(*) AS rep_id
FROM retail_sales
WHERE EXTRACT (YEAR FROM sale_date) = 2022
GROUP BY customer_id
ORDER BY rep_id DESC
LIMIT 5;



-- Find Top 3 Customer IDs based on Total Sales, in each Category.
	SELECT
		 category,
		 customer_id,
	SUM(total_sale) AS total_sales,
	FROM retail_sales
	GROUP BY category, customer_id
	LIMIT 3;
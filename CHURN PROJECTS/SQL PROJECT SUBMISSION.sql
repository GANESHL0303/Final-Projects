-- SQL Retail Sales Analysis - P1

CREATE DATABASE sql_project_p2;
use sql_project_p2;
select * from retail_sales;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10;


    

SELECT 
    COUNT(*) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

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
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND  quantiy > 10
        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    AVG(age) AS ages
FROM
    retail_sales
WHERE
    category = 'Beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales 
WHERE total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
       gender, 
       category, 
	   COUNT(transactions_id) AS total_transactions 
FROM 
	retail_sales
GROUP BY
	gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	year(sale_date) AS year,
    MONTH(sale_date) AS month,
    avg(total_sale) AS average_sale
FROM
    retail_sales
GROUP BY
    YEAR(sale_date), month(sale_date)
order by
	year, month;
    
	
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT
	customer_id,
    sum(total_sale * price_per_unit) AS highest_total_sales
FROM
	retail_sales
GROUP BY customer_id
ORDER BY highest_total_sales DESC
limit 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
      category, COUNT(DISTINCT customer_id) AS unique_customers
FROM
	retail_sales
group by category
order by unique_customers;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
     CASE
          WHEN HOUR(sale_time) <= 12 THEN 'morning'
          WHEN HOUR(sale_time) between 12 AND 17 THEN 'afternoon'
          ELSE 'evening'
		END AS shift,
        COUNT(DISTINCT transactions_id) AS no_of_orders
FROM
    retail_sales
GROUP BY shift;



ALTER TABLE retail_sales
RENAME COLUMN ï»¿transactions_id to transactions_id

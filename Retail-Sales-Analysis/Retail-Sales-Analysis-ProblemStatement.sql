CREATE DATABASE retailsales;

USE retailsales;


SELECT * FROM retail_sales_dataset;

-- How many sales we have?
SELECT COUNT(*) as total_sale 
FROM retail_sales_dataset

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as unique_customers 
FROM retail_sales_dataset


-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales_dataset
WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * 
FROM retail_sales_dataset
WHERE category = 'Clothing' 
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
AND quantiy >= 4;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales_dataset
GROUP BY 1;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age)) AS avg_age
FROM retail_sales_dataset
WHERE category = 'Beauty'



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales_dataset
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales_dataset 
GROUP BY category, gender 
ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as `rank`
    FROM retail_sales_dataset
    GROUP BY year, month
) as t1
WHERE `rank` = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales_dataset
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS count_unique
FROM retail_sales_dataset
GROUP BY category




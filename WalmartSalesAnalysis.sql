CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12,4),
    rating FLOAT
);

SELECT * FROM sales;

--Feature Engineering
--(time_of_days)

ALTER TABLE sales
ADD COLUMN time_of_day varchar(40);

UPDATE sales
SET time_of_day =
	CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
		WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
		ELSE 'Evening'
	END ;

	
--Adding new column(days)

ALTER TABLE sales
ADD COLUMN day_date varchar(20);

UPDATE sales
SET day_date =
	To_char(date,'Dy')

--Adding new column(months)

ALTER TABLE sales
ADD COLUMN month_name varchar(30);

UPDATE sales
SET month_name = TO_CHAR(date, 'Mon')



----------------------------------------Generic Question----------------------------------------------------
1--How many unique cities does the data have?

SELECT DISTINCT city
FROM sales;

2--In which city is each branch?

SELECT DISTINCT city,branch
FROM sales;


------------------------------------------Product-------------------------------------------------------------
1--How many unique product lines does the data have?

SELECT 
COUNT(DISTINCT product_line)
FROM sales;

2--What is the most common payment method?

SELECT payment,
COUNT(payment) AS total_count
FROM sales
GROUP BY payment
ORDER BY COUNT(payment) DESC

3--What is the most selling product line?

SELECT 
product_line,
COUNT(product_line) AS total_count
FROM sales
GROUP BY product_line
ORDER BY  total_count DESC;

4--What is the total revenue by month?

SELECT
month_name AS months, 
SUM(total)
FROM sales
GROUP BY month_name
ORDER BY SUM(total) DESC

5--What month had the largest COGS?


SELECT month_name AS months,
SUM(cogs)
FROM sales
GROUP BY months
ORDER BY SUM(cogs) DESC

6--What product line had the largest revenue?

SELECT product_line, 
SUM(total)
FROM sales
GROUP BY product_line
ORDER BY SUM(total) DESC;

7--What is the city with the largest revenue?


SELECT
city,
SUM(total)
FROM sales
GROUP BY city
ORDER BY sum(total) DESC;

8--What product line had the largest VAT?

SELECT 
product_line,
SUM(tax_pct*cogs)
FROM sales
GROUP BY product_line
ORDER BY SUM(tax_pct*cogs) DESC;

9--Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

ALTER TABLE sales
ADD COLUMN product_category varchar(30);

UPDATE sales
SET product_category =
	CASE 
		WHEN total >= (SELECT avg(total) from sales) THEN 'Good'
		ELSE 'Bad'
	END;

10--Which branch sold more products than average product sold?


SELECT branch,floor(avg(total))
FROM
	(SELECT branch, sum(quantity) as total FROM sales
	 GROUP BY branch) as new
GROUP BY branch


11--What is the most common product line by gender?

SELECT
gender,product_line,
COUNT(product_line) AS total
FROM sales
GROUP BY gender,product_line
ORDER BY total DESC;

12--What is the average rating of each product line?


SELECT product_line, ceil(AVG(rating)) AS rate
FROM sales
GROUP BY product_line;


---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC






---------------------------------------------------Customer Analysis-----------------------------------------------------------

1--How many unique customer types does the data have?

SELECT COUNT(distinct customer_type)
FROM sales


2--How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment)
FROM sales


3--Which is the most common customer type?

SELECT customer_type, count(customer_type)
FROM sales
GROUP BY customer_type
Order BY count(customer_type) DESC
LIMIT 1;

4--Which customer type buys the most?

SELECT customer_type, SUM(total) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC
limit 1;

5--What is the gender of most of the customers?



SELECT gender,COUNT(gender) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC limit 1;


6--What is the gender distribution per branch?

SELECT branch, gender, count(gender)
FROM sales
GROUP BY branch, gender
ORDER BY branch

7--Which time of the day do customers give most ratings?

SELECT time_of_day, count(rating) AS rate
FROM sales
GROUP BY time_of_day
order by rate DESC

8--Which time of the day do customers give most ratings per branch?

SELECT branch,time_of_day, count(rating) AS rate
FROM sales
GROUP BY branch, time_of_day
ORDER BY rate DESC

9--Which day of the week has the best avg ratings?

SELECT day_date, avg(rating) AS rate
FROM sales
GROUP BY day_date
ORDER BY rate DESC

10--Which day of the week has the best average ratings per branch?

SELECT day_date,branch, avg(rating) AS rate
FROM sales
GROUP BY day_date,branch
ORDER BY rate DESC











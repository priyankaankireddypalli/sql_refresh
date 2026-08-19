-- DATE FUNCTIONS

-- 1. GETDATE() or CURRENT_TIMESTAMP

SELECT GETDATE() as now
-- 2. CURDATE() or CURRENT_DATE: not support my SQL server

SELECT CAST(GETDATE() as DATE) as today_date

-- 3. CURTIME(): SQL server does not support SQL server
SELECT CAST(GETDATE() as TIME) as now_time

-- 4. DATEPART (EXTRACT NOT SUPPORTED IN SQL SEVER)
SELECT DATEPART(YEAR, '2026-01-01')
SELECT DATEPART(MONTH, '2026-01-01')
SELECT DATEPART(DAY, '2026-01-01')
SELECT DATEPART(HOUR, '2026-01-01')
SELECT DATEPART(MINUTE, '2026-01-01')
SELECT DATEPART(SECOND, '2026-01-01')


-- 5. YEAR()
-- 6. MONTH()
-- 7. DAY()
-- 8. HOUR()
-- 9. MINUTE()
-- 10. SECOND()
-- 11. DATEDIFF(datepart, date1, date2)
SELECT DATEDIFF(DAY,GETDATE(),'2021-01-12') as diff

-- 12. DATEADD(datepart,value, date)
SELECT DATEADD(DAY, 14, '2026-07-27') AS addition;
SELECT DATEADD(DAY, -10, '2026-07-27');
-- 13. DATE_SUB(): does not support it: use dateadd only
SELECT DATEADD(DAY, -5, '2026-07-27') AS new_date;
-- 14. TIMESTAMPDIFF(): does not support in SQL server
SELECT DATEDIFF(
    DAY,
    '2026-07-01',
    '2026-07-27'
);

SELECT DATEDIFF(
    HOUR,
    '2026-07-27 10:00:00',
    '2026-07-27 15:30:00'
);
-- 15. DATE_FORMAT() : not supported here in sql server 
SELECT DATE_FORMAT('2026-10-12','%d-%m-%Y')
-- FORMAT(date,format)
SELECT FORMAT(GETDATE(), 'MMMM yyyy');

-- 16. STR_TO_DATE(): not supported in sql server
SELECT STR_TO_DATE('27-07-2026', '%d-%m-%Y') AS new_date;

SELECT CAST('2026-07-27' AS DATE);


-- 17.LAST_DAY(): Not used in SQL server
SELECT LAST_DAY('2026-07-27') AS last_day;
SELECT EOMONTH('2026-07-27') AS last_day;


-- 18. QUARTER(): not used in sql server
SELECT QUARTER('2026-07-27') AS quarter_no;

SELECT DATEPART(QUARTER, '2026-07-27') AS quarter_no;
-- 19. WEEK(): week no in the year
SELECT DATEPART(WEEK, '2026-05-01') AS week_no;


-- 20. DAYNAME()
SELECT DATENAME(DAY, '2026-07-27') AS week_day;
-- 21. MONTHNAME()
SELECT DATENAME(MONTH, '2026-07-27') AS month_name;
-- 22. DAYOFMONTH()
SELECT DAY('2026-07-27')
-- 23. DAYOFWEEK()
SELECT DATEPART(WEEKDAY, '2026-07-27')

-- 24. DAYOFYEAR()
SELECT DATEPART(DAYOFYEAR, '2026-07-27')



-- IT WILL identify as date



-- 3 consecuative login days
/*| user_id | login_date |
| ------: | ---------- |
|       1 | 2024-01-01 |
|       1 | 2024-01-02 |
|       1 | 2024-01-03 |
|       2 | 2024-01-01 |
|       2 | 2024-01-03 |
|       2 | 2024-01-04 |
|       3 | 2024-01-05 |
|       3 | 2024-01-06 |
|       3 | 2024-01-07 |
*/

-- Create table
CREATE TABLE logins (
    user_id INT,
    login_date DATE
);

-- Insert sample data
INSERT INTO logins (user_id, login_date) VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(2, '2024-01-01'),
(2, '2024-01-03'),
(2, '2024-01-04'),
(3, '2024-01-05'),
(3, '2024-01-06'),
(3, '2024-01-07');

WITH cte AS
(
    SELECT
        user_id,
        login_date,
        ROW_NUMBER() OVER
        (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS rn
    FROM login_details
),
grp AS
(
    SELECT
        user_id,
        login_date,
        DATEADD(DAY, -rn, login_date) AS grp
    FROM cte
)
SELECT user_id
FROM grp
GROUP BY
    user_id,
    grp
HAVING COUNT(*) >= 3;


CREATE TABLE orders_dte(
order_id INT,
customer_id INT,
order_date DATE,
delivery_date DATE,
order_amount DECIMAL(10,2),
city VARCHAR(50)
)

INSERT INTO orders_dte
(order_id, customer_id, order_date, delivery_date, order_amount, city)
VALUES
(1, 101, '2024-01-01', '2024-01-03', 500.00, 'Delhi'),
(2, 102, '2024-01-02', '2024-01-05', 1200.00, 'Mumbai'),
(3, 103, '2024-01-04', '2024-01-04', 800.00, 'Chennai'),
(4, 104, '2024-01-05', '2024-01-08', 650.00, 'Bengaluru'),
(5, 105, '2024-01-06', '2024-01-10', 1500.00, 'Kolkata'),
(6, 106, '2024-01-08', '2024-01-12', 900.00, 'Hyderabad'),
(7, 107, '2024-01-10', '2024-01-11', 700.00, 'Pune'),
(8, 108, '2024-01-12', '2024-01-15', 400.00, 'Chennai'),
(9, 109, '2024-01-15', '2024-01-20', 2000.00, 'Bengaluru'),
(10, 110, '2024-01-18', '2024-01-18', 300.00, 'Ahmedabad'),

-- NULL delivery date (pending)
(11, 101, '2024-01-20', NULL, 1000.00, 'Delhi'),

-- NULL amount
(12, 102, '2024-01-21', '2024-01-24', NULL, 'Mumbai'),

-- NULL city
(13, 103, '2024-01-22', '2024-01-26', 600.00, NULL),

-- Duplicate order details
(14, 104, '2024-01-23', '2024-01-27', 750.00, 'Bengaluru'),
(15, 104, '2024-01-23', '2024-01-27', 750.00, 'Bengaluru'),

-- Multiple orders by same customer
(16, 105, '2024-02-01', '2024-02-03', 1100.00, 'Kolkata'),
(17, 105, '2024-02-05', '2024-02-10', 2500.00, 'Kolkata'),

-- Long delivery time
(18, 106, '2024-02-10', '2024-02-25', 3200.00, 'Hyderabad'),

-- Same-day delivery
(19, 107, '2024-02-12', '2024-02-12', 550.00, 'Pune'),

-- Pending delivery
(20, 108, '2024-02-15', NULL, 1800.00, 'Chennai');

SELECT * FROM orders_dte

-- EASY

-- Q1. Get all orders placed in January 2024

SELECT *
FROM orders_dte
WHERE DATEPART(MONTH, order_date) = 1 and DATEPART(YEAR, order_date) = 2024

SELECT *
FROM orders_dte
WHERE extract(MONTH FROM order_date) = 1 AND extract(YEAR FROM order_date) = 2024;

-- Q2. Find orders placed in the current month

SELECT *
FROM orders_dte
WHERE DATEPART(MONTH, order_date) = DATEPART(MONTH,GETDATE())

-- Q3. Extract year, month, and day from order_date
SELECT DATEPART(YEAR, order_date) as yr, DATEPART(MONTH, order_date) as mnt, DATEPART(DAY, order_date) as dte
FROM orders_dte


SELECT EXTRACT(YEAR FROM order_date) as year, DATEPART('MONTH',order_date) as month, DAY(order_date) as day
FROM orders_dte

-- Q4. Find orders placed on a Sunday
SELECT *
FROM orders_dte
WHERE DATENAME(WEEKDAY, order_date) = 'Sunday'

SELECT *
FROM orders_dte
WHERE DATEPART(WEEKDAY, order_date) = 1

SELECT *
FROM orders_dte
WHERE DAYNAME(order_date) = 'Sun';

-- Q5. Get orders where delivery happened in February

SELECT *, DATENAME(MONTH, order_date)
FROM orders_dte
WHERE DATENAME(MONTH, order_date) = 'February';

SELECT *
FROM orders_dte
WHERE MONTHNAME(delivery_date) = 'Feb'

-- MEDIUM LEVEL
-- Q6. Find orders placed in the last 30 days from today

SELECT *,  DATEADD(DAY, -30, GETDATE())
FROM orders_dte
WHERE order_date >= DATEADD(DAY, -30, GETDATE())

-- Q7. Calculate delivery time (in days) for each order
SELECT *, DATEDIFF(DAY, order_date, delivery_date) as delivery_time
FROM orders_dte

-- Q8. Find orders where delivery took more than 4 days
SELECT *, DATEDIFF(DAY, order_date, delivery_date) as delivery_time
FROM orders_dte
WHERE DATEDIFF(DAY, order_date, delivery_date) > 4


SELECT * FROM (SELECT *, DATEDIFF(DAY, order_date, delivery_date) as delivery_time
FROM orders_dte) t
WHERE delivery_time > 4;

-- Q9. Get monthly total sales
SELECT  DATEPART(MONTH, order_date) as monthly, SUM(order_amount) as sales
FROM orders_dte
GROUP BY DATEPART(MONTH, order_date)


SELECT  DATEPART(YEAR, order_date) as yearly,DATEPART(MONTH, order_date) as monthly, SUM(order_amount) as sales
FROM orders_dte
GROUP BY DATEPART(MONTH, order_date), DATEPART(YEAR, order_date)

SELECT *, SUM(order_amount) OVER(PARTITION BY DATEPART(MONTH, order_date), DATEPART(YEAR, order_date))  as sales
FROM orders_dte

-- Q10. Count number of orders per month
SELECT  DATEPART(MONTH, order_date) as monthly, COUNT(order_id) as cnt
FROM orders_dte
GROUP BY DATEPART(MONTH, order_date)

-- Q11. Find orders placed in the first quarter (Q1)
SELECT *
FROM orders_dte
WHERE DATEPART(QUARTER, order_date) = 1;

SELECT *
FROM orders_dte
WHERE QUARTER(order_date) = 1

-- (Q12). Get orders placed in the last 7 days of each month
SELECT * FROM orders_dte
WHERE order_date BETWEEN EOMONTH(order_date) AND DATEADD(DAY, -6, EOMONTH(order_date))


SELECT *
FROM orders_dte
WHERE order_date >= DATEADD(DAY, -6, EOMONTH(order_date))

-- Q13. Find orders where order_date = delivery_date (same day delivery)
SELECT *
FROM orders_dte
WHERE order_date = delivery_date

-- Q14. Find Week-wise order count

SELECT DATEPART(WEEK, order_date) as wkly, count(*) As cnt
FROM orders_dte
GROUP BY DATEPART(WEEK, order_date)

-- (Q15). Get average delivery time(in days) per city
SELECT city, AVG(DATEDIFF(day,order_date,delivery_date)) as avg
FROM orders_dte
GROUP BY city

-- Q16. Get average delivery time(in days) per city, Group them less than 2 - early delivery, between 2-4 in time and greater than 4 > delay
SELECT  city,
	CASE
		WHEN AVG(DATEDIFF(day,order_date,delivery_date)) < 2 THEN 'Early delivery'
		WHEN AVG(DATEDIFF(day,order_date,delivery_date)) > 2 THEN 'delay'
		ELSE 'In time'
	END as category	
FROM orders_dte
GROUP BY city

-- HARD LEVEL

-- Q17. Find customers who placed orders in consecutive months

SELECT * FROM (SELECT *, DATEPART(MONTH,order_date) as mnth, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_amount) as prev_mnth
FROM orders_dte) t
WHERE (mnth - prev_mnth) = 1



WITH cte AS
(
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER
        (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS prev_order_date
    FROM orders_dte
)
SELECT DISTINCT customer_id
FROM cte
WHERE DATEDIFF(MONTH, prev_order_date, order_date) = 1;

-- (Q18). Calculate month-over-month growth in sales (current_month - previous month/ prev month sales) * 100

-- step1 : calculate monthly sales
SELECT *
FROM orders_dte

SELECT *, ((total_sales - prev_mnth)/(prev_mnth))*100 FROM 
(
SELECT mnth, total_sales, LAG(total_sales) OVER (ORDER BY total_sales) as prev_mnth FROM
(
SELECT DATEPART(MONTH,order_date) as mnth,
SUM(order_amount) as total_sales
FROM orders_dte
GROUP BY DATEPART(MONTH,order_date)
) t ) t2







-- Q19. Find first order date and last order date per customers

SELECT customer_id, MIN(order_date) as first_order, MAX(order_date) as latest_order
FROM orders_dte
GROUP BY customer_id

-- (Q20). Identify customers inactive for more than 60 days

SELECT customer_id, MIN(order_date) as first_order, MAX(order_date) as latest_order, DATEDIFF(DAY, MIN(order_date), MAX(order_date)) as days
FROM orders_dte
GROUP BY customer_id
HAVING  DATEDIFF(DAY, MIN(order_date), MAX(order_date)) > 60


SELECT customer_id, MAX(order_date) as latest_order, DATEDIFF(DAY, MAX(order_date), GETDATE()) as days
FROM orders_dte
GROUP BY customer_id
HAVING  DATEDIFF(DAY, MAX(order_date), GETDATE()) > 60

-- best
SELECT customer_id, MAX(order_date) as latest_order
FROM orders_dte
GROUP BY customer_id
HAVING MAX(order_date) < DATEADD(DAY, -60, GETDATE())


-- Q21. Find repeat customers who ordered within 7 days of previous order
SELECT * FROM (SELECT order_id, customer_id, order_date,
	LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as next_date,
	DATEDIFF(DAY, order_date,LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)) as dy
FROM orders_dte) t
WHERE dy <= 7

-- best
SELECT distinct customer_id FROM (SELECT order_id, customer_id, order_date,
	LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as prev_date,
	DATEDIFF(DAY,LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date),order_date) as dy
FROM orders_dte) t
WHERE dy <= 7

SELECT *
FROM orders_dte



/* 
	COMMON TABLE EXPRESSION (CTE) - Temporary table
*/

use master
DROP TABLE orders
CREATE TABLE orders(
	customer_id INT,
	order_date DATE,
	amount INT
);


INSERT INTO orders (customer_id, order_date, amount) VALUES
(101, '2024-01-05', 250),
(102, '2024-01-07', 500),
(103, '2024-01-10', 150),
(101, '2024-02-03', 300),
(104, '2024-02-05', 450),
(102, '2024-02-12', 700),
(105, '2024-03-01', 200),
(103, '2024-03-08', 350),
(101, '2024-03-15', 600),
(104, '2024-03-20', 400),
(106, '2024-04-02', 550),
(105, '2024-04-10', 800),
(102, '2024-04-15', 650),
(103, '2024-05-01', 275),
(106, '2024-05-08', 900);


SELECT * FROM orders;

-- find customers whose total order amount is greater than 500.

SELECT customer_id, SUM(order_amount) As total_amt
FROM orders
GROUP BY customer_id
HAVING SUM(order_amount) > 500 ;


WITH cte1 AS (
	SELECT customer_id, SUM(order_amount) As total_amt
	FROM orders
	GROUP BY customer_id
)

SELECT * FROM cte1 
WHERE total_amt > 500;

-- CASE STUDY: Customer Lifetime Value (CLTV)



CREATE TABLE ord( customer_id INT, order_date DATE, amount INT ); 

INSERT INTO ord(customer_id, order_date, amount) VALUES
(101, '2024-01-05', 250),
(102, '2024-01-07', 500),
(103, '2024-01-10', 150),
(101, '2024-02-03', 300),
(104, '2024-02-05', 450),
(102, '2024-02-12', 700),
(105, '2024-03-01', 200),
(103, '2024-03-08', 350),
(101, '2024-03-15', 600),
(104, '2024-03-20', 400),
(106, '2024-04-02', 550),
(105, '2024-04-10', 800),
(102, '2024-04-15', 650),
(103, '2024-05-01', 275),
(106, '2024-05-08', 900);


-- Total amount a customer has spent
-- Segment customers based on total money spent:

WITH cust_sal AS
(
SELECT customer_id, SUM(amount) as total_sales
FROM ord
GROUP BY customer_id)

SELECT customer_id,
	CASE
		WHEN total_sales > 1000 THEN 'High'
		WHEN total_sales BETWEEN 500 AND 1000 THEN 'Medium'
		ELSE 'Low'
	END as cust_seg
FROM cust_sal

-- 

CREATE TABLE order_items(
	order_id INT,
	product_id INT

);


INSERT INTO order_items (order_id, product_id) VALUES
(1, 101),
(1, 102),
(2, 103),
(2, 104),
(3, 101),
(3, 105),
(4, 102),
(5, 103),
(5, 104),
(5, 106),
(6, 107),
(7, 101),
(7, 108),
(8, 109),
(9, 102),
(9, 103),
(10, 104),
(11, 105),
(12, 106),
(12, 107),
(13, 108),
(14, 109),
(15, 101),
(15, 110);

SELECT * FROM order_items
--(Q2) find top 2 most frequently co-purchased product pairs. (TRICKY)

WITH cte1 AS(
SELECT o1.product_id as p1, o2.product_id as p2, count(*) as freq_cnt
FROM order_items o1
JOIN order_items o2
ON o1.product_id = o2.product_id
WHERE o1.product_id < o2.product_id
GROUP BY o1.product_id, o2.product_id),
-- using window functions
rank as
(SELECT *,
ROW_NUMBER() OVER (ORDER BY freq_cnt DESC) as rw_no
FROM cte1) 

-- or using limit 
SELECT *
FROM rank 
WHERE rw_no < 3;
LIMIT 2


-- Q3. CASE: fraud detection

CREATE TABLE orders_fraud(
	user_id INT,
	order_time DATETIME
)
INSERT INTO orders_fraud (user_id, order_time) VALUES
(101, '2024-06-01 09:00:00'),
(101, '2024-06-01 09:02:00'),
(101, '2024-06-01 09:04:00'),
(102, '2024-06-01 10:15:00'),
(103, '2024-06-01 11:00:00'),
(103, '2024-06-01 11:30:00'),
(104, '2024-06-01 12:00:00'),
(104, '2024-06-01 12:01:00'),
(104, '2024-06-01 12:02:00'),
(105, '2024-06-01 13:20:00'),
(106, '2024-06-01 14:00:00'),
(106, '2024-06-01 14:03:00'),
(107, '2024-06-01 15:45:00'),
(108, '2024-06-01 16:10:00'),
(108, '2024-06-01 16:11:00'),
(109, '2024-06-01 17:30:00'),
(110, '2024-06-01 18:00:00'),
(110, '2024-06-01 18:01:00'),
(110, '2024-06-01 18:02:00'),
(110, '2024-06-01 18:04:00');


SELECT * FROM orders_fraud

-- Find users who placed more than 3 orders within 10 minutes (TRICKY)

WITH cte AS
(
    SELECT
        user_id,
        order_time,
        LAG(order_time, 3) OVER
        (
            PARTITION BY user_id
            ORDER BY order_time
        ) AS fourth_prev_order
    FROM orders_fraud
)
SELECT DISTINCT user_id
FROM cte
WHERE DATEDIFF(MINUTE, fourth_prev_order, order_time) <= 10;

-- self join

SELECT
    a.user_id
FROM orders_fraud a
JOIN orders_fraud b
    ON a.user_id = b.user_id
   AND b.order_time BETWEEN a.order_time
                        AND DATEADD(MINUTE, 10, a.order_time)
GROUP BY
    a.user_id,
    a.order_time
HAVING COUNT(*) > 3;


-- my approach(not that correct)
WITH cte1 AS (
SELECT
	user_id,
	order_time,
	LEAD(order_time) OVER(PARTITION BY user_id ORDER BY order_time) as next_order_time,
	COUNT(*) OVER (PARTITION BY user_id) as cnt
FROM orders_fraud), 
cte2 as
(SELECT *, DATEDIFF(MINUTE, order_time, next_order_time) as difference
FROM cte1)

SELECT user_id, SUM(difference) FROM cte2
WHERE cnt > 3
GROUP BY user_id
HAVING SUM(difference) <= 10;

-- CASE STUDY: Delivery SLA Breach
CREATE TABLE deliveries(
	order_id INT,
	city VARCHAR(50),
	expected_date DATE,
	actual_date DATE
);

INSERT INTO deliveries (order_id, city, expected_date, actual_date) VALUES
(1, 'New York',    '2024-06-01', '2024-06-01'),
(2, 'Chicago',     '2024-06-02', '2024-06-03'),
(3, 'Los Angeles', '2024-06-03', '2024-06-02'),
(4, 'Houston',     '2024-06-04', '2024-06-04'),
(5, 'Phoenix',     '2024-06-05', '2024-06-07'),
(6, 'Chicago',     '2024-06-06', '2024-06-06'),
(7, 'New York',    '2024-06-07', '2024-06-09'),
(8, 'Houston',     '2024-06-08', '2024-06-08'),
(9, 'Los Angeles', '2024-06-09', '2024-06-10'),
(10, 'Phoenix',    '2024-06-10', '2024-06-09'),
(11, 'Chicago',    '2024-06-11', '2024-06-11'),
(12, 'New York',   '2024-06-12', '2024-06-13'),
(13, 'Houston',    '2024-06-13', '2024-06-15'),
(14, 'Phoenix',    '2024-06-14', '2024-06-14'),
(15, 'Los Angeles','2024-06-15', '2024-06-16');

-- Find percentage of orders delivered late (after expected date) for each city.
SELECT city,
AVG(DATEDIFF(DAY,expected_date, actual_date)) as avg_delay
FROM deliveries
WHERE actual_date > expected_date
GROUP BY city

WITH cte1 AS (SELECT city,
CASE 
	WHEN actual_date > expected_date THEN 1 ELSE 0 
END as late 
from deliveries)

-- ANOTHER METHOD (NICE)

WITH cte1 AS (SELECT city,
COUNT(CASE 
	WHEN actual_date > expected_date THEN 1 
END) as late ,
COUNT(CASE WHEN actual_date <= expected_date THEN 1 END) as on_time
from deliveries
GROUP BY city)



SELECT *, ((late)*100.0/(late+on_time)) as pct
FROM cte1

-- CASE STUDY : Innventory stock (Running balance)


CREATE TABLE inventory (
product_id INT,
txn_date DATE,
change_qty INT);

INSERT INTO inventory (product_id, txn_date, change_qty) VALUES
(101, '2024-06-01', 100),
(101, '2024-06-03', -20),
(101, '2024-06-05', -15),
(101, '2024-06-08', 50),
(101, '2024-06-10', -30),

(102, '2024-06-01', 200),
(102, '2024-06-04', -40),
(102, '2024-06-06', -25),
(102, '2024-06-09', 75),
(102, '2024-06-12', -60),

(103, '2024-06-02', 150),
(103, '2024-06-05', -50),
(103, '2024-06-07', 30),
(103, '2024-06-10', -20),
(103, '2024-06-13', -40),

(104, '2024-06-01', 80),
(104, '2024-06-03', -10),
(104, '2024-06-06', -15),
(104, '2024-06-08', 25),
(104, '2024-06-11', -20),
(104, '2024-07-11', - 70);


SELECT * FROM inventory;

-- Find products where stock becomes negative at any point

WITH cte1 AS 
(SELECT *,
	SUM(change_qty) OVER (PARTITION BY product_id ORDER BY txn_date) as sm
FROM inventory)

SELECT * FROM cte1
WHERE sm < 0;


WITH cte1 AS
(SELECT product_id, SUM(change_qty) as sm
FROM inventory
GROUP BY product_id)

SELECT * FROM cte1
WHERE sm < 0


-- CASE STUDY: Top selling category per month(for each month, find the category with highest revenue)

CREATE TABLE orders_cte(
order_id INT,
order_date DATE);

CREATE TABLE order_items_cte(
order_id INT,
product_id INT,
amount INT);


CREATE TABLE products_cte(
product_id INT,
category VARCHAR(50));

INSERT INTO orders_cte (order_id, order_date) VALUES
(1, '2024-06-01'),
(2, '2024-06-01'),
(3, '2024-06-02'),
(4, '2024-06-02'),
(5, '2024-06-03'),
(6, '2024-06-03'),
(7, '2024-06-04'),
(8, '2024-06-05'),
(9, '2024-06-05'),
(10, '2024-06-06');


INSERT INTO order_items_cte (order_id, product_id, amount) VALUES
(1, 101, 120),
(1, 102, 80),
(2, 103, 150),
(2, 104, 200),
(3, 101, 100),
(3, 105, 250),
(4, 106, 180),
(5, 102, 90),
(5, 103, 140),
(6, 104, 210),
(6, 105, 160),
(7, 106, 300),
(8, 101, 110),
(8, 104, 220),
(9, 102, 95),
(9, 105, 175),
(10, 103, 130),
(10, 106, 280);


INSERT INTO products_cte (product_id, category) VALUES
(101, 'Electronics'),
(102, 'Electronics'),
(103, 'Clothing'),
(104, 'Furniture'),
(105, 'Furniture'),
(106, 'Sports');

select * from orders_cte;
SELECT * FROM order_items_cte
SELECT * FROM products_cte;
-- Top selling category per month(for each month, find the category with highest revenue)


WITH cte1 AS (
SELECT MONTH(order_date) as month_value,p.category as product, SUM(amount) as revenue
FROM orders_cte o1
LEFT JOIN order_items_cte o2
ON o1.order_id = o2.order_id
LEFT JOIN products_cte p
ON o2.product_id = p.product_id
GROUP BY MONTH(order_date), p.category
),


grouped as (
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY month_value ORDER BY revenue DESC) as rn
FROM cte1)

SELECT * FROM grouped
WHERE rn = 1;

--- Customer Retention analysis
-- (Q)Find customers who made purchase in consecutive months (for atleast 3 months) (Complex)



WITH cte1 AS
(
    SELECT
        customer_id,
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_value
    FROM orders
    GROUP BY
        customer_id,
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
),
cte2 AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY customer_id
               ORDER BY month_value
           ) AS rw
    FROM cte1
),
cte3 AS
(
    SELECT *,
           DATEADD(MONTH, -rw, month_value) AS grp
    FROM cte2
)
SELECT customer_id, grp
FROM cte3
GROUP BY customer_id, grp
HAVING COUNT(*) >= 3;


-- CASE STUDY: New vs Repeat customers

/* For every order, label it as:
New- Customer's firste ever order,
Repear - any order after the first*/



	start_date DATE,
	end_date DATE
	);

-- Q1. Generate all dates between start_date and end_date

-- Q2. Count number of days between start_date and end_date
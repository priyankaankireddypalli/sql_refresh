CREATE TABLE orders_inventory(
order_id INT PRIMARY KEY,
user_id INT,
order_date DATE);

INSERT INTO orders_inventory (order_id, user_id, order_date)
VALUES
-- User 101: Orders in Jan & Feb, but not Mar (Qualifies)
(1, 101, '2026-01-05'),
(2, 101, '2026-02-10'),

-- User 102: Orders in Jan, Feb & Mar (Does NOT Qualify)
(3, 102, '2026-01-08'),
(4, 102, '2026-02-12'),
(5, 102, '2026-03-15'),

-- User 103: Orders in Feb & Mar, but not Apr (Qualifies)
(6, 103, '2026-02-20'),
(7, 103, '2026-03-25'),

-- User 104: Orders in Apr & May, but not Jun (Qualifies)
(8, 104, '2026-04-01'),
(9, 104, '2026-05-05'),

-- User 105: Orders in May, Jun & Jul (Does NOT Qualify)
(10, 105, '2026-05-10'),
(11, 105, '2026-06-15'),
(12, 105, '2026-07-20'),

-- User 106: Only one order (Does NOT Qualify)
(13, 106, '2026-08-12'),

-- User 107: Orders in Jul & Aug, but not Sep (Qualifies)
(14, 107, '2026-07-02'),
(15, 107, '2026-08-09');



 -- (Q1). Identify users who placed orders in 2 consecutive months but not in 3rd month. (Tricky)





WITH cte1 AS (
SELECT distinct user_id, DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS formatted_date
FROM orders_inventory),
cte2 AS (
SELECT user_id, 
	   formatted_date,
	   LAG(formatted_date) OVER (PARTITION BY user_id ORDER BY formatted_date) as prev_month,
	   LEAD(formatted_date,1) OVER (PARTITION BY user_id ORDER BY formatted_date) as next_month,
	   LEAD(formatted_date,2) OVER (PARTITION BY user_id ORDER BY formatted_date) as third_month
FROM cte1)

SELECT distinct user_id FROM cte2
WHERE DATEDIFF(MONTH,formatted_date,next_month) = 1
AND 
(prev_month IS NULL OR DATEDIFF(MONTH, prev_month, formatted_date) > 1)
AND 
(third_month IS NULL OR DATEDIFF(MONTH, next_month, third_month) > 1);




 SELECT * FROM orders_inventory
 ORDER BY user_id

 WITH cte1 AS (
 SELECT distinct user_id, DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS formatted_date
 FROM orders_inventory),
cte2 AS (
 SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY formatted_date) as rw
 FROM cte1)

 SELECT user_id, DATEADD(MONTH,-rw,formatted_date)  as grp, count(*) as cnt
 FROM cte2
 GROUP BY user_id, DATEADD(MONTH,-rw,formatted_date)
 HAVING COUNT(*) = 2;




CREATE TABLE orders_log(
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE
);

INSERT INTO orders_log (order_id, customer_id, order_date)
VALUES
(1, 101, '2026-01-05'),
(2, 101, '2026-02-10'),
(3, 101, '2026-03-15'),
(4, 102, '2026-01-20'),
(5, 102, '2026-04-18'),
(6, 103, '2026-02-25'),
(7, 103, '2026-03-28'),
(8, 103, '2026-04-30'),
(9, 104, '2026-05-12'),
(10, 104, '2026-05-20'),
(11, 105, '2026-06-01'),
(12, 105, '2026-07-10');


-- Q1. Find customers who ordered products consecutively for N months

-- LETS SAY 3 months

-- step 1. FORMAT month to 01 
-- step 2. Determine row number
-- step 3: subtract formatted_date and given row_number
-- step 4: group by and filter using having

SELECT customer_id,grp, COUNT(*) As cnt
FROM (
SELECT *, DATEADD(MONTH,-rw,formatted_date) as grp from(
SELECT customer_id, formatted_date, 
ROW_NUMBER() OVER(PARTITION BY customer_id
ORDER BY formatted_date) as rw
FROM (SELECT
    customer_id,
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS formatted_date
FROM orders_log) t)t) t
GROUP BY customer_id, grp
HAVING COUNT(*) >= 3;
DROP TABLE orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount INT
);

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES
-- Customer 101: Multiple first orders on same date
(1, 101, '2026-01-05', 500),
(2, 101, '2026-01-05', 800),
(3, 101, '2026-02-10', 1200),

-- Customer 102: Only one first order
(4, 102, '2026-01-15', 700),
(5, 102, '2026-03-20', 900),

-- Customer 103: Multiple first orders on same date
(6, 103, '2026-02-01', 400),
(7, 103, '2026-02-01', 600),
(8, 103, '2026-04-12', 1000),

-- Customer 104: Only one order
(9, 104, '2026-03-05', 300),
(10, 104, '2026-04-15', 500),

-- Customer 105: Multiple first orders
(11, 105, '2026-05-10', 900),
(12, 105, '2026-05-10', 1100),
(13, 105, '2026-06-20', 1500);

SELECT * FROM orders

-- Q1. Customers with multiple first orders on the same date

SELECT customer_id,order_date, count(*) as cnt
FROM orders
GROUP BY customer_id,order_date
HAVING COUNT(*) > 1


-- THERE IS NO NEED TO JOIN ALSO
SELECT o.customer_id, o.order_date, count(*) As cnt
FROM orders o
JOIN orders o1
ON o.customer_id = o1.customer_id
AND o.order_id = o1.order_id
GROUP BY o.customer_id, o.order_date
HAVING COUNT(*) > 1
-- METHOD 1: using window functions


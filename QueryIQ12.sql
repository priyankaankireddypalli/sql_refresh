DROP TABLE orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount INT
);

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES
-- Customer 101
(1, 101, '2026-01-05', 500),
(2, 101, '2026-02-10', 1200),
(3, 101, '2026-03-15', 800),
(4, 101, '2026-04-20', 1500),
(5, 101, '2026-05-25', 700),

-- Customer 102
(6, 102, '2026-01-12', 900),
(7, 102, '2026-02-18', 400),
(8, 102, '2026-03-22', 1100),
(9, 102, '2026-04-08', 600),

-- Customer 103
(10, 103, '2026-01-20', 300),
(11, 103, '2026-02-25', 1300),
(12, 103, '2026-03-30', 950),
(13, 103, '2026-04-15', 2000),
(14, 103, '2026-05-18', 750),

-- Customer 104
(15, 104, '2026-02-05', 1000),
(16, 104, '2026-03-10', 500),
(17, 104, '2026-04-12', 800);

-- Q1. Rank orders based on order value for each customer and return top 3 orders per customer

SELECT * FROM orders

WITH cte1 AS (SELECT *,
      DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_amount DESC) as rnk
FROM orders)
SELECT * FROM cte1
WHERE rnk <= 3;
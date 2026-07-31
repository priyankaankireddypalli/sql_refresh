CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, category)
VALUES
(1, 'Electronics'),
(2, 'Electronics'),
(3, 'Accessories'),
(4, 'Furniture'),
(5, 'Books');

INSERT INTO orders (order_id, user_id, product_id, order_date)
VALUES
(101, 1, 1, '2026-07-01'),
(102, 2, 2, '2026-07-02'),
(103, 1, 3, '2026-07-03'),
(104, 3, 1, '2026-07-05'),
(105, 2, 4, '2026-07-06'),
(106, 4, 5, '2026-07-07'),
(107, 1, 1, '2026-07-08'),
(108, 5, 2, '2026-07-09'),
(109, 3, 3, '2026-07-10'),
(110, 2, 1, '2026-07-11');

SELECT * FROM products;
SELECT * FROM orders;

-- Q1. Most frequently purchased product category by each user over the past year (can use dense rank or row_number)
SELECT * FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY cnt DESC) as rw
FROM 
(SELECT user_id, product_id, COUNT(*) as cnt
FROM orders
WHERE order_date >  DATEADD(YEAR, -1, GETDATE())
GROUP BY user_id, product_id) t) t
WHERE rw = 1


-- using cte's

WITH counting_orders AS(
    SELECT user_id, product_id, COUNT(*) as cnt
    FROM orders
    WHERE order_date >  DATEADD(YEAR, -1, GETDATE())
    GROUP BY user_id, product_id

),
ranking as (
SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY cnt DESC) as rw
FROM counting_orders)

SELECT * FROM ranking
WHERE rw =1;

------
SELECT * FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY cnt DESC) as rnk FROM
(SELECT o.user_id, p.category, COUNT(*) As cnt
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.order_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY o.user_id, p.category) t
) t
WHERE rnk = 1


CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
signup_date DATE
);

INSERT INTO customers (customer_id, customer_name, city, signup_date) VALUES
(101, 'Alice Johnson', 'New York', '2023-01-15'),
(102, 'Bob Smith', 'Chicago', '2023-02-10'),
(103, 'Charlie Brown', 'Dallas', '2023-03-05'),
(104, 'David Wilson', 'Seattle', '2023-04-20'),
(105, 'Emma Davis', 'Boston', '2023-05-12'),
(106, 'Frank Miller', 'Houston', '2023-06-18'),
(107, 'Grace Lee', 'Miami', '2023-07-09'),
(108, 'Henry Taylor', 'Phoenix', '2023-08-14'),
(109, 'Ivy Anderson', 'Denver', '2023-09-22'),
(110, 'Jack Thomas', 'Atlanta', '2023-10-30'),
(111, 'Karen White', 'San Francisco', '2023-11-11'),
(112, 'Leo Martin', 'Las Vegas', '2023-12-05');


CREATE TABLE orders(
order_id INT,
customer_id INT,
order_amount INT,
order_date DATE,
product_category VARCHAR(50)
);

INSERT INTO orders (order_id, customer_id, order_amount, order_date, product_category) VALUES
(1001, 101, 250, '2024-01-05', 'Electronics'),
(1002, 101, 120, '2024-02-10', 'Books'),
(1003, 102, 500, '2024-01-15', 'Furniture'),
(1004, 103, 300, '2024-02-01', 'Electronics'),
(1005, 103, 450, '2024-03-12', 'Appliances'),
(1006, 104, 700, '2024-03-18', 'Furniture'),
(1007, 105, 150, '2024-04-05', 'Books'),
(1008, 106, 900, '2024-04-15', 'Electronics'),
(1009, 106, 250, '2024-05-01', 'Clothing'),
(1010, 107, 350, '2024-05-10', 'Sports'),
(1011, 108, 600, '2024-05-20', 'Electronics'),
(1012, 108, 220, '2024-06-02', 'Books'),
(1013, 109, 800, '2024-06-15', 'Appliances'),
(1014, 109, 180, '2024-07-01', 'Clothing'),
(1015, 110, 450, '2024-07-12', 'Furniture'),
(1016, 101, 320, '2024-08-05', 'Sports'),
(1017, 103, 275, '2024-08-20', 'Books'),
(1018, 106, 1000, '2024-09-01', 'Electronics'),
(1019, 110, 150, '2024-09-15', 'Books'),
(1020, 112, 550, '2024-10-10', 'Electronics');


SELECT * FROM customers;

SELECT * FROM orders;

-- MEDIUM
-- Q1. Get all customers along with their order details.
SELECT  c.customer_name, o.order_id, o.order_amount, o.product_category
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id


-- Q2. Display customer name and total number of orders placed.

SELECT c.customer_id, c.customer_name, count(o.order_id) as total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Q3. Find customers who have placed at least one order.
SELECT c.customer_id, c.customer_name, count(o.order_id) as total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING count(o.order_id) >= 1;

-- Q4. List customers who have not placed any orders.
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Q5. Get total order amount per customer
SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.order_amount),0) as total_order_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Q6. Show customer name and their highest order amount
SELECT c.customer_id, c.customer_name, COALESCE(max(o.order_amount),0) as highest_order_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name

-- Q7. Find all orders placed by customers from Dallas

SELECT o.order_id,o.order_amount, o.product_category, c.customer_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.city = 'Dallas'

SELECT o.order_id,o.order_amount, o.product_category, c.customer_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id 
WHERE c.city = 'Dallas';

-- Q8. Display customer name and order category for each order.
SELECT * FROM customers
SELECT * FROM orders

SELECT order_id, customer_name, product_category
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id;

-- Q9. Get customers who placed orders in Electronic category
SELECT distinct(customer_name)
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
where o.product_category = 'Electronics';

-- Q10. Find average order amount per customer
SELECT c.customer_id, c.customer_name, COALESCE(AVG(o.order_amount),0) AS avg_amt
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name

-- Medium to Hard level
-- Q11. Find top 3 customers based on total spending
SELECT TOP 3 c.customer_id, c.customer_name, COALESCE(SUM(o.order_amount),0) AS total_amt
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_amt DESC


SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.order_amount),0) AS total_amt
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_amt DESC
LIMIT 3;


-- Q12. Get customers whose total order amount is greater than 1000

SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.order_amount),0) AS total_amt
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COALESCE(SUM(o.order_amount),0) > 1000;



SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_amt
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.order_amount) > 1000;

-- Q13. Find customers who placed more than 2 orders
SELECT c.customer_id, c.customer_name, COUNT(*) as orders_cnt
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(*) > 2

-- Q14. Display each customer with their latest order date
SELECT c.customer_id, c.customer_name, MAX(o.order_date) as latest_date
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name


-- Q15. Find customers who never ordered Electronics products
SELECT c.customer_id, c.customer_name, o.product_category
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.product_category <> 'Electronics'

-- Q16. Get city-wise total revenue
SELECT c.city, COALESCE(SUM(o.order_amount),0) as revenue
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city

-- (Q17). Find customers whose first order amount > 300

SELECT c.customer_name, o.order_amount
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
WHERE (o.customer_id, o.order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM orders
    GROUP BY customer_id
)
AND o.order_amount > 300;


-- Q18. Display customers who ordered in multiple categories
SELECT c.customer_id, COUNT(DISTINCT(o.product_category)) as categories
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT(o.product_category)) > 1

-- Q19. Get the most popular category(highest number of orders)
SELECT TOP 1 product_category, COUNT(*) as cnt
FROM orders 
GROUP BY product_category
ORDER BY cnt DESC

-- (Q20). Find customers who spent more than average spending of all customers (Intreview Que)
-- NOTE: Subquery and CTE (Every subquery written can be written using CTE's)


-- SUBQUERY METHOD
SELECT customer_id, SUM(order_amount) as total_spent
FROM orders
GROUP BY customer_id 
HAVING SUM(order_amount) > (
SELECT AVG(total_spent) as avg_total FROM (SELECT customer_id, SUM(order_amount) as total_spent
FROM orders
GROUP BY customer_id) AS customers_total );

/* CTE's
COMMON TABLE Expression - we create a temporary table */
WITH customers_total AS (
SELECT customer_id, SUM(order_amount) as total_spent
FROM orders
GROUP BY customer_id 
)

SELECT customer_id, total_spent
FROM customers_total
WHERE total_spent > (SELECT AVG(total_spent) FROM customers_total);


DROP TABLE products
DROP TABLE orders

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE
);

INSERT INTO products (product_id, product_name, price)
VALUES
(101, 'Laptop', 80000),
(102, 'Mobile', 30000),
(103, 'Tablet', 25000),
(104, 'Keyboard', 3000),
(105, 'Monitor', 20000),
(106, 'Printer', 15000),
(107, 'Headphones', 5000);

INSERT INTO orders (order_id, customer_id, product_id, order_date)
VALUES
(1, 201, 101, '2026-01-10'),
(2, 202, 102, '2026-01-15'),
(3, 203, 101, '2026-02-05'),
(4, 204, 103, '2026-02-20'),
(5, 205, 105, '2026-03-01'),
(6, 201, 102, '2026-03-10'),
(7, 203, 104, '2026-03-15');


-- Find products that were never purchased by any customer

SELECT p.product_name FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE o.product_id IS NULL

SELECT * FROM products
WHERE product_id NOT IN (SELECT product_id 
FROM orders
WHERE product_id IS NOT NULL)

-- using not exists
SELECT * FROM products p
WHERE NOT EXISTS (
SELECT 1
FROM orders o
WHERE o.product_id = p.product_id)

SELECT * FROM orders
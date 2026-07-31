CREATE TABLE sales_info (
    sale_id INT PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(50),
    sale_date DATE,
    sales_amount INT
);


INSERT INTO sales_info (sale_id, product_id, product_name, sale_date, sales_amount)
VALUES
(1, 101, 'Laptop', '2026-01-05', 55000),
(2, 102, 'Mobile', '2026-01-10', 25000),
(3, 101, 'Laptop', '2026-02-15', 60000),
(4, 103, 'Keyboard', '2026-02-20', 2000),
(5, 104, 'Mouse', '2026-03-01', 1000),
(6, 101, 'Laptop', '2026-03-18', 58000),
(7, 105, 'Monitor', '2026-04-08', 15000),
(8, 102, 'Mobile', '2026-04-15', 28000),
(9, 103, 'Keyboard', '2026-05-12', 2200),
(10, 101, 'Laptop', '2026-05-25', 62000);
INSERT INTO sales_info
VALUES(11, 101, 'Laptop', '2025-05-25',65000)

SELECT * FROM sales_info
-- Q1. Generate a sequential ranking of products based on total sales, resetting the ranking for each year.

SELECT *, DENSE_RANK() OVER(PARTITION BY yearly ORDER BY total_sales DESC) as rnk
FROM (SELECT product_id, YEAR(sale_date) as yearly,SUM(sales_amount) as total_sales
FROM sales_info
GROUP BY product_id, YEAR(sale_date)
) t
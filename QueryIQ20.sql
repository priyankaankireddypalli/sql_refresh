
use tempdb;

CREATE TABLE sales_log(
sale_id INT PRIMARY KEY,
product_name VARCHAR(50),
sale_date DATE,
sales_amount INT);


INSERT INTO sales_log (sale_id, product_name, sale_date, sales_amount)
VALUES
(1, 'Laptop', '2026-01-05', 55000),
(2, 'Mobile', '2026-01-12', 25000),
(3, 'Laptop', '2026-02-10', 60000),
(4, 'Keyboard', '2026-02-18', 2000),
(5, 'Mouse', '2026-03-08', 1000),
(6, 'Laptop', '2026-03-15', 58000),
(7, 'Monitor', '2026-04-20', 15000),
(8, 'Mobile', '2026-04-22', 28000),
(9, 'Keyboard', '2026-05-10', 2200),
(10, 'Laptop', '2026-05-25', 62000);

SELECT * FROM sales_log
-- Q1. PIVOT a sales transaction table into monthly summary columns
-- MONTHLY Sales by product

SELECT
	product_name,
	SUM(CASE WHEN DATEPART(MONTH,sale_date) = 1 THEN sales_amount ELSE 0 END) as 'January',
	SUM(CASE WHEN DATEPART(MONTH,sale_date) = 2 THEN sales_amount ELSE 0 END) as 'February',
	SUM(CASE WHEN DATEPART(MONTH,sale_date) = 3 THEN sales_amount ELSE 0 END)as 'March',
	SUM(CASE WHEN DATEPART(MONTH,sale_date) = 4 THEN sales_amount ELSE 0 END) as 'April',
	SUM(CASE WHEN DATEPART(MONTH,sale_date) = 5 THEN sales_amount ELSE 0 END) as 'May'
FROM sales_log
GROUP BY product_name

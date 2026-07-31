
CREATE TABLE sales(
	sale_id INT,
	product_id INT,
	sale_date DATE,
	sales_amount INT
);

INSERT INTO sales (sale_id, product_id, sale_date, sales_amount)
VALUES
-- Product 101
(1, 101, '2026-01-05', 500),
(2, 101, '2026-01-12', 700),
(3, 101, '2026-02-08', 900),
(4, 101, '2026-03-15', 1200),

-- Product 102
(5, 102, '2026-01-10', 300),
(6, 102, '2026-02-14', 450),
(7, 102, '2026-02-25', 550),
(8, 102, '2026-03-20', 650),

-- Product 103
(9, 103, '2026-01-18', 1000),
(10, 103, '2026-03-05', 800),
(11, 103, '2026-04-12', 950),

-- Product 104
(12, 104, '2026-02-01', 400),
(13, 104, '2026-02-18', 600),
(14, 104, '2026-03-08', 750),
(15, 104, '2026-04-15', 850),

-- Product 105
(16, 105, '2026-01-22', 200),
(17, 105, '2026-02-11', 350),
(18, 105, '2026-03-17', 450),
(19, 105, '2026-04-25', 600),
(20, 105, '2026-05-10', 700);


SELECT * FROM sales

-- Q1. Find the 7-Day moving average of sales for each product
SELECT *,
AVG(sales_amount) OVER(PARTITION BY product_id ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as avg
FROM sales

-- Q2. total sales in the last 7 days per product
SELECT *,
SUM(sales_amount) OVER(PARTITION BY product_id ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as total_sales
FROM sales

SELECT product_id, SUM(sales_amount) as total_sales
FROM sales
WHERE sale_date BETWEEN DATEADD(DAY,-6,GETDATE()) AND GETDATE()
GROUP BY product_id

-- OR

SELECT product_id, SUM(sales_amount) as total_sales
FROM sales
WHERE sale_date >= DATEADD(DAY,-6,GETDATE())
GROUP BY product_id

-- Q3. Calculate ROlling avergae on complete historical data
SELECT *,
AVG(sales_amount) OVER(PARTITION BY product_id ORDER BY sale_date) as moving_avg
FROM sales


-- Q4. Rolling average on: ONLY LAST 7 DAYS Data

SELECT *,
AVG(sales_amount) OVER(PARTITION BY product_id ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as avg
FROM sales
WHERE sale_date BETWEEN DATEADD(DAY,-6,GETDATE()) AND GETDATE()
GROUP BY product_id
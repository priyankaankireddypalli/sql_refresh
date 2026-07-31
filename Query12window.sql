--- WINDOW FUNCTIONS CONTINUE

CREATE TABLE ecom_sales(
	sale_id INT PRIMARY KEY,
	sale_date DATE NOT NULL,
	region VARCHAR(20) NOT NULL,
	category VARCHAR(20) NOT NULL,
	sales_rep VARCHAR(20) NOT NULL,
	revenue DECIMAL(10,2) NOT NULL,
	units_sold INT NOT NULL,
	discount_pct DECIMAL(5,2) DEFAULT 0
);

INSERT INTO ecom_sales
(sale_id, sale_date, region, category, sales_rep, revenue, units_sold, discount_pct)
VALUES
(1,  '2024-01-01', 'North', 'Electronics', 'Alice',   1200.00, 12, 10.00),
(2,  '2024-01-01', 'North', 'Furniture',   'Bob',      800.00,  4,  5.00),
(3,  '2024-01-02', 'South', 'Electronics', 'Charlie', 1500.00, 15, 15.00),
(4,  '2024-01-02', 'West',  'Clothing',    'David',    600.00, 20, 20.00),
(5,  '2024-01-03', 'East',  'Furniture',   'Eva',     1000.00,  5,  0.00),

-- Same sales rep multiple sales
(6,  '2024-01-03', 'North', 'Electronics', 'Alice',    900.00,  9,  5.00),
(7,  '2024-01-04', 'North', 'Clothing',    'Alice',    400.00, 16, 25.00),

-- Duplicate business record (different sale_id)
(8,  '2024-01-04', 'North', 'Clothing',    'Alice',    400.00, 16, 25.00),

-- Zero revenue
(9,  '2024-01-05', 'South', 'Furniture',   'Bob',        0.00,  3, 10.00),

-- Zero units sold
(10, '2024-01-05', 'West',  'Electronics', 'Charlie',  700.00,  0,  0.00),

-- High discount
(11, '2024-01-06', 'East',  'Clothing',    'David',    350.00, 10, 50.00),

-- No discount (default)
(12, '2024-01-06', 'South', 'Electronics', 'Eva',     2000.00, 18, DEFAULT),

-- Same day multiple categories
(13, '2024-01-06', 'South', 'Furniture',   'Eva',      950.00,  6, 10.00),

-- Duplicate revenue
(14, '2024-01-07', 'North', 'Electronics', 'Bob',     1200.00, 11,  5.00),

-- Same revenue again
(15, '2024-01-07', 'East',  'Electronics', 'Charlie', 1200.00, 12,  5.00),

-- Low revenue
(16, '2024-01-08', 'West',  'Clothing',    'Alice',    100.00,  5,  0.00),

-- Highest revenue
(17, '2024-01-08', 'South', 'Electronics', 'David',   5000.00, 30,  8.00),

-- Same rep different region
(18, '2024-01-09', 'East',  'Furniture',   'Bob',     1300.00,  8, 12.00),

-- Same category
(19, '2024-01-09', 'North', 'Electronics', 'Charlie', 1800.00, 20, 15.00),

-- End of sample
(20, '2024-01-10', 'West',  'Furniture',   'Eva',     2200.00, 14,  5.00);






-- Q1. For each region, calculate the cumulative revenue ordered by sale date.
-- The business team wants to track how each region's total revenue has built up over time.

SELECT * FROM ecom_sales;

SELECT *,
	SUM(revenue) OVER(PARTITION BY region ORDER BY sale_date) as cum_rev
FROM ecom_sales

/* Q2. Calculate each transaction's revenue as a percentage of the total revenue within its product category.*/
SELECT
	sale_id, category, revenue,
	SUM(revenue) OVER(PARTITION BY category) as total_rev,
	ROUND((revenue*100.0)/(SUM(revenue) OVER(PARTITION BY category)),2) as pct
FROM ecom_sales

/* Q3. For each sales rep, find the running total of units sold ordered by sale date*/

SELECT
	*,
	SUM(units_sold) OVER(PARTITION BY sales_rep ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total
FROM ecom_sales

/* (Q4). Compute a 3-transaction moving average of revenue for each region, ordered by sale date, to smooth out weekly volatility.*/


SELECT
	*,
	AVG(revenue) OVER(PARTITION BY region ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as txn_three_avg
FROM ecom_sales

/* Q5. For every row, show the highest revenue transaction recorded so far within the same category, ordered by sale date */
SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY category ORDER BY sale_date, revenue) as rw
FROM ecom_sales

/* Q6. Within each region, compute each transactions revenue deviation from that region's average revenue.*/

SELECT
	*,
	AVG(revenue) OVER(PARTITION BY region) as avg_region,
	revenue - AVG(revenue) OVER(PARTITION BY region) as deviation
FROM ecom_sales

/* Q7. Find the minimum and maximum revenue recorded in each category up to and including each transactiond date*/
SELECT 
	category,
	sale_date,
	MAX(revenue) OVER(ORDER BY category) as max_revenue,
	MIN(revenue) OVER(ORDER BY category) as min_revenue
FROM ecom_sales


/* Q8. Rank all transactions by revenue within each region. Transacations with the same revenue should receieve the same
rank, and the next rank should skip accordingly*/

SELECT
	*,
	RANK() OVER(PARTITION BY region ORDER BY revenue DESC) as rnk
FROM ecom_sales

/* Q9. Assign a continuous rank to each sales rep's transactions within their category, 
ordered by revenue descending, with no gaps in rank values. */

SELECT 
	*,
	DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC) as dn_rnk
FROM ecom_sales
/* Q10. Identify the top 2 revenue-generating transactions per region. If two transactions tie, both should appear */
SELECT * FROM (SELECT
    *,
    DENSE_RANK() OVER(PARTITION BY region ORDER BY revenue DESC) as dn_rnk
FROM ecom_sales) t
WHERE dn_rnk < 3;
/* Q11. Divide transactions within each category into 4 equal revenue bands(quartiles) for performance tier reporting */
/* Q12. For each region, assign a sequential number to transactions ordered by sale date, restarting from 1 for each region */
/* Q13. Find the sales rep with the highest total revenue in each region. Display only the top ranked rep per region*/
/* Q14. Classify each transaction into one of 3 revenue tiers - high, mid, low - 
evenly distributed within each product category*/

 SELECT category, revenue, NTILE(3) OVER(PARTITION BY category ORDER BY revenue) as classifications FROM ecom_sales;
/* Q15. For each transaction, retrieve the revenue from the previous transactions made in the same region (ordered by sale date)
to compare period over period performance.*/



/* Q16. For each transaction, show what the next transactions revenue in the same category will be, order by sale date
to support forward looking reporting */


SELECT
	*,
	LEAD(revenue) OVER(PARTITION BY category ORDER BY sale_date) as next
FROM ecom_sales


/* (Q17). Calculate week - over week revenue change for each region by comparing each transactions revenue to the previous 
one in that region(Tricky) */
WITH weekly_sales AS
(
    SELECT
        region,
        DATEPART(WEEK, sale_date) AS week_no,
        SUM(revenue) AS weekly_revenue
    FROM ecom_sales
    GROUP BY
        region,
        DATEPART(WEEK, sale_date)
)

SELECT
    region,
    week_no,
    weekly_revenue,

    LAG(weekly_revenue) OVER
    (
        PARTITION BY region
        ORDER BY week_no
    ) AS previous_week_revenue,

    weekly_revenue -
    LAG(weekly_revenue) OVER
    (
        PARTITION BY region
        ORDER BY week_no
    ) AS revenue_change
FROM weekly_sales;

-- PERCENTAGE 

WITH weekly_sales AS
(
    SELECT
        region,
        DATEPART(WEEK, sale_date) AS week_no,
        SUM(revenue) AS weekly_revenue
    FROM ecom_sales
    GROUP BY
        region,
        DATEPART(WEEK, sale_date)
)
SELECT
    region,
    week_no,
    weekly_revenue,
    LAG(weekly_revenue) OVER
    (
        PARTITION BY region
        ORDER BY week_no
    ) AS previous_week_revenue,

    ROUND(
        (
            weekly_revenue -
            LAG(weekly_revenue) OVER
            (
                PARTITION BY region
                ORDER BY week_no
            )
        ) * 100.0
        /
        NULLIF(
            LAG(weekly_revenue) OVER
            (
                PARTITION BY region
                ORDER BY week_no
            ),
            0
        ),
        2
    ) AS pct_change
FROM weekly_sales;


/*
SELECT *,
    revenue - LAG(revenue) OVER(PARTITION BY region ORDER BY sale_date) as rev,
	SUM(revenue) OVER(PARTITION BY region ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as weekly,
	ROUND(revenue - LAG(revenue) OVER(PARTITION BY region ORDER BY sale_date)/SUM(revenue) OVER(PARTITION BY region ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) as compare
FROM ecom_sales

*/

/* (Q18). For each sales_rep, find whether their most recent transaction had higher or lower revenue than their previous one,
ordered by sale date*/

SELECT
	*,
    LAG(revenue) OVER(PARTITION BY sales_rep ORDER BY sale_date) as previous,
    CASE
        WHEN revenue > LAG(revenue) OVER(PARTITION BY sales_rep ORDER BY sale_date) THEN 'HIGH'
        WHEN revenue < LAG(revenue) OVER(PARTITION BY sales_rep ORDER BY sale_date) THEN 'LOW'
        WHEN revenue = LAG(revenue) OVER(PARTITION BY sales_rep ORDER BY sale_date) THEN 'SAME'
        ELSE 'NULL'
    END as val
FROM ecom_sales

/* Q19. Managements wants to see each transactions revenue alongside the revenue frm 2 transactions 
ago within the same category to identify longer term trends */

SELECT sale_date,category,revenue,
	SUM(revenue) OVER(PARTITION BY category ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as txn_check
FROM ecom_sales

/* Q20. Produce a report showing, for each transaction, the date of the next sale in the same region so the team
can measure the gap between transacations */

SELECT
	*,
	LEAD(sale_date) OVER(PARTITION BY region ORDER BY sale_date) as nxt_dte,
	DATEDIFF(DAY,LEAD(sale_date) OVER(PARTITION BY region ORDER BY sale_date),sale_date) as diff
FROM ecom_sales


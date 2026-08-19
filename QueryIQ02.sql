-- RUNNING TOTAL
SELECT
    month,
    sales,
    SUM(sales) OVER (
        ORDER BY month
    ) AS running_total
FROM sales;
-- TOP N CUSTOMERS

SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 3;

SELECT *
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        DENSE_RANK() OVER (
            ORDER BY SUM(amount) DESC
        ) AS rnk
    FROM orders
    GROUP BY customer_id
) t
WHERE rnk <= 3;

%sql
SELECT * FROM (SELECT *,
    DENSE_RANK() OVER (ORDER BY salary DESC) as dn_rk
FROM emp) t
WHERE dn_rk <= 4;



CREATE TABLE user_login (
    login_id INT PRIMARY KEY,
    user_id INT,
    login_date DATE
);

INSERT INTO user_login (login_id, user_id, login_date)
VALUES
(1, 101, '2026-07-01'),
(2, 101, '2026-07-02'),
(3, 101, '2026-07-03'),
(4, 102, '2026-07-01'),
(5, 102, '2026-07-03'),
(6, 102, '2026-07-04'),
(7, 103, '2026-07-05'),
(8, 103, '2026-07-06'),
(9, 103, '2026-07-07');

SELECT * FROM user_login


-- Q1. Which user logged in three consecutive days

-- steps 1: assign row number 
-- step 2: subtract the date with the assigned row number
-- step 3: group by and filter it.


SELECT user_id, grouped, COUNT(*) as cnt FROM (SELECT *, DATEADD(DAY,-rnk,login_date) as grouped FROM (
SELECT *,ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) as rnk
FROM user_login) t) t
GROUP BY user_id, grouped
HAVING COUNT(*) >= 3


-- using cte


WITH cte1 AS
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) AS rnk
    FROM user_login
),
cte2 AS
(
    SELECT *,
           DATEADD(DAY, -rnk, login_date) AS grouped
    FROM cte1
)
SELECT
    user_id,
    grouped,
    COUNT(*) AS cnt
FROM cte2
GROUP BY user_id, grouped
HAVING COUNT(*) >= 3;

use tempdb
DROP TABLE transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount INT
);

INSERT INTO transactions (transaction_id, customer_id, transaction_date, amount)
VALUES
-- Customer 101: Transactions in all 12 months ✅
(1, 101, '2026-01-10', 500),
(2, 101, '2026-02-15', 700),
(3, 101, '2026-03-12', 600),
(4, 101, '2026-04-20', 800),
(5, 101, '2026-05-05', 900),
(6, 101, '2026-06-18', 400),
(7, 101, '2026-07-22', 1000),
(8, 101, '2026-08-11', 750),
(9, 101, '2026-09-14', 650),
(10, 101, '2026-10-25', 1200),
(11, 101, '2026-11-09', 550),
(12, 101, '2026-12-30', 950),

-- Customer 102: Missing some months ❌
(13, 102, '2026-01-05', 300),
(14, 102, '2026-02-10', 500),
(15, 102, '2026-03-15', 600),
(16, 102, '2026-05-20', 700),
(17, 102, '2026-07-25', 800),
(18, 102, '2026-12-01', 900),

-- Customer 103: Transactions in all months ✅
(19, 103, '2026-01-08', 400),
(20, 103, '2026-02-08', 450),
(21, 103, '2026-03-08', 500),
(22, 103, '2026-04-08', 550),
(23, 103, '2026-05-08', 600),
(24, 103, '2026-06-08', 650),
(25, 103, '2026-07-08', 700),
(26, 103, '2026-08-08', 750),
(27, 103, '2026-09-08', 800),
(28, 103, '2026-10-08', 850),
(29, 103, '2026-11-08', 900),
(30, 103, '2026-12-08', 950);

-- Q1. Find customers who made transactions in every month of the year (Tricky)

SELECT * FROM transactions

SELECT customer_id, YEAR(transaction_date) as yr, COUNT(*) AS cnt
FROM transactions
GROUP BY customer_id, YEAR(transaction_date)
HAVING COUNT(*) = 12

SELECT customer_id, YEAR(transaction_date) as yr
FROM transactions
GROUP BY customer_id, YEAR(transaction_date)
HAVING COUNT(DISTINCT MONTH(transaction_date)) = 12

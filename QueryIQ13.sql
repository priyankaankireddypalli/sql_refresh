use tempdb;

CREATE TABLE employee_log(
emp_id INT,
emp_name VARCHAR(50),
salary INT);

INSERT INTO employee_log (emp_id, emp_name, salary)
VALUES
(101, 'Alice', 50000),
(102, 'Bob', 65000),
(103, 'Charlie', 70000),
(104, 'David', 65000),
(105, 'Emma', 80000),
(106, 'Frank', 55000),
(107, 'Grace', 90000),
(108, 'Henry', 75000),
(109, 'Isabella', 90000),
(110, 'Jack', 60000),
(111, 'Kevin', 70000),
(112, 'Linda', 85000),
(113, 'Michael', 50000),
(114, 'Nancy', 95000),
(115, 'Olivia', 72000);

-- Q1. FInd the median salary of employees (tricky)
-- Step 1: order by ascending
WITH cte1 AS (
SELECT *,
ROW_NUMBER() OVER (ORDER BY modified_salary) as rnk,
COUNT(*) OVER () as total_records
FROM
(
SELECT emp_id, emp_name, COALESCE(salary,0) as modified_salary
FROM employee_log) t)

SELECT avg(modified_salary) as median
FROM cte1
WHERE rnk IN ((total_records+1)/2, (total_records+2)/2)
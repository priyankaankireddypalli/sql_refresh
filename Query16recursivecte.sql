-- Recurrsive cte

/* Creating one cte, and using the same cte multiple times.
Used in cases: hierarchy, or family tree or sequences. determine the employees who report to the which managers*/ 


SELECT * FROM corporate_employees


-- Q1. Display full employee hierarchy (manager + all subordinates)
-- use keyword reccursive: IN SQL SERVER no need of recursive key word
WITH  recursive emp_hierarchy as (
	SELECT employee_id, employee_name, manager_id, 1 as level
FROM corporate_employees
WHERE manager_id IS NULL

UNION ALL
SELECT c.employee_id, c.employee_name, c.manager_id, e.level+1 as level
FROM corporate_employees c
JOIN emp_hierarchy e
ON c.manager_id = e.employee_id
)


SELECT * FROM emp_hierarchy


WITH emp_hierarchy AS
(
    -- Anchor member
    SELECT
        employee_id,
        employee_name,
        manager_id,
        1 AS level
    FROM corporate_employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive member
    SELECT
        c.employee_id,
        c.employee_name,
        c.manager_id,
        e.level + 1 AS level
    FROM corporate_employees c
    JOIN emp_hierarchy e
        ON c.manager_id = e.employee_id
)
SELECT *
FROM emp_hierarchy;




-- Q2. Find all employees under MAnager1( emp_id = 2)
WITH cte1 AS (
SELECT employee_id, employee_name, manager_id FROM corporate_employees
WHERE employee_id = 2

UNION ALL
SELECT c.employee_id, c.employee_name, c.manager_id
FROM corporate_employees c
JOIN cte1 h
ON c.manager_id = h.employee_id
)

SELECT * FROM cte1;

-- Q2.
CREATE TABLE date_range(

	start_date DATE,
	end_date DATE
	);

-- Q1. Generate all dates between start_date and end_date

-- Q2. Count number of days between start_date and end_date
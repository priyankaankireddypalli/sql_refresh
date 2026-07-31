DROP TABLE employees

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (emp_id, emp_name, department, salary)
VALUES
-- IT Department
(101, 'Alice', 'IT', 70000),
(102, 'Bob', 'IT', 80000),
(103, 'Charlie', 'IT', 90000),

-- HR Department
(104, 'David', 'HR', 60000),
(105, 'Emma', 'HR', 65000),
(106, 'Frank', 'HR', 70000),

-- Finance Department
(107, 'Grace', 'Finance', 95000),
(108, 'Henry', 'Finance', 85000),
(109, 'Isabella', 'Finance', 90000),

-- Sales Department
(110, 'Jack', 'Sales', 50000),
(111, 'Kevin', 'Sales', 55000),
(112, 'Linda', 'Sales', 60000),

-- Marketing Department
(113, 'Michael', 'Marketing', 75000),
(114, 'Nancy', 'Marketing', 70000),
(115, 'Olivia', 'Marketing', 80000);

-- Q1. Retrieve the department with the highest total salary paid to employees

-- USING GROUP BY AND HAVING
SELECT department, SUM(salary) as sm
FROM employees
GROUP BY department
ORDER BY sm DESC
LIMIT 1

-- USING window function
SELECT distinct department, total_salary
FROM (SELECT *,
    DENSE_RANK() OVER(ORDER BY total_salary DESC) as rnk
FROM (SELECT *,
    SUM(salary) OVER(PARTITION BY department) as total_salary
FROM employees) t) t
WHERE rnk = 1

-- USING MAX() subquery?

SELECT department,
       total_salary
FROM (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
) t
WHERE total_salary = (
    SELECT MAX(total_salary)
    FROM (
        SELECT
            department,
            SUM(salary) AS total_salary
        FROM employees
        GROUP BY department
    ) x
);



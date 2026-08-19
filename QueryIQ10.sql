-- Q1. Find employees who have the same salary as another employee in the same department
CREATE TABLE employees_details(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
INSERT INTO employees_details (emp_id, emp_name, department, salary)
VALUES
-- IT Department
(101, 'Alice', 'IT', 70000),
(102, 'Bob', 'IT', 80000),
(103, 'Charlie', 'IT', 70000),
(104, 'David', 'IT', 90000),

-- HR Department
(105, 'Emma', 'HR', 60000),
(106, 'Frank', 'HR', 75000),
(107, 'Grace', 'HR', 60000),
(108, 'Henry', 'HR', 85000),

-- Finance Department
(109, 'Isabella', 'Finance', 95000),
(110, 'Jack', 'Finance', 85000),
(111, 'Kevin', 'Finance', 95000),

-- Sales Department
(112, 'Linda', 'Sales', 50000),
(113, 'Michael', 'Sales', 65000),
(114, 'Nancy', 'Sales', 75000),
(115, 'Olivia', 'Sales', 65000);

-- Q1. Find employees who have the same salary as another employee in the same department (TRICKY)

SELECT * FROM employees_details
-- MEthod 1: self join

SELECT e1.emp_name as employee,
e2. emp_name as employee
FROM employees_details e1
JOIN employees_details e2
ON e1.department = e2.department AND e1.salary = e2.salary
WHERE e1.emp_id < e2.emp_id

SELECT department, salary, COUNT(*) as cnt
FROM employees_details
WHERE SALARY IS NOT NULL
GROUP BY department, salary
HAVING COUNT(*) > 1


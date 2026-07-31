-- Create a table employee

CREATE TABLE employee(
	emp_id INT PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(30),
	job_role VARCHAR(30),
	salary DECIMAL(10, 2),
	hire_date DATE,
	city VARCHAR(30),
	manager_id INT
);
select * from EMPLOYEE;



INSERT INTO employee (
    emp_id,
    name,
    department,
    job_role,
    salary,
    hire_date,
    city,
    manager_id
)
VALUES
(101, 'John Smith', 'IT', 'Software Engineer', 75000.00, '2021-03-15', 'New York', 201),
(102, 'Emily Davis', 'HR', 'HR Executive', 55000.00, '2022-06-10', 'Chicago', 202),
(103, 'Michael Brown', 'Finance', 'Accountant', 62000.00, '2020-11-20', 'Dallas', 203),
(104, 'Sarah Wilson', 'IT', 'Database Administrator', 82000.00, '2019-08-05', 'Seattle', 201),
(105, 'David Miller', 'Sales', 'Sales Executive', 58000.00, '2023-01-12', 'Boston', 204),
(106, 'Jessica Taylor', 'Marketing', 'Marketing Analyst', 60000.00, '2021-09-18', 'San Francisco', 205),
(107, 'Robert Anderson', 'IT', 'System Analyst', 70000.00, '2020-04-22', 'Austin', 201),
(108, 'Linda Thomas', 'Finance', 'Financial Analyst', 68000.00, '2022-02-14', 'Miami', 203),
(109, 'James White', 'Sales', 'Sales Manager', 90000.00, '2018-12-01', 'New York', NULL),
(110, 'Sophia Martin', 'HR', 'HR Manager', 85000.00, '2019-07-30', 'Chicago', NULL),
(111, 'Daniel Harris', 'IT', 'DevOps Engineer', 80000.00, '2020-09-05', 'Seattle', 201),
(112, 'Olivia Clark', 'Marketing', 'Content Writer', 52000.00, '2022-03-17', 'Los Angeles', 205),
(113, 'Matthew Lewis', 'Finance', 'Auditor', 64000.00, '2021-01-11', 'Houston', 203),
(114, 'Emma Walker', 'Sales', 'Sales Representative', 56000.00, '2023-04-08', 'Denver', 204),
(115, 'Andrew Hall', 'IT', 'QA Engineer', 67000.00, '2020-05-19', 'Austin', 201),
(116, 'Grace Allen', 'HR', 'Recruiter', 57000.00, '2021-08-24', 'Chicago', 202),
(117, 'Joshua Young', 'Finance', 'Payroll Specialist', 59000.00, '2022-07-13', 'Dallas', 203),
(118, 'Chloe King', 'Marketing', 'SEO Specialist', 61000.00, '2021-11-29', 'San Diego', 205),
(119, 'Ryan Scott', 'IT', 'Network Engineer', 73000.00, '2019-06-03', 'Seattle', 201),
(120, 'Ava Green', 'Sales', 'Business Development Executive', 65000.00, '2020-10-16', 'Boston', 204),
(131, 'Ethan Moore', 'IT', 'Frontend Developer', 72000.00, '2021-02-11', 'Austin', 201),
(132, 'Isabella Lee', 'HR', 'HR Specialist', 59000.00, '2022-08-05', 'Chicago', 202),
(133, 'Alexander Hill', 'Finance', 'Tax Consultant', 71000.00, '2020-06-18', 'Dallas', 203),
(134, 'Harper Young', 'Marketing', 'Brand Manager', 78000.00, '2019-10-09', 'San Francisco', 205),
(135, 'Jacob Wright', 'Sales', 'Sales Consultant', 62000.00, '2023-01-25', 'Boston', 204),
(136, 'Abigail Lopez', 'IT', 'Backend Developer', 83000.00, '2020-11-15', 'Seattle', 201),
(137, 'William King', 'Finance', 'Budget Analyst', 68000.00, '2021-07-08', 'Houston', 203),
(138, 'Elizabeth Green', 'HR', 'Compensation Analyst', 65000.00, '2022-04-20', 'Chicago', 202),
(139, 'Michael Adams', 'IT', 'Technical Lead', 98000.00, '2018-05-17', 'New York', NULL),
(140, 'Sofia Nelson', 'Marketing', 'Marketing Coordinator', 57000.00, '2023-03-12', 'Los Angeles', 205),
(141, 'David Carter', 'Sales', 'Regional Sales Manager', 95000.00, '2019-09-30', 'Miami', NULL),
(142, 'Avery Mitchell', 'IT', 'Full Stack Developer', 86000.00, '2020-12-01', 'Austin', 201),
(143, 'Joseph Perez', 'Finance', 'Investment Analyst', 89000.00, '2019-01-22', 'Dallas', 203),
(144, 'Scarlett Roberts', 'HR', 'Talent Acquisition Specialist', 61000.00, '2021-06-14', 'Chicago', 202),
(145, 'Daniel Turner', 'Marketing', 'Social Media Manager', 66000.00, '2022-02-10', 'San Diego', 205),
(146, 'Victoria Phillips', 'IT', 'Mobile App Developer', 81000.00, '2020-08-27', 'Seattle', 201),
(147, 'Matthew Campbell', 'Sales', 'Sales Associate', 56000.00, '2023-04-18', 'Boston', 204),
(148, 'Luna Parker', 'Finance', 'Accounts Payable Officer', 60000.00, '2021-09-23', 'Dallas', 203),
(149, 'Henry Evans', 'IT', 'Cloud Architect', 115000.00, '2018-11-06', 'New York', NULL),
(150, 'Aria Edwards', 'Marketing', 'Email Marketing Specialist', 59000.00, '2022-07-29', 'San Francisco', 205);


-- verify RECORDS
SELECT COUNT(*) as total_rows FROM employee;

SELECT * FROM employee;
SQL Practice Questions (Employee Table)
-- BASIC

-- Q1. Retrieve the name and salary of all employees.
SELECT name, salary
FROM employee;

-- Q2. List all employees who belong to the IT department.
SELECT *
FROM employee
WHERE department = 'IT';

-- Q3. Show all employees sorted by salary from highest to lowest
SELECT *
FROM employee
ORDER BY salary DESC;

-- Q4. Get the top 5 highest paid employees

SELECT *
FROM employee
ORDER BY salary DESC
LIMIT 5;

-- Q5. Count how many employees are in each department
SELECT department, COUNT(*) as employee_count
FROM employee
GROUP BY department;

-- Q6. List all distinct cities where employees are located.
SELECT DISTINCT CITY 
FROM employee;

-- Q7. Find employees whose name starts with the letter 'A'
SELECT *
FROM employee
WHERE name LIKE 'A%';

-- Q8. Show employees in the marketing department who earn morethan 60,000.
SELECT *
FROM employee
WHERE department = 'Marketing'  AND salary > 60000;

-- Q9. Retrieve employees who work in either HR or Finance.
SELECT *
FROM employee
WHERE department IN ('HR','Finance');

SELECT *
FROM employee
WHERE department = 'HR' OR department = 'Finance';

-- Q10. List employees hired between 1st Jan 2020 and 31st Dec 2022.
SELECT *
FROM employee
WHERE hire_date BETWEEN '2020-01-01' AND '2022-12-31';

-- (Q11). Second highest salary

SELECT DISTINCT(salary) 
FROM employee
ORDER BY salary DESC
LIMIT 1
OFFSET 1


-- MEDIUM 
-- Q12. Find the maximum, minimum, and average salary across the entire company
SELECT max(salary) as max_salary, min(salary) as min_salary, ROUND(avg(salary),2) as avg_salary
FROM employee;

-- Q13. Show the total salary expenditure for each department
SELECT department, SUM(salary) as salary_expenditure
FROM employee
GROUP BY department;

-- Q14. Find all employees whose name contains 'son' anywhere
SELECT *
FROM employee
WHERE name LIKE '%son%';

-- Q15. Retrieve employees ranked 6th to 10th by salary(highest first)
SELECT *
FROM employee
ORDER BY salary DESC
LIMIT 5
OFFSET 5

-- Q16. Find departments where the average salary exceeds 70,000.
SELECT department, ROUND(avg(salary),2) as avg_salary
FROM employee
GROUP BY department
HAVING ROUND(avg(salary),2) > 70000;

-- Q17. Label each employee as 'High', 'Mid', or 'Entry' based on salary bands (>80000, 60000-80000, below 60000).
SELECT *, 
	CASE 
		WHEN salary > 80000 THEN 'High' 
		WHEN salary BETWEEN 60000 AND 80000 THEN 'Mid' 
		ELSE 'Entry' 
	END as emp_category
FROM employee;

-- Q18. List employees who are in New York or Austin AND earn at least 70,000.
SELECT *
FROM employee
WHERE city IN ('New York', 'Austin') AND salary >= 70000;

-- Q19. Find departments that have more than 3 employees, ordered by headcount descending.
SELECT department, COUNT(*) as emp_cnt
FROM employee
GROUP BY department
HAVING COUNT(*) > 3
ORDER BY emp_cnt DESC;


-- ADVANCED
-- Q20. Mark each employee as 'Manager' If they have no manager(manager_id is NULL), else 'Staff'
-- CASE WHEN IS USED TO LABEL(creates a new column)
SELECT *
FROM employee;

SELECT
	*,
	CASE
		WHEN manager_id IS NULL THEN 'Manager' ELSE 'Staff'
	END as role
FROM employee;


-- Q21. Find all employees in the 'IT' department earning between 70,000 and 90,000, Ordered by salary ascending
SELECT *
FROM employee
WHERE department = 'IT' 
	AND salary BETWEEN 70000 AND 90000
ORDER BY salary;


/*Q22. Find departments where the highest salary is above 85000 AND there are at least 2 employees. 
Show department, count, max salary */

SELECT department, max(salary) as max_salary, COUNT(*) as cnt_emp
FROM employee
GROUP BY department
HAVING max(salary) > 85000
	AND COUNT(*) >= 2;

/* Q23. Among employees hired after 2019, find cities where the total salary exceeds 150,000. 
Show city and total salary, ordered by total salary descending.  */

SELECT city, SUM(salary) as salary_city
FROM employee
WHERE YEAR(hire_date) > 2019
GROUP BY city
HAVING SUM(salary) > 150000
ORDER BY salary_city DESC;

/* (Q24). For each department, show the number of employees and average salary - 
but only for departments where at least one employee earns below 65,000.
Order by average salary descending. */

-- Option 1 (better)
SELECT department, COUNT(*) as cnt_emp, ROUND(AVG(salary),2) as avg_sal
FROM employee
GROUP BY department
HAVING min(salary) < 65000
ORDER BY avg_sal DESC;


-- Option 2
SELECT department, COUNT(*) as cnt_emp, SUM(dep_criteria) AS sum_emp, ROUND(AVG(salary),2) as avg_sal FROM (
SELECT *,
	CASE 
		WHEN salary < 65000 THEN 1 ELSE 0
	END as dep_criteria
FROM employee) t
GROUP BY department
HAVING SUM(dep_criteria) >= 2
ORDER BY avg_sal DESC;

-- Extra (Interview Level)
-- (Q25.) Find the second highest salary

-- 1. Option 1
SELECT DISTINCT(salary)
FROM employee
ORDER BY salary DESC
LIMIT 1
OFFSET 1;


-- (Q26.) Find employees who earn more than the average salary of their department

(SELECT department, ROUND(avg(salary),2) as avg_sal 
FROM employee 
GROUP BY department)


-- (Q27.) Find employees who report to the highest paid manager







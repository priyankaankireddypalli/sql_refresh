-- Problems on Joins

-- Employees Table
CREATE TABLE emp (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    hire_date DATE,
    manager_id INT,
    job_title VARCHAR(50)
);

-- Departments Table
CREATE TABLE dept (
    dept_id INT,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


INSERT INTO emp (emp_id, emp_name, dept_id, salary, hire_date, manager_id, job_title) VALUES
(101, 'Alice',   10, 80000, '2020-01-15', NULL, 'CEO'),
(102, 'Bob',     20, 65000, '2021-03-10', 101, 'Developer'),
(103, 'Charlie', 20, 70000, '2019-07-22', 101, 'Team Lead'),
(104, 'David',   30, 60000, '2022-05-01', 103, 'Accountant'),
(105, 'Eva',     10, 55000, '2023-02-14', 101, 'HR Executive'),
(106, 'Frank',   40, 75000, '2018-09-18', 101, 'Sales Manager'),
(107, 'Grace',   20, 62000, '2022-08-09', 103, 'Developer'),
(108, 'Henry',   30, 58000, '2021-11-30', 104, 'Financial Analyst'),
(109, 'Ivy',     NULL, 50000, '2024-01-05', NULL, 'Intern'),
(110, 'Jack',    50, 72000, '2020-06-12', 101, 'Marketing Manager'),
(111, 'Karen',   40, 54000, '2023-09-01', 106, 'Sales Executive'),
(112, 'Leo',     20, 68000, '2019-12-20', 103, 'QA Engineer');


INSERT INTO dept (dept_id, dept_name, location) VALUES
(10, 'Human Resources', 'New York'),
(20, 'Information Technology', 'Chicago'),
(30, 'Finance', 'Boston'),
(40, 'Sales', 'Dallas'),
(50, 'Marketing', 'Seattle'),
(60, 'Legal', 'Washington');

-- Verify
SELECT * FROM emp;
SELECT * FROM dept;

-- common column (dept_id)

-- Q1. Get employee names with their department names

SELECT e.emp_name, e.dept_id, d.dept_name
FROM emp e
INNER JOIN dept d
ON e.dept_id = d.dept_id

SELECT e.emp_name, e.dept_id, d.dept_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id


-- Q2. List all employees even if they dont belong to any department
SELECT e.emp_name, e.dept_id, d.dept_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id


-- Q3. Show all departments even if no employees are working
SELECT distinct(d.dept_id), d.dept_name
FROM emp e
RIGHT JOIN dept d
ON e.dept_id = d.dept_id;

-- Data Engineers usually use left join, inner join and self join only.

-- Q4. Find employees who are not assigned to any department

SELECT emp_id, emp_name
FROM emp 
WHERE dept_id IS NULL;


-- Q5. Count number of employees in each department 
SELECT dept_id, count(emp_id) as cnt
FROM emp
GROUP BY dept_id

-- ( We need to use JOIN because we might miss some departments in the table) 

SELECT d.dept_id, COUNT(emp_id) as cnt
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id;

SELECT * FROM dept

-- Q6. Show department name and total salary of employees in each department
-- CORRECT
SELECT d.dept_name, SUM(salary) as total_salary
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name

SELECT d.dept_name, SUM(salary) as total_salary
FROM dept d
INNER JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name

-- Q7. show departments with more than 1 employee

SELECT d.dept_id, COUNT(e.emp_id) as cnt
FROM dept d
INNER JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id
HAVING COUNT(e.emp_id) > 1;

-- Q8.Show employees and their managers

SELECT * FROM emp
SELECT * FROM emp

SELECT e.emp_id, e.emp_name, m.emp_id as manager_id, m.emp_name as manager_name
FROM emp e
LEFT JOIN emp m
ON e.manager_id = m.emp_id

-- Q9. Show department with the highest total salary

SELECT TOP 1 d.dept_id, d.dept_name, SUM(e.salary) as total_salary
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC

SELECT d.dept_id, d.dept_name, SUM(e.salary) as total_salary
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC
LIMIT 1


SELECT TOP 1 d.dept_id, d.dept_name, sum(e.salary) as total_salary
FROM dept d
JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC

-- Q10. Find Employees whose salary is greater than the average salary of their department
-- Corelated subquery executes for each record from outer query, executes the subquery every time.
SELECT e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.salary
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id
WHERE e.salary > (SELECT AVG(salary) FROM emp WHERE dept_id=e.dept_id)

SELECT e.emp_id,
       e.emp_name,
       d.dept_name,
       e.salary
FROM emp e
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM emp
    GROUP BY dept_id
) a
ON e.dept_id = a.dept_id
LEFT JOIN dept d
ON e.dept_id = d.dept_id
WHERE e.salary > a.avg_salary;


-- Q11. Show department names and average salary of employees.
SELECT d.dept_id, AVG(e.salary) as avg_sal
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id;

-- Q12. show employees with their department names, including those with NULL dept_id
SELECT e.emp_id, e.emp_name, d.dept_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id;

-- Q13. show managers and the employees reporting to them
SELECT m.emp_name as manager, e.emp_name as employee
FROM emp m
JOIN emp e
ON m.emp_id = e.manager_id


-- Q14. show employees hired after 2016 with their department
SELECT e.emp_id, e.emp_name, d.dept_id, d.dept_name, e.hire_date
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id AND YEAR(hire_date) > 2016;

-- Q15. show employees and their department locations
SELECT e.emp_name, d.dept_name, d.location
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id

-- Q16. show employees with salary greater than 70000 and their department
SELECT e.emp_name, d.dept_name, e.salary
FROM emp e
LEFT JOIN dept d
ON e.dept_id = e.dept_id
WHERE e.salary > 70000;

-- Q17. show employees and their job titles with department names

SELECT e.emp_name, e.job_title, d.dept_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id

-- Q18. show employees whose salary is less than 50000 or no department assigned

SELECT e.emp_name, e.salary, d.dept_id, d.dept_name
FROM emp e
LEFT JOIN dept d
ON e.dept_id = d.dept_id 
WHERE e.salary < 50000 OR d.dept_id IS NULL

SELECT * FROM emp
-- Q19. show employees who work in the same department

SELECT e.emp_name as employee, c.emp_name as colleague, e.dept_id, d.dept_name
FROM emp e
JOIN emp c
ON e.dept_id = c.dept_id AND e.emp_id < c.emp_id
INNER JOIN dept d
ON e.dept_id = d.dept_id
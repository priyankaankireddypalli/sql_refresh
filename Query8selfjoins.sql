/* Self Joins */

SELECT * FROM emp;

-- (Q1). Find all employees who work in the same department as their managers.

SELECT e.emp_id, e.emp_name, e.dept_id, m.emp_id as manager_id, m.emp_name as manager_name, m.dept_id as manager_dept
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id AND e.dept_id = m.dept_id

SELECT e.emp_id, e.emp_name, e.dept_id, m.emp_id as manager_id, m.emp_name as manager_name, m.dept_id as manager_dept
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id 
WHERE e.dept_id = m.dept_id

-- (Q2). Find employees whose salary is greater than their manager's salary.

SELECT *
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id AND e.salary > m.salary;

SELECT *
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id 
WHERE e.salary > m.salary;


-- (Q3). Display each employee with their manager and show their difference
SELECT *, (e.salary - m.salary) as diff_sal
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id;

-- (Q4). Find employees who share the same manager (difficult)
SELECT
    e1.manager_id,
    e1.emp_name AS employee1,
    e2.emp_name AS employee2
FROM emp e1
JOIN emp e2
    ON e1.manager_id = e2.manager_id
   AND e1.emp_id < e2.emp_id;

-- (Q5). Find employees who are managers(i.e., they manage at least one employee)

SELECT e.manager_id
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id
GROUP BY e.manager_id
HAVING count(*) >= 1

-- (Q6). Find employees who are at the same level(same manager_id) but belong to different departments.

SELECT
    e1.manager_id,
    e1.emp_name AS employee1,
    e1.job_title AS employee1_job_tite,
    e2.emp_name AS employee2,
    e2.job_title AS employee1_job_tite
FROM emp e1
JOIN emp e2
    ON e1.manager_id = e2.manager_id
    AND e1.emp_id < e2.emp_id
    AND e1.job_title <> e2.job_title;
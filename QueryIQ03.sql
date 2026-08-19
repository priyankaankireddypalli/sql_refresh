-- Employees who earn more than their managers

%sql
SELECT *
FROM emp e
JOIN emp m
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary

-- SECOND HIGHEST SALARY

-- Correlated subquery to find the second highest salary from the employee table.
SELECT distinct salary
FROM employee e1
WHERE 1 = (
    SELECT COUNT(DISTINCT e2.salary)
    FROM employee e2
    WHERE e2.salary > e1.salary
)
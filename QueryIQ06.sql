-- DELETE DUPLICATES RECORDS FROM THE TABLE

DELETE FROM employee
WHERE id IN (
    SELECT id
    FROM (
        SELECT
            id,
            ROW_NUMBER() OVER (
                PARTITION BY name, salary
                ORDER BY id
            ) AS rn
        FROM employee
    ) t
    WHERE rn > 1
);
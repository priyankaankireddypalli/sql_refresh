/* UNION VS UNION ALL:

To merge or combine data - we use joins
To append or stack data - we use union vs union all.

Union - Will remove duplicates, considers master data.
Union ALL - considers duplicates

Note: ORDER OF COLUMNS SHOULD BE SAME and COMPATIBLE DATA TYPES.

APPLICATION: Used to manage the historical data in one table.
Another example: App users, Web users.

Performance better?: UNION ALL is better due to faster execution, computation, less memory 
because UNION will need to identify duplicates and then append which is time consuming.
*/
-- ex:

SELECT USER_ID, name
FROM users
UNION 
SELECT USER_ID, name
FROM users
ORDER BY user_id

SELECT USER_ID, name
FROM users
UNION ALL
SELECT USER_ID, name
FROM users
ORDER BY user_id




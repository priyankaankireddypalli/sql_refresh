Data Engineer

1. Why Data? To drive business decisions.
2. Understand metadata - columns, rows, data type, formatting, data size
3. 1. Extract data from sources 
   2. Data cleaning - duplicates, space and date formatting
   3. Transformations
   4. Analysis - descriptive, predictive, diagnosis
   5. Final dataset - derive KPI's using metrics


SQL and data fundamentals
1. A day in the life of a Data Engineer - SQL is the language a Data Engineer uses ALL DAY!
2. Database VS Data Warehouse -
   1. DATABASE - Daily transactions, OLTP, Fast writes (GB's - current data only), CRUD operations
   2. DATA WAREHOUSE - Historical data, OLAP, Fast reads (TB's or PB's - years of data), SELECT, JOINS, GROUP BY & ANALYZE
3. OLTP Feeds data to OLAP via ETL
4. DBMS VS RDBMS
   1. DBMS - structured, semi-structured, unstructured data
   2. RDBMS - structured data (Tables) can do joins.
   3. NOTE: Every RDBMS is DBMS, but NOT every DBMS is RDBMS
5. Learn SQL once, use it in ANY of the databases!


BASICS
1. Table - rows and columns
2. Clauses - SELECT (retrieve's columns)

Example - Employee table
SELECT department_id, sum(salary) -- specific columns
FROM Employee   -- table name
-- WHERE employee_id = 105 -- row level filtering from main table
GROUP BY department_id - grouping data
HAVING sum(salary) > 500000 - filtering sumarized data


SELECT department_id, sum(salary) -- specific columns
FROM Employee   -- table name
-- WHERE employee_id = 105 -- row level filtering from main table
GROUP BY department_id - grouping data
ORDER BY department_id, sum(salary) DESC -- sorts the data by asc(default) or desc 
LIMIT 5 - result of number of rows
OFFSET 3 - skips 3 rows


AGGREGATION FUNCTIONS - MAX, MIN, SUM, AVG, COUNT

Q. WHERE VS HAVING
WHERE - filtering individual row level data, executed before GROUP BY 
HAVING - filtering sumarising data, executed after GROUP BY

LIKE - pattern matching 
Q. name starting with R - name LIKE R%
Q. name ending with a - name LIKE %a
Q. third letter i - name LIKE __i% (underscore - one character can be any)

DISTINCT - avoid duplicates 

Q. Second highest salary
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1
OFFSET 1

Q. Second highest salary - using subquery method
SELECT MAX(salary)
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)

From above method - no extra memory but execution time is more
INNER QUERY EXECUTES FIRST - Prcoessing data is more (if you want 10th highest salary - 10 times inner query should executes for all the records in the table)


EXECUTION ORDER
1. FROM
2. JOIN
3. WHERE
4. GROUP BY
5. HAVING
6. SELECT
7. ORDER BY
8. LIMIT
9. OFFSET

-------------------------------------------------
Why Data? To make business driven decisions based on analysis
- products tracking
- services
- money tracking
- customer satisfaction 


Roles - data analysis with respective to domain
Data Engineer

Data analyst
business analyst
Product owner
Finance analyst

Tech stack
- SQL
- Python 
- PySpark
- Databricks
- Cloud (Azure)

Tables - data will be maintained in different tables to maintain data redundancy, data integrity

1. Data extraction
2. Data cleaning - Duplicates, date formating, space formating
3. Transformation 
4. Analysis


Understand metadata
1. no of columns
2. no of rows
3. column data type
4. column data type formatting
5. data set size


Analysis
1. descriptive analysis
2. predictive analysis


final datasets are given to power bi or tableau (Creating visualizations)

final columns are called as metrics (From metric we take KPI's)
Example: banking applications 
total application / successful applications 

approval KPI - Valid customers?

adhoc requests fullfilling

why sql? can use sql queries to handle millions of records processed from databases or files.









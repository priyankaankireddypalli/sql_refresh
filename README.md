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

JOINS
Why joins? In real world, data will be not be present in single table. It will be present in more than one tables. why?
To avoid ambiguity, data inconsitency for ex: when deleting a row, could result in loss of data and data is incorrect. 
So data is represented in multiple tables. 

INTERVIEW QUESTIONS
1. Show employees and their managers
SELECT e.emp_id, e.emp_name, m.emp_id as manager_id, m.emp_name as manager_name
FROM emp e
LEFT JOIN emp m
ON e.manager_id = m.emp_id
2. show managers and the employees reporting to them

SELECT m.emp_name as manager, e.emp_name as employee
FROM emp m
JOIN emp e
ON m.emp_id = e.manager_id


3. Show department with the highest total salary
SELECT d.dept_id, d.dept_name, SUM(e.salary) as total_salary
FROM dept d
LEFT JOIN emp e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC
LIMIT 1

4. Find Employees whose salary is greater than the average salary of their department

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


5. Show employees who work in the same department

SELECT e.emp_name as employee, c.emp_name as colleague, e.dept_id, d.dept_name
FROM emp e
JOIN emp c
ON e.dept_id = c.dept_id AND e.emp_id < c.emp_id
INNER JOIN dept d
ON e.dept_id = d.dept_id

SUBQUERIES
A query within a query is called a subquery

INNER QUERY gets executed first and the resuts from inner query is used by outer query to produce desired results.

Ex: Second highest salary

SELECT MAX(salary) FROM emp 
WHERE salary < (SELECT MAX(salary) from emp)

OR

SELECT DISTINCT(salary)
FROM emp
ORDER BY salary DESC
LIMIT 1
OFFSET 1

DRAWBACK: Whenever we use order by, limit, offset used in backend, the entire dataset is stored in a memory/RAM as a copy other than original.
Ex: we have emp 10M records, same 10M records is copied to memory and we derive the result.
So, high memory consuming, to copy it would take more time and also to execute it takes more execution time

Overcome: subqueries
What are subqueries?
A subquery is simply a SELECT statement written inside another SELECT statement
1. Outer query = the main query you run
2. inner query = the SELECT statement written inside it
3. SQL evaluates the inner query first, then uses its result to finish the outer query.


Types of subquery
1. correlated subqueries
2. non correlated subqueries

1. scalar subquery: returns one row from inner query. Based on that row im deciding the output of outer query. Also, final output is one row also.

-- WINDOW FUNCTIONS
-- Will perform the required operation on spefied window of rows and keep the original data intact.
/* Why use window functions?

emp_id	emp_name	dept_id	salary
1		sai		IT		10k
2		hari	IT		10k
3		giri	HR		30k
4		babu	HR		40k
5		vandan	Finance	60k

-- Find department wise average

SELECT dept_id, AVG(salary) as avg_sal
FROM emp
GROUP BY dept_id

Output:
dept_id	 avg_sal
IT		 10k
HR		 35k
Finance	 60k

The difference between the original table and output table is that the rows are collapsed or grouped or shrink.
Data is missed at row level and higher level aggregated data is given.

I need my original data as it is and find the aggregate or calculations - 
Without losing the original data, i can compute required calculations.

emp_id	emp_name	dept_id	salary	avg_sal
1		sai		IT		10k			10k
2		hari	IT		10k			10k
3		giri	HR		30k			35k
4		babu	HR		40k			35k
5		vandan	Finance	60k			60k


APPLICATIONS: I have a table with day to day sales and i would like to compute cummulative sales as well.

OVER: to define window you need OVER to specify which set of rows you would like to operate
PARTITION BY: works like GROUP BY

SYNTAX:
SELECT *, 
	AVG(salary) OVER ( PARTITION BY dept_id ORDER BY salary DESC)
FROM emp

Types of window functions
A. AGGREGATE WINDOW FUNCTIONS
1. AVG
2. SUM
3. MAX
4. MIN
5. COUNT

SUM example output:
emp_id	emp_name	dept_id	salary	sum_sal
1		sai		IT		10k			20k
2		hari	IT		10k			20k
3		giri	HR		30k			70k
4		babu	HR		40k			70k
5		vandan	Finance	60k			60k

MAX example output:
emp_id	emp_name	dept_id	salary	max_sal		count_no
1		sai		IT		10k			10k			2
2		hari	IT		10k			10k			2
3		giri	HR		30k			40k			2
4		babu	HR		40k			40k			2
5		vandan	Finance	60k			60k			1


B. Ranking Window Functions
1. ROW_NUMBER()
2. RANK()
3. DENSE RANK()

EX: SECOND HIGHEST SALARY

SELECT distinct(salary)
FROM emp
ORDER BY salary DESC
LIMIT 1
OFFSET 1

DRAWBACK: ORDER BY ,LIMIT and OFFSET will use additional memory by copying that data in memory,
takes time for allocation and 
as a result increases execution time - which is not ideal for production environment.
Inorder to solve these problems, we can use subqueries.


a. additional memory, allocating to memory takes more time or time consuming, High execution time
-- Sub Query
SELECT MAX(salary) FROM emp
WHERE salary < (SELECT MAX(salary FROM emp)

Lets consider if we 10M records in the table, 
For second highest salary - we are computing two times table scan (10M * 2) = 20M
For 10th highest salary - we are computing ten times table scan (10M  * 20M) = 100M
Processing time is more
Resources not utilised properly i.e., 
computation power is high
memory is increased
execution time is high


Solution: Window Functions

ROW NUMBER - Irrespective of data, either duplicates, null values or anything - it does not consider anything will asign a row rank.
RANK - If duplicates or tie, then it assigns the same rank, but will skip the rank after the ties
DENSE RANK - If duplicates or tie will assign the same rank, but wont skip rank after the ties

ORDER BY DESC - Assigning the ranks based on that.
| Salary | ROW_NUMBER | RANK | DENSE_RANK |
| -----: | ---------: | ---: | ---------: |
|    100 |          1 |    1 |          1 |
|     90 |          2 |    2 |          2 |
|     90 |          3 |    2 |          2 |
|     80 |          4 |    4 |          3 |
|     70 |          5 |    5 |          4 |


EXAMPLE 2;
SELECT salary, 
	RANK() OVER (ORDER BY sal DESC) as rnk,
	DENSE_RANK() OVER (ORDER BY sal DESC) as drnk,
	ROW_NUMBER() OVER (ORDER BY sal DESC) as rn
FROM emp

		RANKING WINDOW FUNCTIONS					
sal	dept		sal	dept	row_number	dense_rank	rank
50k	IT			100kIT			1			1		1	
50k	IT			70k	HR			2			2		2
60k	IT			60k	IT			3			3		3
70k	HR			50k	IT			4			4		4
10k	HR			50k	IT			5			4		4
20k	HR			20k	HR			6			5		6
5k	IT			10k	HR			7			6		7
100k	IT		5k	IT			8			7		8

EXAMPLE 3;
SELECT salary, 
	RANK() OVER (PARTITION BY dept ORDER BY sal DESC) as rnk,
	DENSE_RANK() OVER (PARTITION BY dept ORDER BY sal DESC) as drnk,
	ROW_NUMBER() OVER (PARTITION BY dept ORDER BY sal DESC) as rn
FROM emp

		RANKING WINDOW FUNCTIONS					
sal	dept		sal	dept	row_number	dense_rank	rank
50k	IT			100kIT			1			1		1	
50k	IT			60k	IT			2			2		2
60k	IT			50k	IT			3			3		3
70k	HR			50k	IT			4			3		3
10k	HR			5k	IT 			5			4		5
20k	HR			70k	HR			1			1		1
5k	IT			20k	HR			2			2		2
100k	IT		10k	HR			3			3		3


USE CASES for row number: 
1. Pagination
2. Removing duplicates: all columns need to be specified. (identify and delete duplicates)
3. First or latest value
4. To assign sequence number

USE CASES for DENSE RANK:
1. Clustering same group without skipping after ties - gaps are not accepted.
2. TOP N

USE CASES for RANK
1. Clustering - ranks where gaps are accepted.


C. VALUE WINDOW FUNCTIONS
1.LAG() - previous value
2. LEAD() - next value

USE CASES:
1. MOM - month over month (CURRENT_MONTH - PREVIOUS_MONTH) / PREVIOUS_MONTH
2. YOY - year over year
3. WOW - week over week

sales	   lag	   lead
50k		NULL  50k
50k		50k	60k
60k		50k	70k
70k		60k	10k
10k		70k	20k
20k		10k	5k
5k		   20k	100k
100k	   5k	   NULL


1. ROWS BETWEEN
2. UNBOUNDED PRECEDING
3. UNBOUNDED FOLLOWING
4. N PRECEEDING N FOLLOWING


Example: 
sales_id	txn		rolling_sum
1			1k		1k	
2			2k		3K
3			3k		6k
4			4k		10k

QUERY WRITTEN FOR ROLLING SUM: NO PARTITION BUT SHOULD USE ORDER BY 

SELECT *,
SUM(txn) OVER (ORDER BY sales_id) as rolling_sum
FROM sales

options available 1. rows between and range
1. ROLLING SUM
SELECT *,
	SUM(txn) OVER(ORDER BY sales_id ROWS BETWEEN UNBOUNDED PRECEEDING AND CURRENT ROW) as val
FROM sales


Example: 
sales_id	txn		val
1			1k		1k	
2			2k		3k
3			3k		6k
4			4k		10k

EXAMPLE 2:
2. OVERALL SUM

SELECT *,
	SUM(txn) OVER(ORDER BY sales_id ROWS BETWEEN UNBOUNDED PRECEEDING AND UNBOUNDED FOLLOWING) as val
FROM sales
sales_id	txn		val
1			1k		10k	
2			2k		10k
3			3k		10k
4			4k		10k

EXAMPLE 3.
3.MOVIMG AVERAGE

SELECT *,
	SUM(txn) OVER(ORDER BY sales_id ROWS BETWEEN 1 PRECEEDING AND 1 FOLLOWING) as val
FROM sales
sales_id	txn		val
1			1k		3k	
2			2k		6k
3			3k		9k
4			4k		7k

Example

LAST SEVEN DATES sales
SELECT *,
	SUM(txn) OVER(ORDER BY sales_id ROWS BETWEEN 6 PRECEEDING AND CURRENT ROW) as val
FROM sales
sales_date	sales_id	txn  val
01-01-2026	1			1k   1k
02-01-2026	2			2k	 3k
03-01-2026	3			3k	 6k
04-01-2026	4			4k	 10k
05-01-2026	5			5k	 15k
06-01-2026	6			6k	 21k
07-01-2026	7			7k	 28k
08-01-2026	8			8k	 8k



Example: 
UNDERSTAND BETWEEN ROWS BETWEEN VS RANGE BETWEEN 
Difference and how it works?

Ntile: Used to group the entire data into specified no of groups
Uses round robbin fashion to allocate values to group

total transactions - 30 sale id's
GROUP WISE BY Category

SELECT category, revenue, NTILE(3) OVER(PARTITION BY category ORDER BY revenue) as classifications FROM ecom_sales;

DATE FUNCTIONS

1. YEAR(DATE_COLUMN) - returns year
2. MONTH(DATE_COLUMN) - returns month
3. DAY(DATE_COLUMN) - returns day
4. DAYNAME (Oracle)
5. MONTHNAME (Oracle)
6. GETDATE() or CURRENT_TIMESTAMP - returns date and time (current day, time value)
7. DATE_ADD(DATE_COLUM, INTERVAL 5 DAY) as column_name - adds 5 days
8. DATE_SUB(DATE_COLUMN, INTERVAL 5 DAY) as column_name - sub 5 days
9. DATE_DIFF(DATE_COLUMN_1, DATE_COLUMN_2) as column_name - difference of two dates.
10. DATE_FORMAT(DATE_COLUMN, '%d-%m-%Y') - order should be same as in date column, dd-mm-yy == %d-%m-%Y
10. CURRENT_DATE() : returns only date


-- 1. GETDATE() or CURRENT_TIMESTAMP

SELECT GETDATE() as now
-- 2. CURDATE() or CURRENT_DATE: not support my SQL server

SELECT CAST(GETDATE() as DATE) as today_date

-- 3. CURTIME(): SQL server does not support SQL server
SELECT CAST(GETDATE() as TIME) as now_time

-- 4. DATEPART (EXTRACT NOT SUPPORTED IN SQL SEVER)
SELECT DATEPART(YEAR, '2026-01-01')
SELECT DATEPART(MONTH, '2026-01-01')
SELECT DATEPART(DAY, '2026-01-01')
SELECT DATEPART(HOUR, '2026-01-01')
SELECT DATEPART(MINUTE, '2026-01-01')
SELECT DATEPART(SECOND, '2026-01-01')


-- 5. YEAR()
-- 6. MONTH()
-- 7. DAY()
-- 8. HOUR()
-- 9. MINUTE()
-- 10. SECOND()
-- 11. DATEDIFF(datepart, date1, date2)
SELECT DATEDIFF(DAY,GETDATE(),'2021-01-12') as diff

-- 12. DATEADD(datepart,value, date)
SELECT DATEADD(DAY, 14, '2026-07-27') AS addition;
SELECT DATEADD(DAY, -10, '2026-07-27');
-- 13. DATE_SUB(): does not support it: use dateadd only
SELECT DATEADD(DAY, -5, '2026-07-27') AS new_date;
-- 14. TIMESTAMPDIFF(): does not support in SQL server
SELECT DATEDIFF(
    DAY,
    '2026-07-01',
    '2026-07-27'
);

SELECT DATEDIFF(
    HOUR,
    '2026-07-27 10:00:00',
    '2026-07-27 15:30:00'
);
-- 15. DATE_FORMAT() : not supported here in sql server 
SELECT DATE_FORMAT('2026-10-12','%d-%m-%Y')
-- FORMAT(date,format)
SELECT FORMAT(GETDATE(), 'MMMM yyyy');

-- 16. STR_TO_DATE(): not supported in sql server
SELECT STR_TO_DATE('27-07-2026', '%d-%m-%Y') AS new_date;

SELECT CAST('2026-07-27' AS DATE);


-- 17.LAST_DAY(): Not used in SQL server
SELECT LAST_DAY('2026-07-27') AS last_day;
SELECT EOMONTH('2026-07-27') AS last_day;


-- 18. QUARTER(): not used in sql server
SELECT QUARTER('2026-07-27') AS quarter_no;

SELECT DATEPART(QUARTER, '2026-07-27') AS quarter_no;
19. WEEK(): week no in the year
SELECT DATEPART(WEEK, '2026-05-01') AS week_no;


20. DAYNAME()
SELECT DATENAME(DAY, '2026-07-27') AS week_day;
21. MONTHNAME()
SELECT DATENAME(MONTH, '2026-07-27') AS month_name;
22. DAYOFMONTH()
SELECT DAY('2026-07-27')
23. DAYOFWEEK()
SELECT DATEPART(WEEKDAY, '2026-07-27')

24. DAYOFYEAR()
SELECT DATEPART(DAYOFYEAR, '2026-07-27')



-- TEXT FUNCTIONS

-- 1. UPPER() - 
SELECT UPPER('Priya')
-- 2. LOWER()
SELECT LOWER('Priya')
-- 3. CONCAT()
SELECT CONCAT('Priya','Ankireddy')
-- 4. CONCAT_WS() concat with separator
SELECT CONCAT_WS('_','Priyanka','ANkireddy','Lohith')
-- 5. SUBSTRING() - part of the string
SELECT SUBSTRING('data engineering',6,3)
-- 6. SUBSTRING_INDEX() - delimiter (not supported)
SELECT SUBSTRING_INDEX('DATA ENGINEERING',' ', 1)
SELECT SUBSTRING_INDEX('DATA ENGINEERING', ' ', 1);
SELECT SUBSTRING_INDEX('DATA ENGINEERING', ' ', -1);
-- 7. LEN() : LENGTH OF A STRING
SELECT LEN('PRIYA')
--8. LEFT()
SELECT LEFT('Priyanka Ankireddy',CHARINDEX(' ','Priyanka Ankireddy'))
--9. RIGHT()
SELECT RIGHT('Priyanka Ankireddy',5)
-- 10. CHARINDEX
SELECT CHARINDEX('P', 'Priyanka Ankireddy')
-- 11. TRIM, LTRIM, RTRIM
SELECT LTRIM('   Priya    ')

-- 12. REPLACE()
SELECT REPLACE('DATA','a','m')

-- 13. INSTRING: instead is taken from char index

SELECT INSTR('DATA ANALYTICS', 'ANALYTICS')

-- 14. REVERSE(): Reverse a given string
SELECT REVERSE('Priya')


-- 15. LPAD: to add leading char
SELECT LPAD('123', 5, '0');
-- 00123
-- SQL supports this LEFT(str + REPLICATE(pad, len), len)

--16. RPAD: to add char right
SELECT RIGHT(REPLICATE('0', 5) + '123', 5) AS result;

--17. LEFT - fetch n no of char
SELECT LEFT('Priya',2)

-- 18. RIGHT
SELECT RIGHT('Priya',2)


-- 19. STRCMP: not available in sql server
SELECT STRCMP('Priya','Priya')


	COMMON TABLE EXPRESSION (CTE) - Temporary table

	DIFFERENCE BETWEEN subqueries and cte. 
	ex: 10th highest salary, we need to write it 10 times. 
	Which makes the code messier and understanding is also difficult.
	Easy to debug. 
	It is used when we have a complex problem, we breakdown and write multiple cte's. Which makes code easir to understand and debug.
	supports reccursion concept.


	ADVANTAGES					
	1. Readability				
	2. reusable
	3. Reccursion
	4. Debugging


	Feature					CTE			Subquery
	Readability				HIGH		   Low
	Reusability				Yes			No
	Debugging				Easy	   	Hard	
	Reccursive support	Yes			No
	complex handling		Better		Messy



   -- VIEWS (VIRTUAL TABLES) - Virtual tables views are stored in db.

-- CTE (Temporary Tables) - Table exists only until the query is executed. It is not stored permanently.

/*
VIEWS are of two types
1. Normal View
2. Materilaised View (not supported in MySQL)


SYNTAX:

CREATE VIEW viewname AS (
SELECT *
FROM employees
)

I can use this viewname to get the details.
USE OF IT? 
1. View is reusable and can be used any number of times
2. NOTE: NExt day, if there is any insert,update,delete in the table the view is pointing, we retrieve the updated data only.

SELECT * FROM viewname;


In materialised view: In that particular time what data was present, only that data is retrieved.
NExt day, when you execute this view, it will show the data created on the day of view nut not the updated data.
To show the updated data, use referesh the materialised view.



CREATE MATERIALIZED VIEW viewname AS (

	SELECT *
	FROM 


)

refresh viewname


Difference between cte and views
cte's exist only until the query is executed
Wheras views are stored permanently.

*/



/*

ACID PROPERTIES: SET OF RULES followed by databases to keep data safe and correct during transactions. 
A - Atomic 
C - Consistency
I - Isolation
D - Durability

ACID property comes into picture whenever there is an transaction.
What is transaction?

Collection of operations 

Example: lets say in my account i have 2000
and Lohith has 1000

Priya - 2000
Lohith - 1000

Give 1000 to Lohith

Debit from my account and then credit it to Lohith account (1000) or it should failover.

The money got debited from my account and later there was an issue with the system and money dint get credited to Lohith account.
So, ACID properties handled that situation. (Get refund to Priya account)


Whenever you make a payment, the original values is stored in transactional logs before updating.

transactional logs original values before updating
Priya - 2000
Lohith - 1000

UPDATE accounts
SET accountA = 2000-1000

UPDATE accounts
SET accountB = 1000+1000

COMMIT (permanently changes)
Transactional logs:
Priya - 1000
Lohith - 2000


If in case, system crashes after debiting money
1. DB restarts and checks logs
2. since transaction failed, it will perform rollback. (original amount will be shown)

ATOMICITY - All happened or nothing
All transactions must be succesfull or when failed to roll back.

ATOMICITY

1. user clicks PAY
         
2. START TRANSACTION

3. STORE OLD VALUES IN LOGS (Priya=2000,Lohith = 1000)

4. Deduct 1000 from Priya (2000 -> 1000)

5. System Crashes (Before Lohith recieves money)

6. Database restarts

7. Checks LOGS

8. COMMIT NOT FOUND

9. ROLLBACK HAPPENS

10. Restore OLD VALUES(Priya = 2000, Lohith = 1000)


CONSISTENCY - Data must remain before or after the transaction.

CONSISTENCY

1. User SENDs 7000
         
2. START TRANSACTION

3. Database checks rules

4. 5000-7000 = -2000

5. RULE BROKEN(Balance < 0)

6. Database rejects transaction

7. rollback

8. Data Remains SAME


ISOLATION - Each transaction is treated differently, and no interference.

ISOLATION	
	
1. User clicks Book ticket	
         	
2. START TRANSACTION	
	
3. LOCK SEAT ROW	
	
4. Store old value in indo log	
	
5. temporary update	
	
6. paymen process	
	
7. SUCCESS?	
	
YES					No
	
COMMIT				ROLLBACK
	
PERMANENT SAVE		OLD VALUE


DURABILITY - Even if there is a system failure, data is stored permanently

1. User SENDS 1000
         
2. TRANSACTION START

3. DATABASE UPDATES DAYA

4, DATABASE WRITES COMMIT LOGO TO DISK

5. COMMIT SUCCESS

6. SUCCESS MESSAGE SHOWN

7. POWER FAILURE OCCURS

8. DATABASE READS DISK LOGS

9. RESTORE COMMITTED DATA


EXAMPLE ALL IN ONE 
1. user clicks PAY
         
2. START TRANSACTION

3. LOCK ROWS (ISOLATION)

4. STORE OLD VALUES IN LOGD(ATOMICITY)

5. UPDATE DATA

6. CHECK CONSTRAINTS(Consistency)

7. WRITE COMMIT TO DISK(Durability)

8. COMMIT

9. RELEASE LOCKS

10. SUCCESS


-- STORED PROCEDURES:

/* SQL QUERIES - To perform the same operation multiple times, we create a procedure and execute it. */

-- INTERVIEW QUESTION
Q1. DIFFERENCE BETWEEN STORED PROCEDURE AND FUCNTIONS

STORED PROCEDURE - returns result set, performs business operations
FUNCTIONS - return a value, calculation

Q2. DIFFERENCE BETWEEN VIEW AND STORED PROCEDURE

VIEW - reporting the required data (A virtual table), select
Stored procedure - performing business operations, we use insert, update, delete and select

Q3.DIFFERENCE BETWEEN DELETE AND TRUNCATE
DELETE - 
- We can use where clause
- Used to delete the data and structure remains same
- Delete is slow
- We can perform roll back on delete
- In delete, it does not reset identity (we delete 3 records, 4 th record will have 4(auto_increment))
TRUNCATE
- We cannot use where clause
- Used to delete the data and structure remains same
- Truncate is faster than Delete
- Roll back is not possible in truncate
- Resets identity (assign id 1 from begining all the time)


SPEED?
DROP>TRUNCATE>DELETE

CONSTRAINT - auto_increment (serial wise number is assigned)


/*
NORMALISATION
StudentId, StudentName, Phone, Courses
1			Priya				Python, SQL
2			Lohith				SQL
3			Reddy				Java


Storing entire data in one table will cause problems like 
1. data redudancy (data duplicates)
2. Insert anamolies (data errors) - ex: i would need to know other columns like students details also for just creating a new courses
3. Updating data to all rows for the same given person like phone number, if missed in any record can cause data inconsistent
4. Delete anamolies : i deleted id 3, I am losing courses information also
5. Storage issues

Why normalisation?
To prevent all above errors we create normalisations
Breaking down complex table into smaller logical tables. 
Data redudancy and data integrity
Creating students in a student table
Creating courses in a course table.

We have 6 normal forms
1NF
2NF
3NF
BCNF
4NF
5NF

1NF - In a table, None of the columns should contain multiple values. (atomic values)

If there is redudancy after applying 1NF, then we should apply 2NF.

2NF -
1. Table should be in 1NF
2. It should not contain partial dependencies (student_id + course_id becomes composite key to identify the unique record) Student Name depends on student_id but not on both the keys
If column does not depened on entire key(student_id, course_id), it is called partial dependency
We need to remove partial dependecies

we create students table - studentid, studentname, phone
enrollments table - studentid, course

Now i have added duration to enrollments table
Enrollments - studentid, course, duration
Is it normalised? No data gets repeated 

3NF - Table should be in 2NF and no transitive dependencies
Transitive depends - A depends on B, B depends on C, so A depends on C

A non key atribute depends on another non key attribute
Here, duration is dependent on course but not on student id

So we further divide the table into
1. course table - courseID, CourseName, Duration
2. students table - studentId, studentName, Phone
3. enrollmemt tables - StudentId, CourseId

BCNF - Boyce Codd Normal Form (BCNF) - advanced version of 3NF or 3.5NF
1. Table should be in 3NF
2. Ex: student_name depends on roll_no (roll_no should be supper key), branch_name is depenedning on branch_id (branch_id
is not super key, we have duplicates) split the data into two tables and reduce redundancy

example:

roll_no, st	udent_name, branch_id, branch_name
1		sai				121			cse
2		lakshmi			122			AIML
3		siri			123			DS
4		hari			121			CSE


roll_no	student_name	branch_id	branch_name


4NF - 
1. should be in BCNF form
2. No multi valued dependencies (course and hobby are non key attributes, more than one column is depending on key column)


student_id course hobby


student_id course	student_id hobby


5NF - Project Join Normal form
1. 4nf
2. It should not contain join dependencies (no column can be identified as unique) - breakdown as many possible to multiple tables

subject, faculty, year

1. Subject, faculty
2. Faculty, Year
3. Subject, Year

No Data redudancy

/*

INDEXES is a data structure which is used for performing faster searches.

EX: customer_id, customer_name, country

SELECT * FROM customers
WHERE customer_id = 5;

How it works?
Scans each row (so scans entire table) when no indexes is created.

*/
SELECT * FROM customers

SELECT * FROM customers
WHERE customer_id = 110;

-- create a index on a column
-- Faster searching happens

CREATE INDEX in_customerid
ON customers(customer_id);

SELECT * FROM customers
WHERE customer_id = 110;

-- Internally how it works?
/*
	We have two different indexes
	1. Clustered index
	2. Non clustered index

	WITHOUT INDEX:in data file : creates data pages and stores the data as per insertion order for the given limit.(random order)
	Ex: data page 1: stores 5 records, data page 2: stores 5 more records....
	Search each data page to find the required record.
	Takes more time

	Balance tree(data pages - leaf, and then intermediate and finally root level)
	Divide and scan (faster scan and less time)
	1. Clustered Index:
	When you create a clustered index on a column then it sorts the data in ascending order.
	data page 1:100(address file no: pageno) - customer_id : 1- 5
	data page 1:101 - customer_id: 6-10
	
	
	SYNTAX: 
	CREATE CLUSTERED INDEX ci_inc
	ON customers(customer_id)

	TABLE CREATION: we declare PRIMARY KEY, then that particular column will become clustered index will be created
	on that particular column by default.

	Lets say you wanna create a clustered index on another column, then it throws error:
	we cannot create a clustered key.
	Only one clustered index is allowed for every table.

	In case, we need it on another column
	synatx:
	DROP CLUSTERED INDEX index_name
	ON customers

	and later you can create it.

	
CREATE CLUSTERED INDEX ci_inc
ON customers(customer_id)

DROP INDEX index_name
ON tabel_name;

Just index is used to create then it is a non CLUSTERED INDEX, you can create any number of them for a table.

It is always better to use primary key as clustered_index.

-- Non clustered index:
Non clustered index is better than Without index

Speed? Clustered Index, Non clustered index, Without index

Structure of non clustered index:

It stores the way initiall stored without index. then it builts a b-tree index
leaf node contains key + pointer - not the actual row data.
4 steps are being performed.

COMPOSITE INDEX - creating a non clustered index on (columns)
Creating index on the same column order 
CREATE INDEX index_name
ON tablename(first_name,country)

SELECT * FROM
tablename
WHERE first_name = 'Lakshmi'

WORKS? yes

SELECT * FROM
tablename
WHERE country = 'usa'
WORKS? does not work

index on column - a,b,c
lets say in
query    index created?
a        yes
a,c      no
a,b      yes

Difference between clustered and non clustered index
clustered      non clustered
1. scan fast   
2. only one    multiple
3. sort data   random

speed? clustered, non clustered, without index

Query optimisation techqnique - creating indexes will increase the performance of searching.






















 
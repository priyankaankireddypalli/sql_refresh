-- SECTION A: SELECT
-- Q1. Show all columns and all rows from the course_enrollments table. How many total enrollments does LearnSphere have?
SELECT * 
FROM course_enrollments;

SELECT COUNT(*) as total_enrollments
FROM course_enrollments;

/* Q2. LearnSphere's marketing team needs student names, their course, city, 
and enrollment date for a welcome email campaign. Show only these columns. */


SELECT student_name, course_name, city, enrollment_date
FROM course_enrollments;

-- Q3. What unique course categories does LearnSphere offer? List each category exactly once.

SELECT DISTINCT(category)
FROM course_enrollments;

/* Q4. Create a revenue report showing Enrollment ID renamed as "Ref No", 
Student Name as "Learner", Course Name as "Programme", and Fee Paid as "Revenue (₹)". */

SELECT enrollment_date AS "Ref No",
	student_name AS "Learner",
	course_name AS "Programme",
	fee_paid AS "Revenue (₹)"
FROM course_enrollments;

-- SECTION B: WHERE CLAUSE
/* Q5. The Data Science team lead wants to review all Data Science enrollments. 
Show student name, course, fee paid, and status. */

SELECT * FROM course_enrollments
WHERE category = 'Data Science';

SELECT student_name, 
	course_name, 
	fee_paid, 
	status
FROM course_enrollments
WHERE category = 'Data Science';

-- Q6. Find all students who enrolled in a Beginner level Data Science course. Show name, course, fee, and city.

SELECT student_name,
	course_name,
	fee_paid,
	city
FROM course_enrollments
WHERE level = 'Beginner';


/* Q7. The content team is reviewing popular tech categories. 
Find all enrollments where the category is either "Data Science" or "Web Dev". 
Show student name, course, and fee. */

SELECT student_name,
	course_name,
	fee_paid
FROM course_enrollments
WHERE category IN ('Data Science', 'Web Dev');


/* Q8. Show all enrollments where the fee paid was between ₹2,000 and ₹5,000. 
This is LearnSphere's mid-tier pricing band. Include student name, course, fee, and category. */

SELECT student_name, course_name, fee_paid, category
FROM course_enrollments
WHERE fee_paid BETWEEN 2000 AND 5000;

/* Q9. The retention team wants to investigate dropout patterns. 
Show all enrollments where the status is NOT "Completed". 
Include student name, category, fee, and status. */

SELECT student_name, category, fee_paid, status
FROM course_enrollments
WHERE NOT status = 'Completed';


/* Q10. Find all courses whose name contains the word "Python". 
The product team wants to audit all Python-related content on the platform. */

SELECT *
FROM course_enrollments
WHERE course_name LIKE '%Python%';

/* Q11. Q2 2024 (April to June) was a heavy enrollment period. 
Show all enrollments from this period. 
Include student name, course, category, fee, and enrollment date. */

SELECT student_name, course_name, fee_paid, enrollment_date
FROM course_enrollments
WHERE enrollment_date BETWEEN '2024-04-01' AND '2024-7-30';

-- Section C Aggregates & GROUP BY
/* Q12. What is the total number of enrollments and total revenue LearnSphere has generated? Show both in a single query. */

SELECT * FROM course_enrollments;

SELECT COUNT(*) AS total_enrollments,
	SUM(fee_paid) AS total_revenue
FROM course_enrollments;

/* Q13. How many students enrolled in each category? 
Sort by most popular category first. 
This tells the content team what to invest in next. */

SELECT category, COUNT(*) as students_enrolled_cnt
FROM course_enrollments
GROUP BY category
ORDER BY students_enrolled_cnt DESC;

/* Q14. What is the total revenue generated per category? 
Show category name and total revenue, ordered from highest to lowest earner. */

SELECT category, SUM(fee_paid) AS total_revenue_cat
FROM course_enrollments
GROUP BY category
ORDER BY total_revenue_cat DESC;


/* Q15. What is the average rating given by students in each category?
Round to 1 decimal. The content team uses this to benchmark course quality. */

SELECT category, ROUND(avg(rating),1) as avg_rating
FROM course_enrollments
GROUP BY category;

/* Q16. LearnSphere wants to know which device type (Mobile, Desktop, Tablet) is most used for each category. 
Show category, device, and enrollment count sorted by category then count descending */

SELECT category, device, COUNT(*) as cnt
FROM course_enrollments
GROUP BY category, device
ORDER BY category, cnt DESC;

/* Q17. Show the total number of enrollments and revenue earned each month in 2024.
Sort by month number chronologically. This is LearnSphere's monthly growth report. */

SELECT * FROM course_enrollments

SELECT MONTH(enrollment_date) as month, COUNT(*) AS no_of_enrollments, SUM(fee_paid) as revenue_earned
FROM course_enrollments
GROUP BY MONTH(enrollment_date)
ORDER BY month;

-- Section D HAVING Clause

/*Q18. Find all cities where more than 15 students have enrolled. 
These are LearnSphere's high-adoption cities and should be targeted for offline events. */

SELECT * FROM course_enrollments
SELECT city, COUNT(DISTINCT student_name) AS student_count
FROM course_enrollments
GROUP BY city
HAVING COUNT(DISTINCT student_name) > 15;

/* Q19. Find all instructors whose average student rating is 4.5 or above. 
These are the "top-rated instructors" LearnSphere features them on the homepage. */

SELECT instructor, ROUND(avg(rating),2) as avg_rating
FROM course_enrollments
GROUP BY instructor
HAVING avg(rating) >= 4.5;

/* (Q20). The product team wants to identify "high dropout" 
categories those where more than 30% of enrollments result in a "Dropped" 
status (among non-completed enrollments). Show category and dropout percentage.*/

SELECT
    category,
    ROUND(
        SUM(CASE WHEN status = 'Dropped' THEN 1 ELSE 0 END) * 100.0 /
        SUM(CASE WHEN status <> 'Completed' THEN 1 ELSE 0 END),
        2
    ) AS dropout_percentage
FROM course_enrollments
GROUP BY category
HAVING
    SUM(CASE WHEN status = 'Dropped' THEN 1 ELSE 0 END) * 100.0 /
    SUM(CASE WHEN status <> 'Completed' THEN 1 ELSE 0 END) > 30;

-- Section E LIMIT & OFFSET
/* Q21. LearnSphere's "Hall of Fame" shows the top 5 most expensive courses on the platform. 
Show course name, category, and fee for the top 5 highest-priced enrollments. */

SELECT * from course_enrollments;

SELECT top 5 course_name, category, fee_paid
FROM course_enrollments
ORDER BY fee_paid DESC


SELECT course_name, category, fee_paid
FROM course_enrollments
ORDER BY fee_paid DESC
LIMIT 5;

/* LearnSphere's admin panel shows 8 enrollments per page, 
sorted by enrollment date newest first. Write queries for Page 1, Page 2, and Page 4. 
(Note: Write all three queries, but explain what changes between them.) */

-- page 1
SELECT TOP 8 *
FROM course_enrollments
ORDER BY enrollment_date DESC;

SELECT *
FROM course_enrollments
ORDER BY enrollment_date DESC
LIMIT 10;

-- page 2
SELECT *
FROM course_enrollments
ORDER BY enrollment_date DESC
LIMIT 10
OFFSET 10;

-- page 4
SELECT *
FROM course_enrollments
ORDER BY enrollment_date DESC
LIMIT 10
OFFSET 30;



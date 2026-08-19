-- Requirement
-- how is eac teahcer performance for a particular class in the given time range.
CREATE DATABASE tution_app
USE tution_app

CREATE TABLE classes (
    id INT PRIMARY KEY,
    teacher_id INT,
    student_id INT,
    class_status VARCHAR(20),
    class_date DATE
);

CREATE TABLE user_subscription_details (
    id INT PRIMARY KEY,
    user_id INT,
    status VARCHAR(20),
    renewal_date DATE
);

-- Users table contains both teachers and students
CREATE TABLE users (
    id INT PRIMARY KEY,
    full_name VARCHAR(30),
    role_name VARCHAR(30),
    status VARCHAR(20)
);

ALTER TABLE classes
ADD CONSTRAINT FK_Classes_Teacher
FOREIGN KEY (teacher_id) REFERENCES users(id);

ALTER TABLE classes
ADD CONSTRAINT FK_Classes_Student
FOREIGN KEY (student_id) REFERENCES users(id);

ALTER TABLE user_subscription_details
ADD CONSTRAINT FK_Subscription_User
FOREIGN KEY (user_id) REFERENCES users(id);

INSERT INTO users (id, full_name, role_name, status)
VALUES
(1, 'John Smith', 'Teacher', 'Active'),
(2, 'Emma Wilson', 'Teacher', 'Active'),
(3, 'Alice Brown', 'Student', 'Active'),
(4, 'David Lee', 'Student', 'Active'),
(5, 'Sophia Davis', 'Student', 'Inactive'),
(6, 'Michael Johnson', 'Teacher', 'Inactive');


INSERT INTO user_subscription_details (id, user_id, status, renewal_date)
VALUES
(1, 3, 'Active', '2026-12-31'),
(2, 4, 'Active', '2026-11-30'),
(3, 5, 'Expired', '2025-12-31');


INSERT INTO classes (id, teacher_id, student_id, class_status, class_date)
VALUES
(1, 1, 3, 'Completed', '2026-07-20'),
(2, 1, 4, 'Completed', '2026-07-21'),
(3, 2, 3, 'Scheduled', '2026-08-01'),
(4, 2, 5, 'Cancelled', '2026-07-25'),
(5, 1, 5, 'Completed', '2026-07-15'),
(6, 2, 4, 'Completed', '2026-07-28');

SELECT * FROM classes;
SELECT * FROM user_subscription_details;
SELECT * FROM users;


-- Q1.how many classes are conducted by each teacher

SELECT u.id, COUNT(c.id) as cnt
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher'
GROUP BY u.id


SELECT u.id, COUNT(c.id) as cnt
FROM users u 
INNER JOIN classes c
ON u.id = c.teacher_id
GROUP BY u.id


-- Q2. In July month, which teacher conducted how many classes
SELECT u.id, COUNT(c.id) as cnt
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher' AND DATEPART(MONTH,class_date) = '7'
GROUP BY u.id

SELECT u.id, COUNT(c.id) as cnt
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher' AND c.class_date BETWEEN '01-07-2026' AND '31-07-2026'
GROUP BY u.id

-- Q3. How many classess completed, how many classes not completed?

SELECT u.id, count(c.teacher_id) as total_cnt,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) as 'Completed_count',
    SUM(CASE WHEN c.class_status = 'Scheduled' or c.class_status = 'Cancelled' THEN 1 ELSE 0 END) as 'Incomplete_count'
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher'
GROUP BY u.id

-- Q3. How many classess completed, how many classes not completed? only if teacher is active retreive data
SELECT u.id, count(c.teacher_id) as total_cnt,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) as 'Completed_count',
    SUM(CASE WHEN c.class_status = 'Scheduled' or c.class_status = 'Cancelled' THEN 1 ELSE 0 END) as 'Incomplete_count'
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher' and u.status = 'Active'
GROUP BY u.id


SELECT u.id, 
    count(c.teacher_id) as total_cnt,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN c.class_status != 'Completed' THEN 1 ELSE 0 END) AS not_completed
FROM users u
INNER JOIN classes c
ON u.id = c.teacher_id
WHERE u.status = 'Active'
GROUP BY u.id


-- Q3. How many classess completed, how many classes not completed? only if teacher is active retreive data and how many students was handled


SELECT u.id, count(c.teacher_id) as total_cnt,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) as 'Completed_count',
    SUM(CASE WHEN c.class_status = 'Scheduled' or c.class_status = 'Cancelled' THEN 1 ELSE 0 END) as 'Incomplete_count',
    COUNT(c.student_id) as student_cnt
FROM users u
LEFT JOIN classes c
ON u.id = c.teacher_id
WHERE u.role_name = 'Teacher' and u.status = 'Active'
GROUP BY u.id


-- Q3. How many classess completed, how many classes not completed? only if teacher is active retreive data and how many active students was handled
SELECT
    u.id,
    u.full_name,
    COUNT(c.teacher_id) AS total_classes,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
    SUM(CASE WHEN c.class_status IN ('Scheduled', 'Cancelled') THEN 1 ELSE 0 END) AS incomplete_count,
    COUNT(us.user_id) AS active_student_count
FROM users u
LEFT JOIN classes c
    ON u.id = c.teacher_id
LEFT JOIN user_subscription_details us
    ON us.user_id = c.student_id
   AND us.status = 'Active'
WHERE u.role_name = 'Teacher'
  AND u.status = 'Active'
GROUP BY u.id, u.full_name;


-- calculate percentage  (completed class / total classes * 100)

WITH cte1 AS (
SELECT
    u.id,
    u.full_name,
    COUNT(c.teacher_id) AS total_classes,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
    SUM(CASE WHEN c.class_status IN ('Scheduled', 'Cancelled') THEN 1 ELSE 0 END) AS incomplete_count,
    COUNT(us.user_id) AS active_student_count
FROM users u
LEFT JOIN classes c
    ON u.id = c.teacher_id
LEFT JOIN user_subscription_details us
    ON us.user_id = c.student_id
   AND us.status = 'Active'
WHERE u.role_name = 'Teacher'
  AND u.status = 'Active'
GROUP BY u.id, u.full_name)

SELECT *, ((completed_count*100.0)/total_classes) AS disc
FROM cte1


-- OR 
SELECT
    u.id,
    u.full_name,
    COUNT(c.teacher_id) AS total_classes,
    SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
    SUM(CASE WHEN c.class_status IN ('Scheduled', 'Cancelled') THEN 1 ELSE 0 END) AS incomplete_count,
    COUNT(us.user_id) AS active_student_count,
     SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END)*100.0/COUNT(*) as disc
FROM users u
LEFT JOIN classes c
    ON u.id = c.teacher_id
LEFT JOIN user_subscription_details us
    ON us.user_id = c.student_id
   AND us.status = 'Active'
WHERE u.role_name = 'Teacher'
  AND u.status = 'Active'
GROUP BY u.id, u.full_name


-- CREATE A STORED PROCEDURE FOR THE ABOVE following for parameterized dates


CREATE PROCEDURE teacher_performance
    @startdate DATE,
    @enddate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.id,
        u.full_name,
        COUNT(c.id) AS total_classes,
        SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
        SUM(CASE WHEN c.class_status IN ('Scheduled', 'Cancelled') THEN 1 ELSE 0 END) AS incomplete_count,
        COUNT(DISTINCT us.user_id) AS active_student_count,
        ROUND(
            SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END) * 100.0
            / NULLIF(COUNT(c.id), 0), 2
        ) AS completion_percentage,
        SUM(CASE WHEN c.class_status = 'Completed' THEN 1 ELSE 0 END)*100.0/COUNT(*) as disc
    FROM users u
    LEFT JOIN classes c
        ON u.id = c.teacher_id
    LEFT JOIN user_subscription_details us
        ON us.user_id = c.student_id
       AND us.status = 'Active'
    WHERE u.role_name = 'Teacher'
      AND u.status = 'Active'
      AND c.class_date BETWEEN @startdate AND @enddate
    GROUP BY u.id, u.full_name;
END;
GO

EXEC teacher_performance '2026-07-01', '2026-07-31'
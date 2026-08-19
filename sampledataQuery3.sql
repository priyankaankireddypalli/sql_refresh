-- ============================================================
-- LEARNSPHERE · course_enrollments · 40 rows
-- ============================================================

USE tempdb;
DROP TABLE IF EXISTS course_enrollments;

CREATE TABLE course_enrollments (
  enrollment_id INT PRIMARY KEY, -- Unique ID per enrollment
  student_name VARCHAR(100), -- Student's full name
  course_name VARCHAR(150), -- Name of the course
  instructor VARCHAR(100), -- Instructor name
  category VARCHAR(60), -- Data Science, Web Dev, Finance, Marketing, Design
  level VARCHAR(30), -- Beginner, Intermediate, Advanced
  enrollment_date DATE, -- When student enrolled
  completion_date DATE, -- NULL if not completed yet
  duration_hours INT, -- Total course hours (5-80)
  fee_paid DECIMAL(10,2), -- Fee in ₹
  rating DECIMAL(3,1), -- Student rating 1.0-5.0, NULL if not rated
  city VARCHAR(60), -- Student's city
  device VARCHAR(20), -- Mobile, Desktop, Tablet
  status VARCHAR(20) -- Completed, In Progress, Dropped
);

INSERT INTO course_enrollments VALUES
(1,'Aditi Verma','Python for Data Science','Dr. Rajan Pillai','Data Science','Beginner','2024-01-10','2024-02-20',42,2999.00,4.5,'Pune','Desktop','Completed'),
(2,'Rohan Mehta','React.js Zero to Hero','Priya Nair','Web Dev','Intermediate','2024-01-15',NULL,35,3499.00,4.2,'Mumbai','Desktop','In Progress'),
(3,'Kavita Rao','Financial Modelling in Excel','Suresh Iyer','Finance','Advanced','2024-02-01',NULL,60,5999.00,NULL,'Bangalore','Mobile','In Progress'),
(4,'Arjun Nair','Digital Marketing 101','Meera Das','Marketing','Beginner','2024-02-10',NULL,18,1499.00,3.8,'Chennai','Mobile','Dropped'),
(5,'Sneha Joshi','UI UX Design with Figma','Kiran Sharma','Design','Beginner','2024-03-05','2024-03-30',25,2499.00,4.7,'Hyderabad','Tablet','Completed'),
(6,'Pratik Shah','Machine Learning A to Z','Dr. Rajan Pillai','Data Science','Advanced','2024-03-12','2024-05-01',75,6999.00,4.9,'Ahmedabad','Desktop','Completed'),
(7,'Aditi Verma','SQL for Analysts','Suresh Iyer','Data Science','Intermediate','2024-04-01','2024-04-25',20,1999.00,5.0,'Pune','Desktop','Completed'),
(8,'Mihir Das','Excel Mastery','Suresh Iyer','Finance','Beginner','2024-04-15',NULL,12,899.00,4.0,'Kolkata','Mobile','Dropped'),
(9,'Pooja Gupta','Node.js Backend Dev','Priya Nair','Web Dev','Advanced','2024-01-20','2024-03-10',55,5499.00,4.6,'Delhi','Desktop','Completed'),
(10,'Ravi Shankar','Google Ads Mastery','Meera Das','Marketing','Intermediate','2024-02-05',NULL,22,2299.00,3.5,'Mumbai','Mobile','Dropped'),
(11,'Lakshmi Pillai','Tableau for Beginners','Dr. Rajan Pillai','Data Science','Beginner','2024-02-18','2024-03-15',18,1799.00,4.3,'Chennai','Desktop','Completed'),
(12,'Aman Khanna','Advanced CSS and Tailwind','Priya Nair','Web Dev','Intermediate','2024-03-01',NULL,30,2799.00,NULL,'Delhi','Desktop','In Progress'),
(13,'Divya Singh','Financial Statement Analysis','Suresh Iyer','Finance','Advanced','2024-03-08','2024-04-20',48,4999.00,4.8,'Pune','Tablet','Completed'),
(14,'Nikhil Reddy','SEO and Content Strategy','Meera Das','Marketing','Beginner','2024-04-01',NULL,15,1299.00,3.2,'Hyderabad','Mobile','Dropped'),
(15,'Sneha Joshi','Motion Graphics After Effects','Kiran Sharma','Design','Intermediate','2024-04-10',NULL,40,3799.00,NULL,'Hyderabad','Desktop','In Progress'),
(16,'Kabir Malik','Deep Learning with PyTorch','Dr. Rajan Pillai','Data Science','Advanced','2024-05-01','2024-07-15',80,7999.00,4.7,'Bangalore','Desktop','Completed'),
(17,'Aditi Verma','Digital Marketing 101','Meera Das','Marketing','Beginner','2024-05-10','2024-05-30',18,1499.00,4.1,'Pune','Mobile','Completed'),
(18,'Rohan Mehta','MongoDB and NoSQL','Priya Nair','Web Dev','Advanced','2024-05-15',NULL,35,3999.00,NULL,'Mumbai','Desktop','In Progress'),
(19,'Priyanka Das','Power BI Dashboard','Dr. Rajan Pillai','Data Science','Intermediate','2024-06-01','2024-07-01',28,2499.00,4.4,'Kolkata','Desktop','Completed'),
(20,'Vikram Bose','Mutual Funds and SIP','Suresh Iyer','Finance','Beginner','2024-06-05',NULL,10,799.00,3.9,'Delhi','Mobile','In Progress'),
(21,'Kavita Rao','Branding and Identity Design','Kiran Sharma','Design','Advanced','2024-06-10','2024-08-01',50,5299.00,4.6,'Bangalore','Tablet','Completed'),
(22,'Nikhil Reddy','Python Automation Scripts','Dr. Rajan Pillai','Data Science','Intermediate','2024-07-01',NULL,22,1999.00,4.0,'Hyderabad','Desktop','In Progress'),
(23,'Aman Khanna','Email Marketing Pro','Meera Das','Marketing','Intermediate','2024-07-05','2024-07-28',14,1799.00,4.2,'Delhi','Mobile','Completed'),
(24,'Mihir Das','Full Stack MERN Project','Priya Nair','Web Dev','Advanced','2024-07-10',NULL,70,6499.00,NULL,'Kolkata','Desktop','In Progress'),
(25,'Pooja Gupta','Excel for Finance','Suresh Iyer','Finance','Beginner','2024-08-01','2024-08-20',15,999.00,4.5,'Delhi','Desktop','Completed'),
(26,'Lakshmi Pillai','Illustrator for Beginners','Kiran Sharma','Design','Beginner','2024-08-05',NULL,20,1899.00,3.7,'Chennai','Tablet','Dropped'),
(27,'Kabir Malik','NLP with Transformers','Dr. Rajan Pillai','Data Science','Advanced','2024-08-10',NULL,65,7499.00,NULL,'Bangalore','Desktop','In Progress'),
(28,'Divya Singh','Social Media Strategy','Meera Das','Marketing','Beginner','2024-09-01','2024-09-20',12,999.00,4.3,'Pune','Mobile','Completed'),
(29,'Priyanka Das','Vue.js Fundamentals','Priya Nair','Web Dev','Beginner','2024-09-05',NULL,25,2199.00,3.8,'Kolkata','Desktop','In Progress'),
(30,'Ravi Shankar','Candlestick Trading','Suresh Iyer','Finance','Advanced','2024-09-10',NULL,45,5499.00,NULL,'Mumbai','Mobile','Dropped'),
(31,'Vikram Bose','Photoshop Complete Guide','Kiran Sharma','Design','Intermediate','2024-10-01','2024-11-10',35,3299.00,4.4,'Delhi','Desktop','Completed'),
(32,'Arjun Nair','Statistics for Data Science','Dr. Rajan Pillai','Data Science','Intermediate','2024-10-05',NULL,30,2799.00,4.1,'Chennai','Desktop','In Progress'),
(33,'Sneha Joshi','Performance Marketing','Meera Das','Marketing','Advanced','2024-10-10','2024-11-20',32,3999.00,4.8,'Hyderabad','Desktop','Completed'),
(34,'Aditi Verma','TypeScript Masterclass','Priya Nair','Web Dev','Intermediate','2024-10-15',NULL,28,2599.00,NULL,'Pune','Desktop','In Progress'),
(35,'Mihir Das','Value Investing Basics','Suresh Iyer','Finance','Beginner','2024-11-01',NULL,8,699.00,3.5,'Kolkata','Mobile','Dropped'),
(36,'Priyanka Das','Color Theory and Branding','Kiran Sharma','Design','Beginner','2024-11-05','2024-11-25',15,1499.00,4.6,'Kolkata','Tablet','Completed'),
(37,'Kabir Malik','A/B Testing and Analytics','Dr. Rajan Pillai','Data Science','Advanced','2024-11-10',NULL,24,3499.00,4.2,'Bangalore','Desktop','In Progress'),
(38,'Rohan Mehta','Google Analytics 4','Meera Das','Marketing','Beginner','2024-11-15','2024-12-01',10,899.00,4.0,'Mumbai','Mobile','Completed'),
(39,'Ravi Shankar','Django REST Framework','Priya Nair','Web Dev','Advanced','2024-12-01',NULL,50,5999.00,NULL,'Mumbai','Desktop','In Progress'),
(40,'Lakshmi Pillai','Budget Planning Personal','Suresh Iyer','Finance','Beginner','2024-12-05',NULL,8,599.00,NULL,'Chennai','Mobile','In Progress');

-- verify inserted records
SELECT COUNT(*) as total_records FROM course_enrollments;
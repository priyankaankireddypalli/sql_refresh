-- TEXT 

CREATE TABLE cust(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

INSERT INTO cust (customer_id, customer_name, email, phone)
VALUES
(101, 'john doe',        'john@gmail.com',             '9876543210'),
(102, 'PRIYA SHARMA',    'priya@gmail.com',            '9123456789'),
(103, 'rahul reddy',     'rahul@yahoo.com',            '9988776655'),
(104, 'ANJALI VERMA',    'anjali@company.com',         '9876501234'),
(105, 'rohit kumar',     'rohit@gmail.com',            '9012345678'),
(106, 'Sneha Gupta',     'sneha@outlook.com',          '9988001122'),
(107, 'vikram singh',    'vikram@gmail.com',           '9871112233'),
(108, 'MEERA NAIR',      'meera@yahoo.com',            '9999999999'),
(109, 'arjun patel',     'arjun@gmail.com',            '9000011111'),
(110, 'Kiran Rao',       'kiran@company.com',          '8888888888'),

-- Duplicate email username
(111, 'John Smith',      'john@yahoo.com',             '7777777777'),

-- Duplicate username in another domain
(112, 'Priya Kapoor',    'priya@company.com',          '6666666666'),

-- NULL phone
(113, 'Amit Joshi',      'amit@gmail.com',             NULL),

-- NULL email
(114, 'Neha Sharma',     NULL,                         '9555511111'),

-- NULL customer name
(115, NULL,              'unknown@gmail.com',          '9444411111');

SELECT * FROM customers
-- Q1. Capitalize the first letter of each customer name

SELECT customer_id,
    UPPER( LEFT(customer_name,1))+
    LOWER(SUBSTRING(customer_name,2,LEN(customer_name))) as customer_name
FROM cust

-- Q2. Extract domain from email

SELECT *, SUBSTRING_INDEX('@',email,-1) as domain
FROM cust

SELECT customer_id,
SPLIT(email,'@')[1] as domain
FROM cust


-- Q3. Extract first name
SELECT
    customer_name,
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name
FROM customers;
-- Q4. Extract last name
SELECT
    customer_name,
    SUBSTRING_INDEX(customer_name, ' ', -1) AS last_name
FROM customers;

-- Q5. Replace gmail with company domain

UPDATE customers
SET email = REPLACE(email, 'gmail.com', 'company.com')
WHERE email LIKE '%gmail.com';


-- Q6. Mask phone numbers (Show only 4 digits)
SELECT
    phone,
    REPLICATE('X', LEN(phone) - 4) + RIGHT(phone, 4) AS masked_phone
FROM cust

SELECT CONCAT('XXXXXXXXXX',SELECT RIGHT(phone,4)))
FROM cust


-- q7. Count customers per email domain
SELECT
    SUBSTRING(email,
              CHARINDEX('@', email) + 1,
              LEN(email)) AS email_domain,
    COUNT(*) AS customer_count
FROM cust
WHERE email IS NOT NULL
GROUP BY
    SUBSTRING(email,
              CHARINDEX('@', email) + 1,
              LEN(email));


SELECT
    RIGHT(email, LEN(email) - CHARINDEX('@', email)) AS email_domain,
    COUNT(*) AS customer_count
FROM cust
WHERE email IS NOT NULL
GROUP BY
    RIGHT(email, LEN(email) - CHARINDEX('@', email));

-- Q8. Find duplicates email usernames

SELECT email, count(*) as cnt
FROM cust
GROUP BY email
HAVING count(*) > 1
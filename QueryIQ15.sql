CREATE TABLE events (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_name VARCHAR(50),
    event_time DATETIME
);

INSERT INTO events (event_id, user_id, event_name, event_time)
VALUES
-- User 101
(1, 101, 'login', '2026-08-01 09:00:00'),
(2, 101, 'view_product', '2026-08-01 09:05:00'),
(3, 101, 'add_to_cart', '2026-08-01 09:10:00'),
(4, 101, 'purchase', '2026-08-01 09:15:00'),
(5, 101, 'logout', '2026-08-01 09:20:00'),

-- User 102
(6, 102, 'login', '2026-08-01 10:00:00'),
(7, 102, 'view_product', '2026-08-01 10:08:00'),
(8, 102, 'logout', '2026-08-01 10:15:00'),

-- User 103
(9, 103, 'login', '2026-08-01 11:00:00'),
(10, 103, 'view_product', '2026-08-01 11:05:00'),
(11, 103, 'add_to_cart', '2026-08-01 11:10:00'),
(12, 103, 'logout', '2026-08-01 11:30:00'),

-- User 104
(13, 104, 'login', '2026-08-02 08:45:00'),
(14, 104, 'view_product', '2026-08-02 08:50:00'),
(15, 104, 'purchase', '2026-08-02 08:55:00'),
(16, 104, 'logout', '2026-08-02 09:00:00'),

-- User 105
(17, 105, 'login', '2026-08-02 14:00:00'),
(18, 105, 'view_product', '2026-08-02 14:10:00'),
(19, 105, 'add_to_cart', '2026-08-02 14:15:00'),
(20, 105, 'purchase', '2026-08-02 14:20:00'),
(21, 105, 'logout', '2026-08-02 14:30:00');


-- Q1. Find the first and last occurrence of each event per user

SELECT user_id, MIN(event_time) as first_occurence, MAX(event_time) as last_occurence
FROM events
GROUP BY user_id


SELECT user_id,event_name, MIN(event_time) as first_occurence, MAX(event_time) as last_occurence
FROM events
GROUP BY user_id, event_name



SELECT * FROM (SELECT distinct user_id, event_time,
   LAG(event_time) OVER(PARTITION BY user_id ORDER BY event_time) as previous,
   LEAD(event_time) OVER(PARTITION BY user_id ORDER BY event_time) as next
FROM events) t
WHERE previous IS NULL OR next IS NULL


SELECT * FROM (SELECT distinct user_id, event_time,
   ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_time) as rw,
   ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_time DESC) as rw2
FROM events) t
WHERE rw = 1 or rw2 = 1;
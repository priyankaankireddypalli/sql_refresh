
-- SUBQUERIES (complex logic is implemented in simple queries)

CREATE TABLE users(
    user_id INT PRIMARY KEY,
    name VARCHAR(50) NULL
);
INSERT INTO users (user_id, name)
VALUES
(1,'Alice'),
(2,'Bob'),
(3,'Charlie'),
(4,'David'),
(5,'Eva'),
(6,NULL),             -- NULL name
(7,'Grace'),
(8,'Henry'),
(9,'Ivy'),
(10,'Bob');           -- Duplicate name



CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product VARCHAR(50) NULL
);
INSERT INTO products(product_id, product)
VALUES
(101,'Laptop'),
(102,'Mouse'),
(103,'Keyboard'),
(104,'Monitor'),
(105,'Phone'),
(106,NULL),           -- NULL product
(107,'Tablet'),
(108,'Headphones'),
(109,'Laptop'),       -- Duplicate product name
(110,'Camera');

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NULL,
    amount DECIMAL(10,2) NULL,
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_orders_products
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders(order_id,user_id,product_id,amount)
VALUES
(1001,1,101,50000),
(1002,1,102,1000),
(1003,2,103,2500),
(1004,2,104,12000),
(1005,3,105,30000),
(1006,3,NULL,5000),      -- NULL product
(1007,4,101,50000),
(1008,5,106,NULL),       -- NULL amount
(1009,6,107,20000),
(1010,7,108,2500),

-- Same user buys same product again
(1011,1,101,52000),

-- Duplicate business record (different order_id)
(1012,2,103,2500),

-- Zero amount
(1013,8,109,0),

-- Refund
(1014,9,105,-500),

-- NULL amount
(1015,10,110,NULL);


SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'orders'

-- NON CO-RELATED SUBQUERIES

-- Find user details who has placed any order

-- Using NON correlated subqueries: where inner query does not dependent upon outer query, 
-- It can execute independently without any dependent on outer query and it is mainly used to filter the results of outer query

-- also uses IN (used to filter based on list of values)

SELECT *
FROM users 
WHERE user_id IN (SELECT DISTINCT(user_id)
FROM orders)

-- Find the order details which have order_amount greater than average orders value
-- non corelated subquery
SELECT *
FROM orders 
WHERE amount > 
(SELECT ROUND(AVG(amount),2) as avg
FROM orders)

-- Users who purchased Keyboard
SELECT *
FROM users
WHERE user_id IN (SELECT distinct(user_id)
FROM orders 
WHERE product_id IN (SELECT product_id
FROM products
WHERE product = 'Keyboard'))


SELECT distinct user_id, product_id
FROM orders 
WHERE product_id IN (SELECT product_id
FROM products
WHERE product = 'Keyboard')

-- Fetch each order_id along with user's name (Tricky)
-- Co-related subquery gets executed multiple times. Every record from outer query is scanned with all the records from inner query.

SELECT o.order_id, (SELECT u.name FROM users u WHERE u.user_id = o.user_id) as cust_name
FROM orders o;


-- Find max spend by any user
SELECT u.user_id, (SELECT MAX(o.amount) FROM orders o WHERE o.user_id = u.user_id) as max_spent
FROM users u;


SELECT MAX(t.total_value) as max_value FROM (SELECT SUM(o.amount) as total_value
FROM orders o
GROUP BY o.user_id) t

-- Find users who placed more orders than avg no of orders. (Tricky)

SELECT user_id, count(*) as cnt
FROM orders
GROUP BY user_id 
HAVING COUNT(*) > (SELECT AVG(t.order_cnt) as avg_no FROM ( SELECT user_id, COUNT(*) as order_cnt
FROM orders
GROUP BY user_id) t)


SELECT user_id, name
FROM users
WHERE user_id IN 
    (SELECT user_id
    FROM orders
    GROUP BY user_id 
    HAVING COUNT(*) > 
        (SELECT AVG(t.order_cnt) as avg_no FROM ( SELECT user_id, COUNT(*) as order_cnt
        FROM orders
        GROUP BY user_id
        ) t)
     )


-- Find users whose maximum order amount is greater than 1000. 

-- Inner query gets executed every time and checks the list by using IN operator for each record from outer query. Time consuming 
-- Solution: use EXISTS (faster execution) atleast one value is occured in inner query, then the query is stopped. Instead of checking whole values, it checks if it finds the first occurence value.


SELECT *
FROM users
WHERE user_id IN (
SELECT user_id
FROM orders
GROUP BY user_id
HAVING MAX(amount) > 1000);

-- Users that have placed atleast one order/any order
/* IN operator - Lets say we habe 10M records, and user_id 1 has placed 100 orders. 
When we use IN to check the users in ordes table - there are 100 records,
so it will map 100 times, which is not efficient.
In case, i use Distinct also, duplicates are identified and uniques are retrieved. 
Which is time consuming, since it scans the entire table in background. 
Solution: Exists - It returns 1st occurance ( 1 row returned) where as not exists - will return 0 rows are returned 
(not exists works same as not in because it needs to scan the entire table to check it is not present)*/ 

SELECT  *
FROM users
WHERE user_id IN
(SELECT DISTINCT(user_id) FROM orders)

-- no need of column in filtering outer query, also in inner query you dont need column, can give dummy variable (Tricky)
SELECT  *
FROM users u
WHERE EXISTS
(SELECT 1 FROM orders o WHERE o.user_id = u.user_id)


-- Find users who havent placed any order
SELECT *
FROM users u
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.user_id)

-- Find users who bought all products (Tricky)


SELECT user_id
FROM orders
GROUP BY user_id
HAVING COUNT(DISTINCT(product_id)) = (SELECT COUNT(*) FROM products)

-- using not exists (interview Question)
SELECT *
FROM users u 
WHERE NOT EXISTS (
SELECT 1 FROM products p
WHERE NOT EXISTS (
SELECT 1
FROM orders o
WHERE o.user_id = u.user_id AND o.product_id = p.product_id))

---------------------------------------------------------------------------------------------------------------------
-- non-corelated subquery: independent queries can be executed. (No relation)
SELECT *
FROM users u
WHERE u.user_id IN (SELECT DISTINCT(o.user_id) FROM orders o)


-- corelated subquery: When query is dependent on outer column while executing inner query is called non corelated subquery.
-- Ex: Customers who made purchase or whose average amount is greater than their own order amount

SELECT * FROM users
SELECT * FROM orders
SELECT * FROM products


SELECT *
FROM orders o1
WHERE o1.amount > (SELECT AVG(o2.amount) FROM orders o2 WHERE o2.user_id = o1.user_id)

/*Question

Find users who have ordered every product.

Suppose we have these tables.

users
user_id	name
1	Alice
2	Bob
3	Charlie
products
product_id	product
101	Laptop
102	Mouse
103	Keyboard

There are 3 products.

orders
order_id	user_id	product_id
1	1	101
2	1	102
3	1	103
4	2	101
5	2	102
6	3	101

Alice bought all products.

Bob bought Laptop and Mouse.

Charlie bought only Laptop.

Expected output:

user_id	name
1	Alice
Step 1 - Outer Query
SELECT *
FROM users u

This simply starts reading users.

Current row:

Alice

The database asks:

"Should I return Alice?"

It doesn't know yet.

So it evaluates the WHERE clause.

Step 2 - Outer NOT EXISTS
WHERE NOT EXISTS (
   ...
)

Read this in English:

Return Alice only if the subquery returns no rows.

So SQL goes inside.

Step 3 - Products Table
SELECT 1
FROM products p

This means SQL checks every product.

Current products:

Laptop
Mouse
Keyboard

It checks them one by one.

First Product

Current product

Laptop

Now SQL evaluates

WHERE NOT EXISTS
(
   SELECT 1
   FROM orders o
   WHERE o.user_id = u.user_id
   AND o.product_id = p.product_id
)

Remember

u.user_id = Alice

Current product

Laptop

So SQL runs

SELECT 1
FROM orders
WHERE user_id = Alice
AND product_id = Laptop

Orders contain

Alice Laptop

Found!

The query returns

1

Therefore

NOT EXISTS(...)

becomes

FALSE

Meaning

Alice HAS bought Laptop.

Nothing is returned from the products query for this product.

Move to next product.

Second Product

Mouse

Run

SELECT 1
FROM orders
WHERE user_id=Alice
AND product_id=Mouse

Found.

Again

NOT EXISTS = FALSE

Move on.

Third Product

Keyboard

Run

SELECT 1
FROM orders
WHERE user_id=Alice
AND product_id=Keyboard

Found.

Again

NOT EXISTS = FALSE

Now the products query has checked ALL products.

Did it return any rows?

No.

Because every product existed in Alice's orders.

So this subquery

SELECT 1
FROM products p
WHERE NOT EXISTS(...)

returns

(empty)

Now the OUTER condition becomes

NOT EXISTS(empty)

Which equals

TRUE

Therefore

Return Alice
Now Bob

Outer query picks

Bob

Again products start.

Laptop

Exists.

Move on.

Mouse

Exists.

Move on.

Keyboard

Run

SELECT 1
FROM orders
WHERE user_id=Bob
AND product_id=Keyboard

No row.

So

NOT EXISTS

becomes

TRUE

Meaning

Bob did NOT buy Keyboard.

Therefore the products query returns

1

because a missing product was found.

Now the OUTER query evaluates

NOT EXISTS
(
   1
)

which becomes

FALSE

Bob is rejected.

Charlie

Laptop

Exists.

Mouse

Missing.

Immediately

Products query returns a row.

Outer NOT EXISTS becomes FALSE.

Charlie rejected.

Visual Representation
For every User
      │
      ▼
Check every Product
      │
      ▼
Did user buy this product?
      │
 ┌────┴────┐
 │         │
Yes        No
 │         │
Continue   Return a row
           │
           ▼
Outer NOT EXISTS fails
The Key Logic

The inner query asks:

"Did the user buy this product?"

SELECT 1
FROM orders
WHERE user_id = u.user_id
AND product_id = p.product_id

The middle NOT EXISTS asks:

"Is there a product the user did not buy?"

NOT EXISTS(...)

The outer NOT EXISTS asks:

"Is there NO product that the user failed to buy?"

If the answer is yes, the user bought every product.

Read the Entire Query Like English
SELECT *
FROM users u
WHERE NOT EXISTS
(
     SELECT *
     FROM products p
     WHERE NOT EXISTS
     (
          SELECT *
          FROM orders o
          WHERE o.user_id=u.user_id
          AND o.product_id=p.product_id
     )
)

Translate it literally:

Return the user if there does not exist any product for which there does not exist an order by that user.

Or, more naturally:

Return users who have no missing products.

This "double negative" (NOT EXISTS inside another NOT EXISTS) is exactly what makes the query express "for every product" using standard SQL.
*/
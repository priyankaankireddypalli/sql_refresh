
CREATE TABLE acquisition(
	account_number INT,
	store VARCHAR(50),
	card_type VARCHAR(20),
	district VARCHAR(50),
	region VARCHAR(50),
	city VARCHAR(50),
	application_submitted_date DATE,
	status_changed_date DATE,
	billing_date DATE
);

INSERT INTO acquisition
(account_number, store, card_type, district, region, city,
 application_submitted_date, status_changed_date, billing_date)
VALUES
-- Normal Records
(1001, 'Store A', 'Gold',     'D1', 'North', 'Delhi',     '2024-01-05', '2024-01-10', '2024-02-01'),
(1002, 'Store B', 'Silver',   'D2', 'South', 'Chennai',   '2024-01-08', '2024-01-12', '2024-02-05'),
(1003, 'Store C', 'Platinum', 'D3', 'East',  'Kolkata',   '2024-01-15', '2024-01-20', '2024-02-10'),
(1004, 'Store A', 'Gold',     'D1', 'North', 'Delhi',     '2024-02-01', '2024-02-06', '2024-03-01'),
(1005, 'Store D', 'Silver',   'D4', 'West',  'Mumbai',    '2024-02-10', '2024-02-15', '2024-03-05'),
(1006, 'Store E', 'Gold',     'D5', 'South', 'Bengaluru', '2024-02-12', '2024-02-18', '2024-03-10'),
(1007, 'Store C', 'Platinum', 'D3', 'East',  'Kolkata',   '2024-03-01', '2024-03-05', '2024-04-01'),
(1008, 'Store B', 'Silver',   'D2', 'South', 'Chennai',   '2024-03-10', '2024-03-15', '2024-04-05'),

-- Duplicate Account (same account appears twice)
(1002, 'Store B', 'Silver',   'D2', 'South', 'Chennai',   '2024-01-08', '2024-01-12', '2024-02-05'),

-- Exact Duplicate Row
(1005, 'Store D', 'Silver',   'D4', 'West',  'Mumbai',    '2024-02-10', '2024-02-15', '2024-03-05'),

-- NULL card type
(1009, 'Store F', NULL, 'D6', 'North', 'Jaipur',
 '2024-04-01', '2024-04-05', '2024-05-01'),

-- NULL Store
(1010, NULL, 'Gold', 'D7', 'West', 'Pune',
 '2024-04-03', '2024-04-08', '2024-05-05'),

-- NULL Region
(1011, 'Store G', 'Silver', 'D8', NULL, 'Hyderabad',
 '2024-04-05', '2024-04-10', '2024-05-08'),

-- NULL City
(1012, 'Store H', 'Gold', 'D9', 'South', NULL,
 '2024-04-08', '2024-04-12', '2024-05-10'),

-- Pending Application (status & billing missing)
(1013, 'Store I', 'Platinum', 'D10', 'East', 'Bhubaneswar',
 '2024-04-10', NULL, NULL),

-- Missing Billing Date
(1014, 'Store J', 'Silver', 'D11', 'North', 'Lucknow',
 '2024-04-12', '2024-04-18', NULL),

-- Missing Application Date
(1015, 'Store K', 'Gold', 'D12', 'West', 'Ahmedabad',
 NULL, '2024-04-20', '2024-05-20'),

-- All Nullable Columns NULL
(1016, NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL),

-- Same Customer Different Store
(1001, 'Store Z', 'Gold', 'D13', 'North', 'Delhi',
 '2024-05-01', '2024-05-05', '2024-06-01');

CREATE TABLE transactions(
	transaction_id INT,
	account_number INT,
	transaction_amount DECIMAL(10,2),
	transaction_date DATE,
	posting_date DATE,
	transaction_status VARCHAR(20),
	card_type VARCHAR(20),
	merchant_id INT
);


INSERT INTO transactions
(transaction_id, account_number, transaction_amount,
 transaction_date, posting_date, transaction_status,
 card_type, merchant_id)
VALUES
-- Normal Transactions
(1,1001,500.00,'2024-02-05','2024-02-06','Success','Gold',101),
(2,1001,750.00,'2024-02-15','2024-02-16','Success','Gold',102),
(3,1002,200.00,'2024-02-08','2024-02-09','Success','Silver',101),
(4,1002,1000.00,'2024-03-10','2024-03-11','Declined','Silver',103),
(5,1003,1500.00,'2024-02-20','2024-02-21','Success','Platinum',104),
(6,1003,300.00,'2024-03-15','2024-03-16','Success','Platinum',102),
(7,1004,450.00,'2024-03-05','2024-03-06','Success','Gold',101),
(8,1005,800.00,'2024-03-20','2024-03-21','Success','Silver',105),
(9,1006,1200.00,'2024-03-25','2024-03-26','Success','Gold',104),
(10,1007,950.00,'2024-04-10','2024-04-11','Success','Platinum',103),
(11,1008,400.00,'2024-04-15','2024-04-16','Declined','Silver',105),
(12,1001,900.00,'2024-04-20','2024-04-21','Success','Gold',104),

-- Duplicate Transaction (same details)
(13,1001,900.00,'2024-04-20','2024-04-21','Success','Gold',104),

-- Same account, same day
(14,1002,200.00,'2024-02-08','2024-02-09','Success','Silver',101),

-- NULL Amount
(15,1003,NULL,'2024-04-25','2024-04-26','Success','Platinum',102),

-- NULL Merchant
(16,1004,600.00,'2024-04-27','2024-04-28','Success','Gold',NULL),

-- NULL Card Type
(17,1005,350.00,'2024-05-01','2024-05-02','Success',NULL,105),

-- NULL Status
(18,1006,700.00,'2024-05-02','2024-05-03',NULL,'Gold',106),

-- Pending Posting
(19,1007,800.00,'2024-05-05',NULL,'Success','Platinum',103),

-- Unknown Account (not in acquisition)
(20,9999,1000.00,'2024-05-06','2024-05-07','Success','Gold',107),

-- Zero Amount
(21,1008,0.00,'2024-05-08','2024-05-09','Success','Silver',108),

-- Refund / Negative Amount
(22,1001,-200.00,'2024-05-09','2024-05-10','Refund','Gold',101),

-- Future Transaction
(23,1002,1200.00,'2025-01-10','2025-01-11','Success','Silver',102);


CREATE TABLE sales(
	transaction_id INT,
	transaction_amount DECIMAL(10,2),
	transaction_date DATE,
	merchant_name VARCHAR(100),
	instore_sales DECIMAL(10,2),
	online_sales DECIMAL(10,2)

);

INSERT INTO sales
(transaction_id,
 transaction_amount,
 transaction_date,
 merchant_name,
 instore_sales,
 online_sales)
VALUES
(1,500.00,'2024-02-05','Amazon',0.00,500.00),
(2,750.00,'2024-02-15','Walmart',750.00,0.00),
(3,200.00,'2024-02-08','Amazon',0.00,200.00),
(4,1000.00,'2024-03-10','Target',1000.00,0.00),
(5,1500.00,'2024-02-20','Apple',0.00,1500.00),
(6,300.00,'2024-03-15','Walmart',300.00,0.00),
(7,450.00,'2024-03-05','Amazon',450.00,0.00),
(8,800.00,'2024-03-20','Nike',0.00,800.00),
(9,1200.00,'2024-03-25','Apple',1200.00,0.00),
(10,950.00,'2024-04-10','Target',0.00,950.00),
(11,400.00,'2024-04-15','Nike',400.00,0.00),
(12,900.00,'2024-04-20','Amazon',0.00,900.00),

-- Duplicate Sale
(13,900.00,'2024-04-20','Amazon',0.00,900.00),

-- NULL Merchant
(14,200.00,'2024-02-08',NULL,200.00,0.00),

-- NULL Amount
(15,NULL,'2024-04-25','Apple',0.00,NULL),

-- NULL Online Sales
(16,600.00,'2024-04-27','Flipkart',600.00,NULL),

-- NULL In-store Sales
(17,350.00,'2024-05-01','Amazon',NULL,350.00),

-- Both Sales NULL
(18,700.00,'2024-05-02','Reliance',NULL,NULL),

-- Zero Sales
(19,0.00,'2024-05-05','Myntra',0.00,0.00),

-- Refund
(22,-200.00,'2024-05-09','Amazon',-200.00,0.00),

-- Orphan Transaction ID (doesn't exist in transactions)
(999,1500.00,'2024-05-10','Apple',1500.00,0.00),

-- Future Sale
(23,1200.00,'2025-01-10','Walmart',1200.00,0.00);

SELECT * FROM acquisition
SELECT * FROM transactions
SELECT * FROM sales


/* Q1. Customer transaction mapping

A banking analyst wants to understand how many customers who applied for a card have actually started using it.
KPI: 1.total acquired customers 2. customes with atleast one transaction
*/

SELECT COUNT(DISTINCT a.account_number) as total_customers, COUNT(DISTINCT t.account_number) as active_customers
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number

SELECT DISTINCT(a.account_number)
FROM acquisition a 
WHERE EXISTS ( SELECT 1
FROM transactions t
WHERE t.account_number = a.account_number)

SELECT SUM(t.transaction_amount) as total_sales
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number

/* 2. Store wise transaction activity
The business team wants to evaluate which stores are driving actual card usage after aquistion.

Join acqusition and transactions to show store, number of transactions, total transaction amount
KPI: store performing post onboarding
*/

SELECT a.store, COUNT(*) as total_transactions, SUM(t.transaction_amount) as total_transaction_amt
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number
GROUP BY a.store


/* for a given region, how many instore_sales and online_sales and transaction_status*/

SELECT a.region, SUM(s.instore_sales), SUM(s.online_sales)
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number
LEFT JOIN sales s
ON t.transaction_id = s.transaction_id
GROUP BY a.region

/* 4. The risk team wants to compare usage between credit vs debit cards 
show total transactions and total amount by card_type */
SELECT a.card_type, COUNT(*) as total_transactions, SUM(t.transaction_amount) as total_transaction_amt
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number
GROUP BY a.card_type


/* 5. Transactions to sales mapping
Finance team wants to ensure that every transaction is reflected in the sales system 
Join transactions and sales to display:
Transaction ID, Transaction amount(from both tables), merchant name) 
KPI: data consistency between systems*/


SELECT t.transaction_id, s.transaction_id, t.transaction_amount, s.transaction_amount, s.merchant_name
FROM transactions t
LEFT JOIN sales s
ON t.transaction_id = s.transaction_id


/* 6.Missing sales records
Some transactions might not be recorded in the sales system due to delays or failures.
Identify transactions that exist in transactions table but are missing in sales.
KPI: data reconcillation gaps */

SELECT *
FROM transactions t
WHERE NOT EXISTS (
    SELECT 1 FROM sales s
    WHERE t.transaction_id = s.transaction_id
)

SELECT *
FROM transactions t
LEFT JOIN sales s
ON t.transaction_id = s.transaction_id
WHERE s.transaction_id IS NULL;

SELECT * 
FROM transactions t
WHERE transaction_id NOT IN (SELECT DISTINCT(transaction_id) FROM sales)

/* 6. customer spend journey
The business wants to track customer journey from application - transactions - sales
Join all 3 tables and show
1. account number
2. application date
3. first transaction date
4. total sales amount
KPI: 

*/

SELECT a.account_number, a.application_submitted_date,MIN(t.transaction_date) as first_transaction_date, SUM(t.transaction_amount) as total_sales
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number
GROUP BY a.account_number, a.application_submitted_date

-- can use group by or case when statement
SELECT t.transaction_status, SUM(t.transaction_amount) as total_sales
FROM acquisition a
LEFT JOIN transactions t
ON a.account_number = t.account_number
GROUP BY t.transaction_status

SELECT
    SUM(CASE WHEN transaction_status = 'Success'
             THEN transaction_amount ELSE 0 END) AS success_amount,

    SUM(CASE WHEN transaction_status = 'Declined'
             THEN transaction_amount ELSE 0 END) AS declined_amount,

    SUM(CASE WHEN transaction_status = 'Refund'
             THEN transaction_amount ELSE 0 END) AS refund_amount,

    SUM(CASE WHEN transaction_status IS NULL
             THEN transaction_amount ELSE 0 END) AS null_status_amount
FROM transactions




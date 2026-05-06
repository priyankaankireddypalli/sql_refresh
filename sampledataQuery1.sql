-- ============================================================
-- SHOPINDIA · sales_orders · 50 rows
-- Run in MySQL / PostgreSQL / MariaDB
-- ============================================================
CREATE DATABASE IF NOT EXISTS shopindia;
USE shopindia;

DROP TABLE IF EXISTS sales_orders;

CREATE TABLE sales_orders (
  order_id        INT            PRIMARY KEY,
  customer_name   VARCHAR(100)  NOT NULL,
  product_name    VARCHAR(150)  NOT NULL,
  category        VARCHAR(50),
  sub_category    VARCHAR(80),
  quantity        INT,
  unit_price      DECIMAL(10,2),
  total_amount    DECIMAL(10,2),
  order_date      DATE,
  city            VARCHAR(60),
  state           VARCHAR(60),
  status          VARCHAR(20),
  payment_method  VARCHAR(30),
  sales_rep       VARCHAR(100)
);

INSERT INTO sales_orders VALUES
(1001,'Priya Sharma','iPhone 15 128GB','Electronics','Mobiles',1,79000.00,79000.00,'2024-01-05','Mumbai','MH','Delivered','Credit Card','Amit Verma'),
(1002,'Rahul Gupta','Nike Air Max 270','Sports','Footwear',2,9500.00,19000.00,'2024-01-07','Delhi','DL','Delivered','UPI','Sneha Roy'),
(1003,'Meera Nair','Prestige Induction Cooker','Home','Kitchen',1,4200.00,4200.00,'2024-01-08','Bangalore','KA','Pending','COD','Vikram Das'),
(1004,'Arjun Reddy','Harry Potter Box Set','Books','Fiction',3,1400.00,4200.00,'2024-01-10','Hyderabad','TS','Delivered','UPI','Sneha Roy'),
(1005,'Sunita Patel','Levis 501 Jeans','Clothing','Bottoms',2,3500.00,7000.00,'2024-01-12','Ahmedabad','GJ','Cancelled','Credit Card','Amit Verma'),
(1006,'Karthik Iyer','MacBook Air M2','Electronics','Laptops',1,114900.00,114900.00,'2024-01-15','Chennai','TN','Delivered','Net Banking','Priya Menon'),
(1007,'Ananya Roy','Yoga Mat Premium','Sports','Fitness',1,1800.00,1800.00,'2024-01-18','Kolkata','WB','Delivered','UPI','Vikram Das'),
(1008,'Vikram Singh','Samsung 55 inch QLED TV','Electronics','Televisions',1,68000.00,68000.00,'2024-02-01','Jaipur','RJ','Pending','Net Banking','Amit Verma'),
(1009,'Priya Sharma','The Alchemist','Books','Self-Help',2,299.00,598.00,'2024-02-03','Mumbai','MH','Delivered','UPI','Amit Verma'),
(1010,'Deepa Menon','Kurti Embroidered Cotton','Clothing','Ethnic Wear',3,1200.00,3600.00,'2024-02-07','Kochi','KL','Delivered','COD','Priya Menon'),
(1011,'Rohan Mehta','OnePlus Nord 3','Electronics','Mobiles',1,33999.00,33999.00,'2024-02-10','Mumbai','MH','Delivered','Credit Card','Amit Verma'),
(1012,'Kavita Rao','Non-Stick Cookware Set','Home','Kitchen',1,2800.00,2800.00,'2024-02-12','Bangalore','KA','Delivered','UPI','Vikram Das'),
(1013,'Suresh Nair','Adidas Running T-Shirt','Sports','Apparel',2,1500.00,3000.00,'2024-02-15','Chennai','TN','Delivered','UPI','Priya Menon'),
(1014,'Pooja Joshi','Atomic Habits','Books','Self-Help',1,499.00,499.00,'2024-02-18','Pune','MH','Delivered','COD','Amit Verma'),
(1015,'Ravi Kumar','Philips Air Fryer','Home','Appliances',1,5999.00,5999.00,'2024-02-20','Delhi','DL','Cancelled','Credit Card','Sneha Roy'),
(1016,'Lakshmi Devi','Silk Saree Banarasi','Clothing','Ethnic Wear',1,8500.00,8500.00,'2024-03-02','Hyderabad','TS','Delivered','Net Banking','Sneha Roy'),
(1017,'Aman Khanna','Noise SmartWatch Pro','Electronics','Wearables',1,4999.00,4999.00,'2024-03-05','Delhi','DL','Returned','UPI','Sneha Roy'),
(1018,'Nisha Gupta','Dumbbell Set 20kg','Sports','Fitness',1,3200.00,3200.00,'2024-03-08','Kolkata','WB','Delivered','COD','Vikram Das'),
(1019,'Dinesh Pillai','Rich Dad Poor Dad','Books','Finance',2,350.00,700.00,'2024-03-10','Kochi','KL','Delivered','UPI','Priya Menon'),
(1020,'Reena Shah','Cotton Curtains Pair','Home','Furnishing',2,1800.00,3600.00,'2024-03-14','Ahmedabad','GJ','Delivered','COD','Amit Verma'),
(1021,'Meera Nair','Samsung Galaxy S24','Electronics','Mobiles',1,74999.00,74999.00,'2024-03-18','Bangalore','KA','Delivered','Credit Card','Vikram Das'),
(1022,'Priya Sharma','Levi Slim Fit Shirt','Clothing','Shirts',2,2200.00,4400.00,'2024-03-22','Mumbai','MH','Delivered','UPI','Amit Verma'),
(1023,'Rahul Gupta','Yoga Block Set','Sports','Fitness',2,899.00,1798.00,'2024-04-02','Delhi','DL','Delivered','UPI','Sneha Roy'),
(1024,'Arjun Reddy','Sony WH-1000XM5 Headphones','Electronics','Audio',1,26999.00,26999.00,'2024-04-05','Hyderabad','TS','Delivered','Net Banking','Sneha Roy'),
(1025,'Karthik Iyer','Wings of Fire APJ','Books','Biography',1,299.00,299.00,'2024-04-08','Chennai','TN','Delivered','COD','Priya Menon'),
(1026,'Sunita Patel','Microwave Oven 25L','Home','Appliances',1,8999.00,8999.00,'2024-04-11','Ahmedabad','GJ','Delivered','Credit Card','Amit Verma'),
(1027,'Deepa Menon','Zara Floral Dress','Clothing','Western Wear',1,4500.00,4500.00,'2024-04-15','Kochi','KL','Cancelled','Credit Card','Priya Menon'),
(1028,'Vikram Singh','Cricket Bat SS Ton','Sports','Cricket',1,4200.00,4200.00,'2024-04-18','Jaipur','RJ','Delivered','UPI','Amit Verma'),
(1029,'Rohan Mehta','Dell 27 inch Monitor','Electronics','Monitors',1,22999.00,22999.00,'2024-05-02','Mumbai','MH','Delivered','Net Banking','Amit Verma'),
(1030,'Kavita Rao','The Psychology of Money','Books','Finance',2,449.00,898.00,'2024-05-05','Bangalore','KA','Delivered','UPI','Vikram Das'),
(1031,'Nisha Gupta','Bosch Washing Machine 7kg','Home','Appliances',1,32999.00,32999.00,'2024-05-10','Kolkata','WB','Delivered','Net Banking','Vikram Das'),
(1032,'Aman Khanna','H&M Slim Chinos','Clothing','Bottoms',2,2800.00,5600.00,'2024-05-12','Delhi','DL','Delivered','UPI','Sneha Roy'),
(1033,'Pooja Joshi','Badminton Racket Yonex','Sports','Badminton',2,3500.00,7000.00,'2024-05-15','Pune','MH','Delivered','COD','Amit Verma'),
(1034,'Dinesh Pillai','Kindle Paperwhite','Electronics','E-Readers',1,13999.00,13999.00,'2024-05-20','Kochi','KL','Delivered','Credit Card','Priya Menon'),
(1035,'Reena Shah','Saree Georgette Print','Clothing','Ethnic Wear',2,2200.00,4400.00,'2024-06-01','Ahmedabad','GJ','Returned','COD','Amit Verma'),
(1036,'Lakshmi Devi','Protein Powder 2kg','Sports','Nutrition',1,2199.00,2199.00,'2024-06-05','Hyderabad','TS','Delivered','UPI','Sneha Roy'),
(1037,'Suresh Nair','Ceiling Fan Havells','Home','Electricals',2,3500.00,7000.00,'2024-06-08','Chennai','TN','Delivered','UPI','Priya Menon'),
(1038,'Priya Sharma','iPad Air 5th Gen','Electronics','Tablets',1,59900.00,59900.00,'2024-07-03','Mumbai','MH','Delivered','Credit Card','Amit Verma'),
(1039,'Rahul Gupta','Sapiens Book','Books','History',1,599.00,599.00,'2024-07-07','Delhi','DL','Delivered','COD','Sneha Roy'),
(1040,'Meera Nair','Towel Set Cotton','Home','Bath',3,800.00,2400.00,'2024-07-10','Bangalore','KA','Cancelled','UPI','Vikram Das'),
(1041,'Arjun Reddy','Adidas Football Size 5','Sports','Football',2,1200.00,2400.00,'2024-07-14','Hyderabad','TS','Delivered','UPI','Sneha Roy'),
(1042,'Karthik Iyer','Logitech MX Keys Keyboard','Electronics','Peripherals',1,9995.00,9995.00,'2024-08-01','Chennai','TN','Delivered','Net Banking','Priya Menon'),
(1043,'Kavita Rao','Denim Jacket H&M','Clothing','Jackets',1,3200.00,3200.00,'2024-08-05','Bangalore','KA','Delivered','Credit Card','Vikram Das'),
(1044,'Vikram Singh','Zero to One Book','Books','Business',1,499.00,499.00,'2024-08-10','Jaipur','RJ','Delivered','COD','Amit Verma'),
(1045,'Deepa Menon','Mixer Grinder 750W','Home','Kitchen',1,3499.00,3499.00,'2024-09-01','Kochi','KL','Delivered','UPI','Priya Menon'),
(1046,'Rohan Mehta','OnePlus Bullets Earphones','Electronics','Audio',1,1799.00,1799.00,'2024-09-05','Mumbai','MH','Cancelled','UPI','Amit Verma'),
(1047,'Nisha Gupta','Swimming Goggles Speedo','Sports','Swimming',1,1299.00,1299.00,'2024-09-10','Kolkata','WB','Delivered','COD','Vikram Das'),
(1048,'Aman Khanna','Cotton Bed Sheet King','Home','Bedding',2,1500.00,3000.00,'2024-10-05','Delhi','DL','Delivered','UPI','Sneha Roy'),
(1049,'Pooja Joshi','Kurti Printed Daily','Clothing','Ethnic Wear',3,900.00,2700.00,'2024-11-01','Pune','MH','Delivered','COD','Amit Verma'),
(1050,'Suresh Nair','GoPro Hero 12','Electronics','Cameras',1,39999.00,39999.00,'2024-12-01','Chennai','TN','Delivered','Credit Card','Priya Menon');

SELECT * FROM sales_orders;

-- Verify: should return 50
SELECT COUNT(*) AS total_rows FROM sales_orders;

-- Quick summary check
SELECT category, COUNT(*) AS orders, SUM(total_amount) AS revenue
FROM sales_orders
GROUP BY category
ORDER BY revenue DESC;
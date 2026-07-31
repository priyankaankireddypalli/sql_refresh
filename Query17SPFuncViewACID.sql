CREATE DATABASE MiniAmazon;

USE MiniAmazon;
-- MY SQL
CREATE TABLE Products(
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARHCAR(100),
	Price INT,
	Stock INT
);

CREATE TABLE Orders (
	OrderId INT PRIMARY KEY AUTO_INCREMENT,
	ProductId INT,
	Quantity INT,
	TotalAmount INT
	
);

-- SQL SERVER
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Price INT,
    Stock INT
);

CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT,
    Quantity INT,
    TotalAmount INT,
    FOREIGN KEY (ProductId) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductName, Price, Stock)
VALUES
('Laptop', 800, 50),
('Mouse', 20, 200),
('Keyboard', 45, 150),
('Monitor', 250, 80),
('Headphones', 75, 120);


SELECT * FROM Products
/*
INSERT INTO Orders (ProductId, Quantity, TotalAmount)
VALUES
(1, 2, 1600),
(2, 5, 100),
(3, 3, 135),
(4, 1, 250),
(5, 2, 150),
(1, 1, 800),
(2, 10, 200),
(3, 4, 180),
(5, 3, 225);
*/
-- STORED PROCEDURE

-- MY SQL

DELIMITER $$

CREATE PROCEDURE DisplayProducts()
BEGIN
    SELECT * FROM Products;
END $$

DELIMITER ;

CALL DisplayProducts();

-- SQL SERVER

CREATE PROCEDURE DisplayProduct
AS
BEGIN
    SELECT *
    FROM Products;
END;
GO

EXEC DisplayProduct;


-- Display product id = 1
SELECT * FROM Products WHERE ProductID = 1

-- Display product id = 2
SELECT * FROM Products WHERE ProductID = 2

-- instead of writing it again and again, use parameterised 

ALTER PROCEDURE DisplayProduct
    @id INT
AS
BEGIN
    SELECT * FROM Products
    WHERE ProductID = @id
END;
GO

EXEC DisplayProduct @id = 1;


-- STORED PROCEDURES:

/* SQL QUERIES - To perform the same operation multiple times, we create a procedure and execute it. */

CREATE PROCEDURE InsertOrders
    @product_id INT,
    @quantity INT,
    @amount INT
AS
BEGIN
    INSERT INTO Orders
    VALUES (@product_id, @quantity, @amount)
    
END;
GO

SELECT * FROM Orders
EXEC InsertOrders 1, 2, 1600;
SELECT * FROM Orders



SELECT * FROM Products


CREATE PROCEURE StockUpdate
    @product_id INT,
    @quantity INT
AS 
BEGIN
    UPDATE Products
    SET Stock = Stock-@quantity
    WHERE ProductID = @product_id;
END;
GO

-- stock is not updated once an order is placed. So write an procedure to handle that

-- MANUALLY OR HARD CODED
SELECT * FROM Products
UPDATE Products
SET Stock = Stock - 2
WHERE ProductID = 1

-- LETS CREATE A PROCEDURE TO UPDATE ORDER TABLE AND AT THE SAME TIME TO UPDATE THE STOCK AS WELL using parameters
-- Parameters are passed into a stored procedure by the caller.

CREATE PROCEDURE InsertOrdersAndUpdateProducts
    @product_id INT,
    @quantity INT,
    @amount INT
AS
BEGIN
    INSERT INTO Orders
    VALUES (@product_id, @quantity, @amount);

    UPDATE Products
    SET Stock = Stock-@quantity
    WHERE ProductID = @product_id;
END;
GO

-- BEFORE UPDATE
SELECT * FROM Orders
SELECT * FROM Products
EXEC InsertOrdersAndUpdateProducts 2,5,100







INSERT INTO Orders (ProductId, Quantity, TotalAmount)
VALUES
(1, 2, 1600),
(2, 5, 100),
(3, 3, 135),
(4, 1, 250),
(5, 2, 150),
(1, 1, 800),
(2, 10, 200),
(3, 4, 180),
(5, 3, 225);


-- ADD VARIABLES: Variables are declared and used inside the stored procedure.
-- VALIDATION ( If there is stock present, only then order can be placed

CREATE PROCEDURE OrdersAndAmountAndStock
    @product_id INT,
    @quantity INT
AS
BEGIN
    DECLARE @v_price INT;
    DECLARE @v_stock INT;

    SELECT
        @v_stock = Stock,
        @v_price = Price
    FROM Products
    WHERE ProductID = @product_id;

    IF @v_stock >= @quantity
    BEGIN
        INSERT INTO Orders (ProductId, Quantity, TotalAmount)
        VALUES (@product_id, @quantity, @v_price * @quantity);

        UPDATE Products
        SET Stock = Stock - @quantity
        WHERE ProductID = @product_id;
        SELECT 'Order Success' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Insufficient Stock' AS Message;
    END
END;
GO

EXEC OrdersAndAmountAndStock 3, 3


-- ADD COMMIT AND ROLLBACK TRANSACTION
-- FOR ONLY DML COMMANDS COMMIT AND ROLLBACK TRANSACTION IS APPLIED
-- ROLL BACK AND ERROR FAIL MESSAGE USING TRY CATCH(ROLL BACK ENTIRE OPERATION IF ANYTHING GETS FAILED)

CREATE PROCEDURE OrdersAndAmountAndStock
    @product_id INT,
    @quantity INT
AS
BEGIN
    DECLARE @v_price INT;
    DECLARE @v_stock INT;

    SELECT
        @v_stock = Stock,
        @v_price = Price
    FROM Products
    WHERE ProductID = @product_id;

    IF @v_stock < @quantity
    BEGIN
        SELECT 'Insufficient Stock' AS Message;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Orders (ProductId, Quantity, TotalAmount)
        VALUES (@product_id, @quantity, @v_price * @quantity);

        UPDATE Products
        SET Stock = Stock - @quantity
        WHERE ProductID = @product_id;

        COMMIT TRANSACTION;

        SELECT 'Order Success' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
GO



-- VIEW: VIRTUAL TABLES
-- SP
-- DIFFERENCE?
-- VIEW IS FOR REPORTING PURPOSE(retrieve only required data) (ONLY SELECT)
-- STORED PROCEURE - BUSINESS LOGIC operations (INSERT, UPDATE, DELETE, SELECT), returns a result set or table.

-- SQL FUNCTIONS (CALCULATION PURPOSES WE USE FUNCTIONS), returns single value
-- DISCOUNT ON PRODUCT 

CREATE FUNCTION dbo.GetFullName
(
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
)
RETURNS VARCHAR(101)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;


CREATE FUNCTION functionname
(
@FirstName VARCHAR(20)
@LastName VARCHAR(20)
) RETURNS VARCHAR(100)
AS
BEGIN
RETURN @FirstName + ' ' + @LastName

END;


-- If a user orders more than 2 product, then i want to apply 10% discount

CREATE FUNCTION applydis
(
    @Price INT,
    @Quantity INT
)
RETURNS INT
AS
BEGIN
    DECLARE @v_total INT;
    DECLARE @v_discount INT;
    DECLARE @v_finalAmount INT;

    SET @v_total = @Price * @Quantity;

    IF @Quantity >= 2
    BEGIN
        SET @v_discount = @v_total * 10 / 100;
    END
    ELSE
    BEGIN
        SET @v_discount = 0;
    END

    SET @v_finalAmount = @v_total - @v_discount;

    RETURN @v_finalAmount;
END;
GO
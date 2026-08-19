
CREATE TABLE Emp (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);



INSERT INTO Emp (EmpID, FirstName, LastName, Gender, Department, Salary, HireDate, Email, Phone)
VALUES
(101, 'John', 'Doe', 'M', 'IT', 65000.00, '2023-01-15', 'john.doe@example.com', '9876543210'),
(102, 'Jane', 'Smith', 'F', 'HR', 55000.00, '2022-08-20', 'jane.smith@example.com', '9876543211'),
(103, 'David', 'Wilson', 'M', 'Finance', 72000.00, '2021-06-10', 'david.wilson@example.com', '9876543212'),
(104, 'Emily', 'Brown', 'F', 'Marketing', 60000.00, '2024-02-05', 'emily.brown@example.com', '9876543213'),
(105, 'Michael', 'Johnson', 'M', 'IT', 80000.00, '2020-11-12', 'michael.johnson@example.com', '9876543214');


CREATE PROCEDURE display
@id INT
AS 
BEGIN 
( SELECT * FROM Emp
WHERE EmpID = @id)
END


CREATE PROCEDURE empinsert
    @EmpID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender CHAR(1),
    @Department VARCHAR(50),
    @Salary DECIMAL(10,2),
    @HireDate DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(15)
AS
BEGIN
INSERT INTO Emp (EmpID, FirstName, LastName, Gender, Department, Salary, HireDate, Email, Phone) 
VALUES (@EmpID, @FirstName,@LastName, @Gender, @Department, @Salary, @HireDate, @Email, @Phone)
END;


SELECT * FROM emp

CREATE TABLE audit_log(
load_id INT IDENTITY(1,1) PRIMARY KEY,
tablename VARCHAR(50),
loadstatus VARCHAR(50),
dataread VARCHAR(50),
errorid VARCHAR(50),
errormessage VARCHAR(50)
)

CREATE PROCEDURE audit_loadstatus
@table_name VARCHAR(50),
@loadstatus VARCHAR(50),
@dataread VARCHAR(50),
@errorid VARCHAR(50),
@errormessage VARCHAR(50)
AS 
BEGIN
    INSERT INTO audit_log (tablename,loadstatus, dataread,errorid,errormessage)
    VALUES (@table_name,@loadstatus, @dataread,@errorid,@errormessage)
END

SELECT * FROM audit_log
SELECT * FROM Emp

DROP TABLE config_metadatadriven

CREATE TABLE config_metadatadriven(
query VARCHAR(MAX)
)

INSERT INTO config_metadatadriven
VALUES ('SELECT * FROM dbo.Emp WHERE HireDate LIKE ''2024%''')

SELECT * FROM dbo.Emp WHERE HireDate LIKE '2024%'

UPDATE config_metadatadriven
SET query = 'SELECT * FROM dbo.Emp WHERE HireDate LIKE ''2020%'''
SELECT * FROM config_metadatadriven

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbo'
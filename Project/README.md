SQL server table - orders, products, sellers
rest api - product_category_name_translatiom
snowflake table - order_items
bulk upload (ADLS place) - geolocation
SFTP - customers
csv - order_payments
excel - order_reviews
json - 1 sample

ADF - Data Ingestion
ADLS RAW - all sources are copied and converted to parquet.
Creation of resources in Azure
1. create a resource group (project_enhanced_dev)
2. Assign the services under the resouce group - adf(projectenhancedadf-dev), adls gen2(raw)-projectenhancedadlsdev ,adls gen2(src)- prjenhancedadlsdevsrc, blob,databricks
3. create a sql server - 
    server name - projectenhsqlserverdev
    SQL server authentication
    admin name - priya
    password - lohith@21

    create database - projectenhdbdev
    tables - trigger, job, job details, log details

4. SQL BACKEND TABLES - to make the pipeline metadriven
Note: ifconnection issue occurs when trying to access database,
GO to server > security > networking > allow selected networks , add your ip client, allow azure services and resources to this server.
-- Back End tables
-- 1. Trigger tables - schedule, event 
CREATE TABLE dbo.tbl_trigger(
    trigger_id INT identity(1,1) PRIMARY KEY,
    trigger_name VARCHAR(250),
    created_user VARCHAR(50),
    created_date datetime,
    updated_user VARCHAR(50),
    updated_date datetime
);

-- 2. Job : what are different sources, how it will move from source to target, condition
CREATE TABLE dbo.tbl_job(
    jobid INT IDENTITY(1,1) PRIMARY KEY,
    trigger_id INT FOREIGN KEY REFERENCES tbl_trigger(trigger_id),
    l2_switch_type VARCHAR(50),
    l3_switch_type VARCHAR(50),
    l4_switch_type VARCHAR(50),
    created_user VARCHAR(50),
    created_date datetime,
    updated_user VARCHAR(50),
    updated_date datetime
);

-- 3. job details - key and value
CREATE TABLE tbl_job_dtls(
    job_dtls_id INT IDENTITY(1,1) PRIMARY KEY,
    jobid INT FOREIGN KEY REFERENCES tbl_job(jobid),
    dtls_key VARCHAR(100),
    dtls_value VARCHAR(MAX),
    created_user VARCHAR(50),
    created_date datetime,
    updated_user VARCHAR(50),
    updated_date datetime
);

-- 4. load status (log details)
CREATE TABLE dbo.tbl_log_dtls(
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    jobid INT FOREIGN KEY REFERENCES tbl_job(jobid),
    pipeline_id VARCHAR(100),
    job_start_time datetime,
    job_end_time datetime,
    job_status VARCHAR(10),
    error_dtls VARCHAR(MAX),
    created_user VARCHAR(50),
    created_date datetime,
    updated_user VARCHAR(50),
    updated_date datetime
);
-- Insert values into trigger tables
INSERT INTO [dbo].[tbl_trigger] 
    (trigger_name, created_user, created_date,updated_user,updated_date)
VALUES ('Tr_sample_csv','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_excel','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_restApi','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_sql','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_sftp','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_json','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
    ('Tr_sample_bulk','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),   
    ('Tr_sample_snowflake','Priyanka','2025-08-01', 'Priyanka', '2025-08-01')

INSERT INTO [dbo].[tbl_job] (
    trigger_id, l2_switch_type, l3_switch_type, l4_switch_type, created_user, created_date,updated_user,updated_date
) VALUES 
(1, 'CloudStorage','Azure','csv','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(2, 'CloudStorage','Azure','excel','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(3, 'API','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(4, 'sql','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(5, 'sftp','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(6, 'json','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(7, 'bulk','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(8, 'snowflake','','','Priyanka','2025-08-01', 'Priyanka', '2025-08-01')

select * FROM tbl_trigger
select * from tbl_job
-- job details
INSERT INTO [dbo].[tbl_job_dtls](
    jobid,
    dtls_key,
    dtls_value,
    created_user,
    created_date,
    updated_user,
    updated_date
)
VALUES 
(9, 'delimiter',',','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(9, 'sourcelocation','https://projectenhancedadlsdev.dfs.core.windows.net/','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(9, 'sourcefilename','orders_dataset.csv','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(9, 'targetlocation','https://prjenhancedadlsdevsrc.dfs.core.windows.net/','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(9, 'targetdirectoryname','csvcloud','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),

(10, 'sheetname','products_dataset','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(10, 'sourcelocation','https://projectenhancedadlsdev.dfs.core.windows.net/','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(10, 'sourcefilename','products_dataset.csv','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(10, 'targetlocation','https://prjenhancedadlsdevsrc.dfs.core.windows.net/','Priyanka','2025-08-01', 'Priyanka', '2025-08-01'),
(10, 'targetdirectoryname','excelcloud','Priyanka','2025-08-01', 'Priyanka', '2025-08-01')

-- Stored Procedures

-- 1. load status - during job gets started
CREATE PROCEDURE start_log_entry
    @jobid INT,
    @pipeline_id VARCHAR(100)
    AS 
    BEGIN
        INSERT INTO [dbo].[tbl_log_dtls]
        (jobid, pipeline_id, job_start_time, job_status, created_user, created_date, updated_user, updated_date)
        SELECT @jobid, @pipeline_id, GETDATE(), 'Running', system_user, GETDATE(), system_user, GETDATE()
    END

-- 2.  load status - during job gets ended
CREATE PROCEDURE dbo.end_log_entry
    @jobid INT,
    @pipeline_id VARCHAR(100),
    @error VARCHAR(MAX)
    AS 
    BEGIN
        UPDATE [dbo].[tbl_log_dtls]
        SET job_end_time = GETDATE(),
            job_status = CASE WHEN @error IS NULL THEN 'Completed' ELSE 'Failed' END,
            error_dtls = @error
        WHERE jobid = @jobid AND pipeline_id = @pipeline_id
    END

-- 3
CREATE PROCEDURE dbo.get_job_dtls
    @TriggerName VARCHAR(50)
    AS 
    BEGIN
        -- DECLARE @TriggerName VARCHAR(50) = 'Tr_sample_csv'

    DECLARE @cols AS NVARCHAR(MAX),-- variable to store dynamic list of column names
    @query AS NVARCHAR(MAX) -- variable to store dynamic sql query
    
    SET @cols = 
    (
        SELECT STRING_AGG(dtls_key,',') -- Outer select takes that list and combines it into a single string
        FROM (
                SELECT DISTINCT QUOTENAME(dtls_key) AS dtls_key -- inner select gets the list of unique column names
                FROM [dbo].[tbl_trigger] a 
                JOIN [dbo].[tbl_job] b
                ON a.trigger_id = b.trigger_id
                JOIN [dbo].[tbl_job_dtls] c
                ON b.jobid = c.jobid
                WHERE a.trigger_name = @TriggerName
            )str_agg
    )

    SET @query = N'
        SELECT trigger_name, jobid, l2_switch_type, l3_switch_type, l4_switch_type, ' +@cols+N'
        FROM (
            SELECT dtls_value, dtls_key,a.trigger_name, b.job_id, l2_switch_type, l3_switch_type, l4_switch_type
             FROM [dbo].[tbl_trigger] a 
                JOIN [dbo].[tbl_job] b
                ON a.trigger_id = b.trigger_id
                JOIN [dbo].[tbl_job_dtls] c
                ON b.jobid = c.jobid
                WHERE a.trigger_name ='''+ @TriggerName+'''
        )x
        PIVOT
        (

        MAX(dtls_value)
        FOR dtls_key IN ('+ @cols + N') 

        )p'
    EXEC sp_executesql @query;
    END



Sources
1. SFTP source configuration - 
adls gen 2> settings > SFTP > add local user - username and ssh password
username - priyanka
passowrd - +cCZMIqF6CF+NmFix6xuXadSAMJphlqk (generated only once)

connection string - projectenhancedadlsdev.priyanka@projectenhancedadlsdev.blob.core.windows.net

download winSCP
hostname - projectenhancedadlsdev.blob.core.windows.net
user - projectenhancedadlsdev.priyanka
password - copied once

when you try to connect, you might find errors - enable the sftp conenction in adls connections sftp

2.  Snowflake
create snowflake account
username - priyankareddy
password - Lohithreddypriya11

Query to insert rows

CREATE DATABASE IF NOT EXISTS DBAZURESNOW;
CREATE SCHEMA IF NOT EXISTS dbazuresnow.azure_integration;

CREATE OR REPLACE TABLE dbazuresnow.azure_integration.order_items_dataset(
index INT,
order_id VARCHAR(150),
order_item_id INT,
product_id VARCHAR(150),
seller_id VARCHAR(150),
shipping_limit_date DATETIME,
price DECIMAL(10,2),
freight_value DECIMAL(10,2)
);


SELECT * FROM dbazuresnow.azure_integration.order_items_dataset;


INSERT INTO dbazuresnow.azure_integration.order_items_dataset
(
  index,
  order_id,
  order_item_id,
  product_id,
  seller_id,
  shipping_limit_date,
  price,
  freight_value
)
VALUES
(1, 'ORD1001', 1, 'PROD001', 'SELLER01', '2025-09-01 12:00:00', 199.99, 10.50),
(2, 'ORD1002', 1, 'PROD002', 'SELLER02', '2025-09-05 15:30:00', 349.00, 25.00),
(3, 'ORD1002', 2, 'PROD003', 'SELLER03', '2025-09-06 09:15:00', 120.75, 12.25),
(4, 'ORD1003', 1, 'PROD004', 'SELLER01', '2025-09-10 18:00:00', 450.00, 30.00);
----
For more information




SELECT * FROM dbazuresnow.azure_integration.order_items_dataset;


INSERT INTO dbazuresnow.azure_integration.order_items_dataset
(
  index,
  order_id,
  order_item_id,
  product_id,
  seller_id,
  shipping_limit_date,
  price,
  freight_value
)
VALUES
(1, 'ORD1001', 1, 'PROD001', 'SELLER01', '2025-09-01 12:00:00', 199.99, 10.50),
(2, 'ORD1002', 1, 'PROD002', 'SELLER02', '2025-09-05 15:30:00', 349.00, 25.00),
(3, 'ORD1002', 2, 'PROD003', 'SELLER03', '2025-09-06 09:15:00', 120.75, 12.25),
(4, 'ORD1003', 1, 'PROD004', 'SELLER01', '2025-09-10 18:00:00', 450.00, 30.00);

---------------------------------------------
3. excel - order_reviews
4. csv - order_payments
5. JSON - json test sample
6. Bulk - geolocation
7. rest api - category name translation
retool.com > upload csv file > generate an api
- link : https://retoolapi.dev/VfKgCU/data


ADF 
1. copy activity for rest api sources 
source - rest api > base url

2. SQL server migration - orders, products, sellers
copy server name - 

create self hosted integration runtime > step 1: install integration runtime step 2: copy the authentication key

Double click integration runtime > next > install > pass the authentication key, register

Copy activity - sql server name, database name, sql authentication - username and password

3. snowflake 
copy activity - snow flake > account name - account identifier in snowflake
sink - to blob storage, use sas uri authentication
In bob storage container > input container > create a shared access token from settings > generate a token (set an expiry) and permisions 
copy sas token and sas url





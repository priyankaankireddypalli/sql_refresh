A ADF components
1. DEFINE source
2. DEFINE target
3. Connection details

1. Source Datasets - details about the data
2. Linked services
3. Activity - task
4. Linked service to destination
5. Destination datasets

ACTIVITY - specific task
PIPELINE - Combining multiple activities 
INTEGRATION RUNTIMES - compute environment on which activities perform. It is a bridge between dataset and linked service.
TRIGGERS - Automate the pipeline (schedule, tumbling window, event)
DATA FLOW - Transfoming the data (no code)

Pipeline  - collection of activities

3 Type of Activities - what activity does
1. Data Movement Activity - Move data from source to target/sink
2. Data Transformation - Transforms data
3. Control Flow Activities - control the flow of activity (implementing logic)


Data Movement Activities
1. Copy Activity - copying the data from source to target
2. Delete - deleting the file or table 

NOTE: 
General settings - 
    1.name for an activity, 
    2. description of an activity, 
    3. activity state - active or deactive? 
    4. time out - an amount of time the activity will run before it is automatically cancelled by cloud. (Azure) ex: setting time out  to 5 hours. There is a copy activity that takes 7 hours (this activity will be cancelled after 5 hours due to timeout setting)
    can save cost.
    5. Retry - how many times you would like the activity to be attempted again once it fails.
    6. Retry interval(sec) - what should be the interval it waits for after one try. ex: 30 seconds
    once failed, waits for 30 seconds before trying second attempt
    7. Secure input - masking the data that is passed into the activity (like passwords or connecting string)
    8. secure output -  masking the data that is passed out of the activity

NOTE: 
    1. If we have multiple file formats - we can go with binary type 
    When you try to move ZIP files or move different file formats as it is - use binary file format. You cannot preview it(since it just moves data not read it). (just use * wildchar). We cannot perform transformation on such files, since we cannot read it.
    2. Parquet file contains columns without space



concurrency - number of times you want to run the pipeline
Degree of copy parallelism - no of times data loading can be done
FAULT TOLERANCE - any of teh failures to be disregarded
Enable logging - log copied files, skipped files and rows
ENable staging - can store from source to intermediate location
User properties - set up some variables

1. COPY DATA ACTIVITY
Problem 1: Copy/Move a csv file(industry_sic.csv) using copy activity from ADLS - containing two columns
Move the data from one ADLS storage account to another ADLS storage account
1. General 
2. Source - Source ADLS
3. sink - sink ADLS

We need - storage account, datasets, linked_service, IR

Step1: ADLS source storage account - we need to upload the csv file (adfsource)
step2: ADLS sink storage account - move or copy the csv file to ADLS sink storage (adfsink)
step3: Make connection to the souce, destination using linked service
step4: Where we have stored the file? source dataset and sink dataset
step5: Copy activity


Steps to create a storage account?
Azure storage account> data storage> create a containers> for ADLS you can create directories> Upload a file

Difference - enable hierarichal namesapce it is a ADLS Gen2 orelse it is a blob storage.
SOURCE SETTNG's
Step1: source dataset> Where is data stored? Azure, database ... ? > What is the data format? AVRO, ORC, EXCEl, DELIMITED TEXT, PARQUET, XML, JSON....? > name the dataset and description, which linked service you want to use?

step2: Linked service - name, description, integration runtime, authentication type, storage account name and test, created
suthentication type - 1. account key (account key for storage account), 2. SAS URI - shared access token (create a shared access token in your storage account), 3. service principal (connect to different application or services ), 4. system-assigned managed identitity 5. user-assigned managed identity (to connect to resources or service)
step3: file path 
step4: first row as header
step5: import schema - connection/store or from file or none/

In source setting - you specify source dataset, file path type, filter by last modified(select the file based on timestamp in UTC format (helpful for incremental loading)), recursively? - processing the files in the folder recursivily one by one, enable partitions discovery, max conncurrent connections, skip line count, Additional columns (lets say you have 4 columns in source and you want to add another column with the value it requires, here you can do -) in real time scenerio, we add processing time (the time that file was processed.)

Sink Settings
1. sink dataset
2. copy behavior? how you wanted it to be copied. 
trying to copy a folder - choose preserve hierarchy
trying to copy multiple files and merge together, can go for merge files
3. max concurrent connections
4. Block size(MB)
5. Max rows per file


PUBLISH - saving the changes 

Problem 2: Move three csv files from ADLS storage into target location (ADLS storage > sink folder (csv folder))
Only change is in source setting - in file path type select wildcard file path (all the files with csv extension - *.csv or *)




COMMON ERRORS THAT WE GET WHILE WORKING 
1. File Not Found Error
2. Inside File - data corruption (file issue)
3. Linked service - connection or configuration issue.


Integration Runtime-
    Compute infrastructure used by ADF to provide various data integration capabilities across different networks.

There are 3 types of Intergration Runtimes based on source system we are connecting it to.
1. Azure IR or Auto Resolve IR - created by default in ADF is used to connect to Azure services or azure resource.
To key vaults, azure sql databases, azure databricks ....
2. Self hosted IR - trying to connect to a private network (Like onPrem sql database, AWS S3 bucket)
3. Azure SSIS IR - Used to running SSIS packages (SSIS tools) 


Problem 3: Connecting from OnPrem SQL server from Azure and move data
step 1: open microsoft ssms, click on connect option > database engine


If you dont know password 

Login using windows authentication > navigate to  security > logins> select user > server roles and assign all admin access and disconnect and connect using the user.

or check right click and select policies > View > click on general> user mapping > select role membership for the selecteddatabase


PROBLEM: Copy the table as csv file to a ADLS storage location
step 1: copy activity
step 2: source dataset - sql (sql server option), user query - table or query or stored procedure
query timeout (minutes), partition option - used when huge volume of data (physical partitions of table or dynamic range) based on partition column name, partition upper bound, partition lower bound
step 3: linked service - self hosted IR > name, two options are provided
option 1: click to express setup - a file gets downloaded > install it 
option 2: manual set up - 
    Step 1: Download and install integration runtime
    Step 2: Use this key to register your integration runtime


manage > interation runtimes > create self hosted IR 
> server name, database name, authentication type - sql server authentication - username and password, trust certificate, test connection


select Table name
step 4: target dataset 
step 5: linked service - azure

sink setting - file extension (you are expecting)


PROBLEM 6: HOW TO SET UP A PARAMETER (helps in reusing a activity or pipeline (providing a value at run time)) - dynamic variables

At souce setting -
open source dataset > 
    three options 
    1. connection
    2. schema 
    3. Parameters

    dataset parameters
    For tablename from database - it is schemaname.tablename
    In parameters - add 2 parameters
    1st parameter - schemaname 
    2nd parameter - tablename

    In connection 
    remove tablename click enter manually and add dynamic content> select parameters
    @dataset().schemaname 
    @dataset().tablename

In source setting - select the dataset configured

Two dataset properties pop up, can manually type values
i dont want to configure in source setting, i want to be asked when pipeline is triggered (I will use pipeline parameter)
1. Create a pipeline parameters - add pipeline parameters
schema
tablename

copy data activity > source setting > add dynamic content in those value (select Pipeline paramters )

PROBLEM 6: DELETE ACTIVITY - 
used when back dated files or delete something or needs to delete a file after a copy activity.

settings
1. General
2. Source - connecting to files or tables you want to delete (Dataset), delete files recursively
3. Logging settins - enable logging (connect the delete activity to a storage account where you can log the changes (saying you have deleted this files or tables at thos particular time)), connect to storage account (linked service), folder select 

PROBLEM 7: How to copy 1 month or last 7 days 
last modified date between - set up a functions.


To backup files - we cannot perform it in delete activity - we need to take a copy activity and delete or backup process.


if activity fails - you can set up a logging for failed

DATA TRANSFORMATION ACTIVITY - making changes within your data -
data logging, data transformation, data cleaning.
Making your pipeline dynamic.

1. Stored Procedure Activity: 
common use case - run the stored procedure after a copy activity to insert the log activity status (databases)
Mainly for logging and driving a metadata driven system (to retrieve correct metadata)

Two examples
i). Actual logging purpose - 

PROBLEM 1: stored procedure activity
a. general
b. settings - linked service, select stored procedure name, import stored procedure parameters and provide value
c. user properties
ii). simple insert


PROBLEM 2: practical stored procedure activity


2. Azure Functions Activity - serverless compute
There is a service known as function app in azure portal which helps us to write codes/functions or api apps in python it will be run in serverless environment and can execute these codes, like moving files from share point or teams channel to azure storage account and various purposes, or api's to call any applications or to trigger another ADF, or send email notifications.
a. general
b. Settings - linked service, function name, api method






3. Databricks Notebook Activity - 
a. general 
b. azure databricks settings - linked service > workspace url, cluster, access token
c.settings > notebook path - pointing to correct notebook, base parameters - you want to pass the values to databricks, libraries 
Use widgets on databricks side to read the parameters.

4. mapping data flows
5. HDInsight activities
6. Data Wrangling
7. Data Lake Analystics
8. Azure synapse
9. custom activity



3. CONTROL FLOW ACTIVITIES - logic implementation using control flow activities
control your adf, make your pipeline dynamic, fetch value from somewhere, switch between pipelines based on conditions, get fodler location, preview your data, filter your data.

i. Execute pipeline - lets you to execute another pipeline within a pipeline
ii. IF condition activity - if logic
iii. For each activity - (looping) iterates over a collection and executes activities for each item
iv. Until Activity - repeatedly executes activities until a specified condition is met
v. wait activity
vi. execute ssis pacakage activity
vii. switch condition activity
viii. get metadata activity - get the metadata
ix. lookup - get the preview of data


A. LOOKUP ACTIVITY - looks up data from a location you have pointed or connected it to. (limitation on limit of records displayed - 5000)
used to retrieve and process data from a dataset.
ex: Move data from sql table to csv using a config table(that consists of sql queries)
Lookup the values from a different table and based on that query you need to filter the data based on the query retreive
use case: dynamic parameter value, conditional logic, configuration data

a. general settings
b. settings - source dataset, first row only?
c.user properties


B. GET METADATA ACTIVITY - gets metadata (details regarding something)
Makes pipeline dynamic

itemName - file or folder
itemType -type of file or filder
size - size of files in bytes
created - create date time of the file or folder
lastModified - any change (last modified date) of file or folder
childItems - listing out all the files within the folder
contentMD5 - MD5 (hash code of the file - to identify if files are duplicates)
structure - data structure of the file or relational databsae
columnCount - number of columns in the file or table
exists - Whether a file or folder or table exists

a. general
b. settings - dataset (either file or folder or database tables),
 Field list - if dataset points to folder, below are the field list options 
    a. childItems
    b. exists
    c. itemName
    d. itemType
    e. last modifed

    Field list - if dataset points to file, below are the field list options 
    a. column count
    b. content MD5
    c. Exists
    d. itemName
    e. itemType
    f. last modifed
    g. size
    h. Structure

 Field list - if dataset points to sql database tables, below are the field list options 

    a. exists
    c. structure
    d. columnCount
c. user properties

C. FILTER ACTIVITY - used to filter the data based on a condition.
use case: you have 15 files in a folder and requirement is to copy only the files that have sales as a file name in it.

a. general
b. settings - Items, conditions
c. user settings

PROBLEM: filter data from the CSV file based on a condition (@equals(item().stock,'10'))


D. FOR EACH ACTIVITY - iterates for each item from the list and carries out the same task.
a. general
b. settings - sequential, batch count, Items
c. activities
d. user properties

MAXIMUM NUMBER OF PARALLEL ACTIVITIES CAN BE PERFORMED USING FOR EACH ACTIVITY IS 50

E. UNTIL ACTIVITY - iterating until a specified condition is met. 
Ex: file present in particular location?
It will keep on waiting until the file is arrived.

We use to ensure that all the jobs to be executed completed. (SP to retrieve all the job details that needs to be completed or sp is not returning any results.)

a. general
b. settings - Expression(the condition to be met), timeout
c. activities
d. user properties

F. IF ACTIVITY - if a particular condition is met, then do these set of activities or else other set of activities.

use case: send notifications based on job completion status

a.general
b.activities
c.user properties

If - TRUE (activities) ELSE (activities)

G. SWITCH ACTIVITY - conditional branching (case statement in sql or switch in python)
a. general
b. Activities (expression, cases)




H. Execute pipeline - triggers another pipeline from exisiting pipeline
a.general
b.settings - invoked pipeline, wait on completion(check)

I. Set Variable Activity - assign values to variables
a. general
b. settings - variable type (pipeline variable, pipeline return value), Name


PROBLEM:
Implement a pipeline, 
1. check if the file exists
2. If file exists copy the file from source to target
3. If file do not exists, you want it to wait until the file is available and carry out the copy activity
using - until, get metadata, if - copy, set variable


PROBLEM: Copy if a given file exists in the file path, else log as file not found in copy log table
using - get metadata, if -> copy else SP(to log)


PROBLEM: Copy all tables within the schema dbo from SQL database to ADLS location as csv files



Difference between parameter and variable
Parameter - the value that you have passed to parameter will be same through out the entire pipeline.

Whereas variable - value changes and you can update using set variable 


CI/CD?
four environments - Dev, test, qa, prod

You will be having repositories for each of these development works like ADF, Databricks etc.

Within repositories you will have different branches.
prod env - prd branch
qa - qa branch
test - tst branch
you will have numerous branches for dev because you will be able to create multiple branches.
You can have your own working branch

actual development in dev environment and sync it to working branch
changes done in working branch is deployed or moved to other env using devops platforms like github or azure devops.

Github portal:
Create a new repository - DB_dev
ADF - Manage> source control > git configuration > configure > repository type - github, github repository owner - give name and authenticate it
once it is connected, choose the repository name and have a publish branch and have a colloboration branch as well- feature/dev/priya01

save will automatically make the changes to feature branch

IQ. OPTIMISATION IN ADF 
A. partition at the source or during copy activity.
Partitioning option in copy behavior

IQ. No of parallel process can be done in for each activity
50

IQ. how can you monitor in ADF.
Navigate to monitor icon, where all pipeline runs details are displayed.
triggered runs - scheduled, event or tumbling window
Debug runs - debug sessions or manual trigger
if triggered by execute pipeline - it will show pipeline run id.














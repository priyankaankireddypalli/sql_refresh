Apache spark: (distributed processing engine)
Open source data processing engine to store and process data in real time across various clusters of computers using simple programming constructs.

a. spark executes the program 100x times faster in memory and 10x times faster on disk than hadoop.
b. Java, Scala, Python, R

Spark Features
1. In memory computing - RAM
2. Open source - 
3. speed - high
4. Multi language support - python, java, sql, scala, R
5. unified engine - batch processing, streaming processing, machine learning data
6. Spark SQL - allows you to run SQL query on structure data format
7. Real time stream processing 
8. MLIB - built in available
9. scalability - Highly scalable
10. Fault tolerant - executors are designed to be ft(ft - continue operating correctly even when indidual component or ndoe failures, by data replication and task execution) and resilient in failures(recover from failure without disruption or loss of data)
partition - logical chunk of data. if a partition is lost due to node failure then spark Can recompute that partition using lineage graph.
11. Lineage graph 
Lineage graph? - lineage graph consists of logical dependencies between rdd's.
How each rdd is derived from other.


Spark Architecture
1. Driver - co-ordinate the execution of tasks and communicate with the cluster manager to allocate the resources for your spark application. Driver plays the cruical role in managing the over all execution of the spark application.
2. Cluster Manager - responsible for resouce allocation like cpu, memory in cluster. Allocates the resources to driver and executor based on application needs.
There are three types of cluster manager available in spark.
a. stand alone - spark owned cluster (e.g, databricks will itself managed this cluster)
b. YARN (yet another resouce negotiator) - onpremise spark cluster
c. Kubernates - for containerized environment(GCP)
3. Executors in worker nodes - key component of spark runtime architecture because it is responsible for processing the data and executing the code on parallel worker nodes.

spark achieves fault tolerant through data replication and task execution.

task - smallest unit of work send to executor
ex: filter

tasks run in parallel based on number of cores available in executor.
ex: in a executor have 4 cores - can run 4 tasks in parallel, i.e., each core can process one partition at a time.

cluster? multiple machines connected together to form a cluster
each node/machine consists of compute power - cpu, memory and disk.

SPARK EXECUTION FLOW - 
1. submitting my notebook/application in the cluster - internally it creates spark execution
2. cluster manager launches driver
3. driver program compiles the spark code
4. creates a spark session once compilation is success
5. spark session is created and serves as entry point of spark application
at the same time spark code is deivided into series of stages
a. spark creates DAG - Directed Acyclic Graph based on stage and dependecies  (representing logical and physical execution plan for the spark application for parallel processing and optimisation)
b. In your spark code you execute actions - it creates a JOB 
and the jobs are summited to DAG scheduler, the dag scheduler spins stages(based on shuffles) using DAG graph then stages are divided into tasks. These tasks are scheduled in task scheduler and launches tasks via cluster manager, then that task will be summited in worker node. Tasks are runned in parallel on executor side and results are sent back to driver program.

Note: stages are executed in sequential order whereas tasks are executed in parallel

Shuffle - data movement from one executor to another executor
shuffle is a very expensive operations

Spark Transformations
1. Narrow transformation - will not create any shuffles
Ex: map, filter, union
2. Wide transformation - creates more shuffles
ex: join, groupbykey

Spark Actions - trigger the executions of the computations defined by transformations
Ex: Collect(), Take()-rdd , Count(), first(), distinct()

RDD VS Dataframe VS Dataset
RDD - 
a. core data structure of spark
b. resilient distributed dataset
c. Immutable distributed collection of elements
Used in LOW LEVEL OPERATIONS or API (like map,reduce)
unstructured data like text file, no column name until explicitly specified using schema

Dataframe - 
a. Distibuted collection of Row objects
b. data is organised into named columns like a table in a relationa db.
c. Large dataset processing even easier
d. df has schema, which is a metadata for the column
e. Data in df are partitioned
Dataframe has catalyst optimizer - You have a query optimiser avail for df and SQL query to optimise data in terms of memory and computation. hence, df is faster and better
schema error during run time but not at compile time.

Dataset - 
a. strongly typed immutable collection of data
- inferschema
- mention schema
b. it provides benefits of both rdd and df
c. dataset provides both type safety and oop interface.
schema error at compile time only.









spark optimisation features
1. spark.conf.set('spark.sql.adaptive.enabled',False)
2. spark.conf.set('spark.sql.adaptive.coalescepartitions.enabled',False)
3. spark.cong.set('spark.sql.autobroadcastjointhreshold, -1)
4. spark.conf.set('spark.databricks.io.cache.enabled',False)


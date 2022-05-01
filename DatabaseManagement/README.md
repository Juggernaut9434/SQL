# Database management

## Views

Are virtual tables 
that reference data stored
in the original data tables.
Return values formatted in 
a standard record set.
views are like query, well. exactly.
they are select queries that are
stored and turned into db objects.
They do not store data,
just compile other tables data

#### Benefits

- can be quieried like tables
- don't take up much space
- security and dev
	- bridging between users and data

In well designed db, all quieries are filtered
through view objects

#### Use

- Add a `CREATE VIEW [schema.]view_name AS`
- all functions as a query except `ORDER BY`


#### Maintainence

When renaming a column in a table,
the view will automatically update 
the name of the column and use a `AS` 
to not break any previous scripts that used 
the old name of the column **ONLY IN POSTGRES**.
In SQL Server, it will break the view

Check out the documentation for this.


#### Security

- expose limited data that is prefiltered
- Anonymize data with aggregate data or group by
- a base for further quieries that can be joined, etc
- Never use the `*` in a view 
	- instead deliberately define each column included

## Query Performance

small gains in performance have large impacts on db ops,
cost, and end-user xp

- Upgrade Hardware
	- faster memory
	- split data tables and indexes across more performant hard disks
	- add additional processing capacity
	- Elastic resources on cloud platforms make this easier

It is declarative language:
tell what you want, not how you want it

Written Sequence

1. SELECT
1. FROM
1. JOIN
1. WHERE
1. GROUP BY
1. HAVING
1. ORDER BY

Execution Sequence

1. FROM
1. JOIN
1. WHERE
1. GROUP BY
1. HAVING
1. SELECT
1. ORDER BY


The query optimizer has to choose
whether to:

- fetch a and join b
- fetch b and join a

Sometimes it gets it wrong,
its my job to assist the optimizer
to make the best choices from available paths


#### Execution Plans

viewable plans on exec plans.

- It is set up before data is read.
- Table structures and presence of indexes known
- Approx number of rows and distribution stats also known
- Actual data values remain unknown until after the plan is executed
- Query Optimizer chooses exec plan based on educated guesses

Some platforms choose how to optimize in different ways

- caching old queries and pick new ones to compare
- generate new plan every time on run

Scan vs Seek

Scan involves full table read of all rows, top to bottom.
Seek occur when the query processor can use
an index to locate and jump directly to 
specific pages on disk.
The presence of an index does not always mean
a seek operation will occur.
A query processor can choose to ignore indexes
under various conditions and perform full table
scans anyway.

It is your job to identitify and optimize 
frequent executions and their execution plans.


Join Operations

- Nested Loop: scan entire first table once for 
each row in the second table
- Merge join: both tables sorted first, 
then scanned simultaneously
	- needs prep time to sort
- Hash Join: in memory hash table created for
each table to assist in locating
	- good for large data sets
	- can be re used for other joint operations in the same query


Query Processing Nodes

- Seek and Scan
- Join
- Calculations and Sorts

#### View Sql Server Exec Plans

1. Run a Query
1. Press `Explain` or similar on the DB IDE
1. Read it From Right to Left
1. Analyze the load of each step
	- consider storing data on disk differently
	- creating indexes


#### View PostgreSQL Exec Plans


1. Run Query like in SQL Server but with a prefix of `Explain (analyze)`
1. Read in order bottom up

Review data base user forums


#### Control query plans with hints

most of the time, it is best to leave it as it is
because software engineers are constanstly working on it to make it better.

- You can choose how a join is done with `INNER HASH` or `INNER MERGE`


## Transactions

Moving some data e.g. inventory to a cart simultaneously.
It is a single unit of work made up of multiple commands

- If all units succeed, it updates the db
- if at least one unit fails, the transaction fails and won't update


#### ACID Properties

- Atomic: transactions take place once or not at all
- Consistent: data must be consistent before and after transaction
- Isolated: multiple transactions occur independently and invisibly
- Durable: permanently written to system storage and withstand system failures

most RDBMS adhere to these ACID properites by default

- `BEGIN TRANSACTIONS` starts the code block
- followed by the SQL commands
- A choice usually decided by backend code
	- `COMMIT TRANSACTION` to update the db
	- `ROLLBACK TRANSACTION` to not update the db


#### Concurrency and Locks

2 or more users are interacting with the same data rows at the same time
- Lost update problem
	- two users read and write to the same row at same time which causes consistency error
	- solution: have one user wait until the first one is done with the transaction
- Dirty Read
	- user reads values that are not commited or rolled back
- Nonrepeatable read
	- two reads of same data come back with different values
- phantom read
	- two reads of the same table return different number of rows

Solution: Locks

- Locks prevent resources from being accessed by multiple transactions,
which reduces database performance
- Serial, one at a time, execution prevents all concurrency issues
	- a lot of down time and sets up a Queue, not ideal
- Parallel execution is prone to concurrency issues that must be mitigated
- Isolation levels allow parallel execution when concurrency is less concerning
	- Serializable: one at a time: prevents all 3 problems
	- Repeatable read: prevents dirty reads and phantom reads
	- Read commited: prevents dirty reads
	- Read uncommited: doesn't prevent any concurrent problems

Different RDBMS will use these layers at their own agency.


## Data and Object Management

#### System Tables

RDMBSs use internal relational tables to store attributes
about the strucutre of your db.
Exploring the system tables will provide wealth of knowledge
on how the db is constructed and settings.
Can be done with normal select queries as long as the 
table name is known. (Look at documentation)
NEVER change data in the system table with queries, only select.


#### Duplicate Table

For experimentation or analysis reporting, etc.

Different platforms have different syntax


#### Drop Tables

with the drop command.
but some tables have dependencies and won't be deleted
until the constraints are removed.


#### Create temporary tables

the table only exits for that one user
and cannot be accessed by any other user

In PostgreSQL

- use the `create temporary table ...`
- not stored with the other tables
- stored in system tables `pg_table_name`
- won't include schemas

In SQL Server

- anything marked with a prefix of `#` is a temp table


## Functions and Stored Procedures


#### Adding functions and procedures

Functions

- RDBMSs come with several of their own functions
and also allow users to create their own
- End users have access to same functions and receive same results
- Updates made once on the server, effect all end users

similar syntax between SQL Server and PostgreSQL

Procedures

- more commonly known to perform actions that make changes to the database and server.
- store reusable elements on the server
- allow programming languages depending on platform
- Allow parameters passed in from end users that customize output

They have very differnet syntax depending on platform, look at documentation.

On a Security perspective, I am able to add to the database without knowing the 
structure of the database at all.

Look at documentation for the system functions and procedures


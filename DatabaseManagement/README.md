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

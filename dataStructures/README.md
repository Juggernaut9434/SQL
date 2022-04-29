README.md

part 2 of the foundations of db

## Ch1 

#### Data integrity

- Accurate
	- how close the stored data with intended value
	- build validation intelligence
- Complete
	- how thorough each data is
	- avoid gaps or missing data
	- dramatic trickle-down mess
- Consistent
	- are values that should be the same value, actually the same
	- Discrepancies that call all data into quesiton is bad
	- Solve: establish standard data lookups and & don't store calc'd data

#### Data Types

Be deliberate on the data type for a column

- Meaningful table name
- Meaningful column name

precision comes at the cost of process time and storage on disk

Decimal is (total digits, number after decimal)
so `DECIMAL(6,5)` == `3.14159`

There are also approximate numbers like `float, real, single precision`
but they have very hard limitations and some benefits in CS


#### Character Data Types

Determine number of characters

- char
	- fixed length and will store set amount each time
- varchar
	- upto the number of characters or less will be stored

varchar is mostly used unless known length is set and fixed. b/c faster


unlimited character strings `varchar(max) or text`

careful for unicode support `nchar` and `nvarchar` for MySQL

TIP: if you won't do math operations on it, store it as a char



#### Date and Time

- date
- time
- `datetime2` and `timestamp` for MySQL and Postgres respectively

- `getdate()` and `now()`


#### Other data types

- `bit` and `boolean` for boolean
- `varbinary(max)` and `bytea` for binaries like images etc
- `geometry` and `point / line / polygon` for euclidian coordinates
- `geography` and no postgres eqivalent for storing long and lat coord

- `cidr` , `macaddr` only in postgres for ip addr and mac addr
- `json`, only postgres



## Ch 2: DB Normalization

reducing redundancies

- duplicate info 
- remove columns into existing tables
- create additional relataed tables

Why? 

- Isolate information so it appears in DB one time
- Simplifies maintainance and updates
- prevent inconsistencies

#### Normal Forms

1. 1NF
- eliminate repeating groups
- Entity Model
2. 2NF
- Eliminate redundant data
3. 3NF
- Eliminate columns not dependent on key field

Denormalizing

when to not split up when searching for data is too hard 
even when it is best for storage

- `OLTP` - Online Transaction Processing - fast inputting TF not a lot of redundancy
- `OLAP` - online analytical Processing - has redundancy for search time efficiency


## Types of Keys


#### Primary Key

- add inline
- add constraint

Natural PK is the naturally in the db that is unique

Composite PK, unique combination of values

Surrogate Key, a no real-world meaning and created on the spot.


#### Foreign Keys

to link table to table with other table's PK

establish a formal link to help RDBMS know of the links

if you have an orphan (a row in the child that doesn't exist in the parent table)
then you will get an error when you attempt to add the constraint

to remove constraint it is `drop constraint name_of_fk`


## Formalize Data Relationships


- One to Many
	- one owner with many pets
- One to One
	- HR public data and sensitive data is 1-1
- Many to Many
	- Students and Classes 
	- needs a linking table for 2 1-* relationships
	- named Students-Classes
- Self-referencing
	- self join or recursive relationship
	- for hierarchies within the same class
	- Employee and Manager
	- to build org chart / branching tracking set
	- add FK from the same table
- Cascade updates and deletes
	- delete data from tables when the parent table has data removed

## Indexes

B-Tree Index:

- splits PK into a tree structure to turn it from n to log n search

We don't add indexes on all columns bc new added data messes up performance
if no newly added, then OK

Be worried if the index is being updated more often than it is being used


## constraints

adding will be helpful for logic
but too many may be too frustrating to use

- null / not null
- unique
- default (setting default values)
- check
	- data validation rule
	- less than, etc. and regex depending on what sql server use
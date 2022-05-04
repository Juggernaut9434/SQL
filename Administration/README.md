# Administration

## Backup and Restore

- Implementing takes analysis of cost and benefits
- Ideal, exact duplicate is wanted
- Realisticly, it is hard to have an exact update
- Ask yourself what data is willing be to lost (last 24hrs? etc)

Look at documentation, but in command line, you can create backups.

SQL server uses SQL commands,
while PostgreSQL uses external sh tools.
The IDE usually scripts it for you. 

```sql
BACKUP DATABASE [two_trees_dbf4] 
TO  DISK = N'/var/opt/mssql/data/two_trees_dbf4-202251-10-16-36.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'two_trees_dbf4-Full-2022-05-01T17:16:36', 
NOSKIP, REWIND, NOUNLOAD,  STATS = 10
```

To get off of server and onto local computer.

```sh
docker cp sqlserver2019:/var/opt/mssql/data/two_trees_dbf4-202251-10-16-36.bak C:\Users\Mobivity\Desktop
```

#### Restore 

PostgresSQL needs an emtpy database
while SQL Server can recreate from nothing.

IF BAD GUY comes in and deletes everything with

```sql
-- kicks all other users from db
ALTER DATABASE two_trees_dbf4 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- drops db
DROP DATABASE two_trees_dbf4;

```

```sql
RESTORE DATABASE two_trees_dbf4
FROM DISK = N'/var/opt/mssql/data/two_trees_dbf4-202251-10-16-36.bak'
```

There are plenty of advanced options, so look at documentation.

#### Incremental and Differential Backups

backups can be very large. so other solutions include the change between the last backup and this one. kinda like a git commit.
Same concept, different name depending on RDBMS platform.

For full backup, you need multiple operations.

So alternate between full backups at night and incremental backups during the day.

#### Point in time Recovery

- Data File
- Log File

`SELECT * FROM fn_dblog(NULL, NULL);`

You can restore from Log file too, and stop at any time before the OOPS moments.


## Server Security


- Think Who has access to what
- Must have different level of access

Principals

- An end user (program, etc),
- groups of users

Securables

- store tables, procedures, etc.
- groups of objects collected in schema

The way Principals and Securables connect to one another is through **Permissions**

#### User Authentication

Verify that the person is who they say they are.
Usually with Username and Password.
RDBMSs have default usernames `sa` or `postgres`

In larger organizations, and for more secure users, other authentication protocols are used: `Kerberos` and biometric.

use the `Grant` command to allow principals to perform actions on a securable. 
`Revoke` for the opposite.

Give bare minimum access is ideal.

```sql
GRANT SELECT, INSERT
	ON TABLE employees
	TO alan;
REVOKE SELECT
	ON TABLE employees
	FROM alan;
GRANT ALL PRIVELEGES
	ON TABLE employees
	TO beth;
```

To add a new user, look at documentation for your platform

For the new user, it needs its own (new) connection to the database. 
In SQL Server, the server has its own logins and roles.
AND each database has its own
users for security.

#### User Security

Auditing the users, depend on the platform. check documentation.
You can see who gave access to what.

For SQL Server:
query the table `sys.database_permissions`

#### Column Permissions:

`GRANT SELECT ON OBJECT :: sales.customers(company) TO Yusef` where it goes
schema.table.column for SQL Server

#### Group Permissions

```sql
CREATE USER Tabitha;

CREATE ROLE human_resources;

ALTER ROLE human_resources
	ADD MEMBER Tabitha;
```

## High Availability


#### Server uptime

Downtime

- hardware / software failure
- malicious attack
- Costs -> inconvienence or loss of clients
- Create proactive plan
- availability is done with 9s,
	- 99.999% is 5 9s

#### Standby Server

- duplicates main server
- standby promotes when primary is down
- gotta be as close as possible to primary
- Levels
	- Cold Standby: just the hardware
	- Warm Standby: actively running and updated and updated with backups. Some lag is possible
	- HOT standby: any changes to one db is sent to both and gets around the warm standby. But it is the cost of holding both.


#### Log shipping

For warm standby: 

- it uses the same technique as transaction logs
- log records every change to DB
- ships log from primary to standby
- One way communication primary -> standby

1. a differential backup is made on primary
2. backup is copied to standby
3. log is added to standby db / transaction log

Delayed Recovery is when the standby server doesn't immediately update in case the db had some actions that were detrimental to the db.


#### Failover Cluster

2 or more servers (nodes) and a pool of 
shared storage.
Therefore, one file of data.
One node is active 
and the rest are passive.
Only the active node can write to the pool
and the passive CAN read

Failing over: a server node monitors the heartbeats of the other servers, if one fails, a process of failover takes place where one server is promoted to active and the dead one is demoted to passive 

It needs a tight integration between RDBMS and the OS they are running on


## Health and Maintainence of the System

#### Maintainence tasks

- Each RDBMS will have its own set of maintainence and routines.
- actions on one may be detrimental on the other. 

PostgreSQL:

- `VACCUUM` to clean up removed but not deleted tables or rows. Once a day
- `VACCUUM FULL` can block out other users and do a thorough job of cleaning up the disk space. Best for archiving not when it is growing.

SQL Server:

`DBCC CHECKDB` database console command. 
will run other tasks

#### Closing user sessions

For SQL Server:

- `EXECUTE sp_who2;`
- DBName Column and your db
- Last Batch column
- Find an old date (not today)
- `KILL 52` where 52 is the pid # 

#### Reviewing system statistics

RDBMSs use statistics on tables to perform better quieries, but they are sometimes outdated.

POSTGRES: `ANALYZE` OR `ANALYZE (VERBOSE);`
SQL SERVER: `UPDATE STATISTICS sales.customers`, but the sql server has a better optimizer and updates frequently

#### Reading system logs

Read the logs for errors or other notes.

In terminal, you can view in docker logs if on docker.

`docker logs postgresql --tail 10` and
`docker logs sqlserver2019 --tail 10`

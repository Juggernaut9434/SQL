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


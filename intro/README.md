# SQL

## Follow along on linkedIn Learning

using docker for 2 different 
rdbms systems

- sqlserver
- postgres

use `start` to reenter an exited container

## Technology

We will be using a GUI to access both containers and databases

`Azure Data Studio`

to connect to a server, you need to know the ip address and port
`0.0.0.0` is the same as `localhost`

- `docker ps` shows the port the container is using
- `docker port CONTAINER_ID` 

- mysqlserver: SA
- postgres: postgres

## Data Organization

UML RDBMS tables and ER Models

Schemas group tables together 

### Data Types

mysql uses Varchar(max) and postgres uses TEXT to signify the max length text available

check documentation for more

- CHAR
- INT
- DATE

### Updating between mysql and postgres

you can easily create a .sql script to add everything from one to the other
the only difference so far is the `GO` command is needed in MySQL for creating a schema
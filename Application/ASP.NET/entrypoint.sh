#! /bin/bash

set -e
run_cmd="dotnet run --urls http://*:80"

>&2 echo "SQL Server is starting up"
sleep 30s

>&2 echo "SQL Server is up - executing command"
exec $run_cmd
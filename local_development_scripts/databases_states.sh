#!/bin/sh

# Checks what state the databases servers are in.
# gamestore service database is on server with port 3306.
# authorization-service database is on server with port 3307.

# Function to check if a server is up
check_db() {
    # 'nc' (netcat) command is used to check if it can establish a connection to the specified ports.
    if nc -z localhost $1; then
        echo "Server on port $1 is up."
        return 0
    else
        echo "Server on port $1 is not responding."
        return 1
    fi
}

# Check both databases
check_db 3306
db1_status=$?

check_db 3307
db2_status=$?

# Exit based on database status
if [ $db1_status -eq 0 ] && [ $db2_status -eq 0 ]; then
    echo "Both databases are up."
    exit 0
else
    echo "One or both databases are down."
    exit 1
fi
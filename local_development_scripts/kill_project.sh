#!/bin/sh

# Read PIDs from files.
auth_pid=$(cat auth_pid.txt)
gamestore_pid=$(cat gamestore_pid.txt)

# Kill the services using their PIDs.
echo "Stopping auth service (PID: $auth_pid)..."
kill $auth_pid

echo "Stopping gamestore service (PID: $gamestore_pid)..."
kill $gamestore_pid

echo "Services stopped."

# Stop the database servers.

echo "Stopping gamestore database"
docker stop mysql_local_game_store

echo "Stopping auth service database"
docker stop mysql_local_auth_service
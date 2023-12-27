#!/bin/sh

# Read PIDs from files.
auth_pid=$(cat auth_pid.txt)
gamestore_pid=$(cat gamestore_pid.txt)

# Kill the services using their PIDs.
echo "Stopping auth_service (PID: $auth_pid)..."
kill $auth_pid

echo "Stopping gamestore_service (PID: $gamestore_pid)..."
kill $gamestore_pid

echo "Services stopped."

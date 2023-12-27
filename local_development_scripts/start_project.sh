#!/bin/sh

# Check if database servers are up.

# Run the database check script
./databases_states.sh

# Capture the exit status
exit_status=$?

# Check the exit status
if [ $exit_status -eq 0 ]; then
    echo "Databases are up, continuing..."
    # Continue with further commands or scripts
else
    echo "Error: One or both databases are down."
    echo "Starting servers..."
    ./start_database_servers.sh

    # Wait 5 seconds for servers to start.
    sleep 5
fi

# Start auth_service.
cd ../authorization-service
echo "Starting authorization-service..."

# 'nohup' detaches and runs another command that persists even after the session that started it has ended.
# '2>&1' sends stdout and stderr to trash.
nohup mvn spring-boot:run > /dev/null 2>&1 &
auth_pid=$!
echo "authorization-service started with PID: $auth_pid"

# Wait for authorization-service to be fully up and running (takes about 10 seconds).
sleep 15

# Start gamestore service.
cd ../gamestore
echo "Starting gamestore_service..."
nohup mvn spring-boot:run > /dev/null 2>&1 &
gamestore_pid=$!
echo "gamestore service started with PID: $gamestore_pid"

# Go back to base directory.
cd ../local_development_scripts

# Save PIDs to a file for easy termination later.
echo $auth_pid > auth_pid.txt
echo $gamestore_pid > gamestore_pid.txt

# Check if both services are up.
sleep 15

# Check if authorization service is up.
if curl -s http://localhost:7070/ > /dev/null; then
    echo "authorization service is up."
else
    echo "authorization service is not responding."
    echo "EXITING..."
    kill $gamestore_pid
    kill $auth_pid
    exit 1
fi

# Check if gamestore service is up.
if curl -s http://localhost:8080/ > /dev/null; then
    echo "gamestore service is up."
else
    echo "gamestore service is not responding."
    echo "EXITING..."
    kill $gamestore_pid
    kill $auth_pid
    exit 1
fi

echo Run 'kill_project.sh' to kill services.
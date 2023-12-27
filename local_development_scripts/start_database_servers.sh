#!/bin/sh

# This script starts the MySQL database servers.
# The servers are in Docker containers.

docker start mysql_local_auth_service
docker start mysql_local_game_store
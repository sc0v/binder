#!/bin/bash
# Exit on any error
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f ./tmp/pids/server.pid

# Make sure db is ready to go
# TODO: uncomment once we migrate development DB to MySQL
# This line fails because of differences between SQLite (where migrations were created)
# and production MySQL 
# bundle exec rails db:migrate

# Then exec the container's main process (CMD in the Dockerfile).
exec "$@"

#!/bin/bash
# Exit on any error
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f ./tmp/pids/server.pid

# Then exec the container's main process (CMD in the Dockerfile).
exec "$@"

# Note: You will have to run rails db:migrate yourself when creating a new
# production container. We do not run it automatically on container startup
# because our development database (SQLite3) could potentially generate
# migrations that don't work in production (MySQL2). If this occurs, it is
# easier to debug the issue if the container remains up despite the failure.
#
# To run db:migrate, run these commands in the production virtual machine:
#
# $ podman exec -it binder bash
# > rails db:migrate

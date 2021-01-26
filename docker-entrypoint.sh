#!/bin/bash

set -e
# Exit on fail

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ -f tmp/pids/server-test.pid ]; then
  rm tmp/pids/server-test.pid
fi


# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

exec "$@"
# Finally call command issued to the docker service
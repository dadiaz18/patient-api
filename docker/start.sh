#!/bin/bash
set -e

echo "Removing stale server.pid..."
rm -f tmp/pids/server.pid

echo "Starting Prometheus Exporter..."
bundle exec prometheus_exporter --bind 0.0.0.0 --auth /rails/my-htpasswd-file --port $PROMETHEUS_EXPORTER_PORT &

echo "Preparing DB..."
bin/rails db:prepare

echo "Starting Rails server..."
bin/rails server -b 0.0.0.0

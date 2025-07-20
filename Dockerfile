# syntax=docker/dockerfile:1

# Base image
ARG RUBY_VERSION=3.4.3
FROM ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages - añadiendo apache2-utils para htpasswd
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 sqlite3 apache2-utils && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set default environment variables
ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="" \
    PROMETHEUS_EXPORTER_PORT=9394

# Install dependencies for building gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Asegurar que el archivo my-htpasswd-file tenga los permisos correctos
RUN chmod 644 my-htpasswd-file

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Create a script to run the Prometheus Exporter and Rails server
COPY start.sh /rails/start.sh
RUN chmod +x /rails/start.sh

# Expose ports for Rails server and Prometheus
EXPOSE 3000 9394

# Use the start script as the entrypoint
ENTRYPOINT ["/rails/start.sh"]
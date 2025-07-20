source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"

# External validations
gem "dry-validation"

# Speeds up app boot
gem "bootsnap", require: false

# CORS, useful if using an external frontend (HTMX, React, etc.)
gem "rack-cors"

# JSON API serialization
gem "active_model_serializers"

# Publish your OpenAPI documentation as a JSON/YAML endpoint
gem "rswag-api"
# Show an interactive Swagger UI based on your API documentation
gem "rswag-ui"

# Monitoring - Prometheus exporter
gem "prometheus-client"
gem "prometheus_exporter"

gem "webrick"

group :development, :test do
  # Tools for development and testing
  gem "rspec-rails"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false  # Añadir esta línea

  # Style linter with official Rails configuration
  gem "rubocop-rails-omakase", require: false

  # Factory Bot for creating test data
  gem "factory_bot_rails"

  # Provides convenient matchers for testing Rails models and controllers
  gem "shoulda-matchers"

  # Create tests and generate real-time API docs from your specs
  gem "rswag-specs", "~> 2.16.0"
end

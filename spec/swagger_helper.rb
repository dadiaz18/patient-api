require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Patient Injection API',
        version: 'v1',
        description: 'API documentation for recording injections and calculating treatment adherence.'
      },
      components: {
        securitySchemes: {
          api_key: {
            type: :apiKey,
            name: 'API-KEY',
            in: :header,
            description: 'Patient API Key for authentication'
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Local server'
        }
      ]
    }
  }

  config.swagger_format = :yaml
end

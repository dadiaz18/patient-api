class ApplicationController < ActionController::API
  include ResponseHandler
  include SerializationHelper

  before_action :validate_headers

  private

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error("Record not found: #{e.message}", status: :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(e.message, status: :unprocessable_entity)
  end

  rescue_from StandardError do |e|
    render_error("Internal server error: #{e.message}", status: :internal_server_error)
  end

  def validate_headers
    api_key = request.headers["HTTP_API_KEY"]

    unless api_key.present?
      render_error("Missing or invalid API-KEY header", status: :unauthorized)
    end

    @api_key = api_key
  end
end

module ResponseHandler
  def render_success(data, status: :ok)
    render json: data, status: status
  end

  def render_error(message, status: :unprocessable_entity)
    render json: { error: message }, status: status
  end

  def render_validation_errors(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end
end

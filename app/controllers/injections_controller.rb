class InjectionsController < ApplicationController
  include PatientAuthenticable

  def create
    validation = InjectionSchema.new.call(injection_params)

    if validation.success?
      injection = @patient.injections.create!(validation.to_h)
      render json: injection, status: :created
    else
      render_validation_errors(validation.errors.to_h)
    end
  end

  def index
    injections = @patient.injections.order(created_at: :desc)
    render_success(serialize_injections(injections))
  end

  private

  def injection_params
    params.permit(:dose, :lot_number, :drug_name).to_h
  end

  def serialize_injections(injections)
    serialize_resource(injections, InjectionIndexSerializer).as_json
  end
end

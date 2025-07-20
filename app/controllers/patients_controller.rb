class PatientsController < ApplicationController
  skip_before_action :validate_headers, only: :create
  def create
    patient = Patient.create!
    render json: patient, status: :created
  end
end

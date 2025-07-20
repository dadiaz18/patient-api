module PatientAuthenticable
  extend ActiveSupport::Concern

  included do
    before_action :set_patient
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id], api_key: @api_key)
    render_error("Unauthorized", status: :unauthorized) unless @patient
  end
end

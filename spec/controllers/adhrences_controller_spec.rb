require 'rails_helper'

RSpec.describe AdherencesController, type: :controller do
  let(:patient) { create(:patient) }
  let(:headers) { { 'API-KEY' => patient.api_key } }

  describe 'GET #show' do
    it 'returns the adherence score for the patient' do
      request.headers.merge!(headers)
      allow(AdherenceCalculator).to receive(:new).with(patient).and_call_original
      get :show, params: { patient_id: patient.id }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['score']).to be_a(Float)
    end

    it 'returns unauthorized if API key is missing' do
      get :show, params: { patient_id: patient.id }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end

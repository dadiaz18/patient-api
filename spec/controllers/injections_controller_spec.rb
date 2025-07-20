require 'rails_helper'

RSpec.describe InjectionsController, type: :controller do
  let(:patient) { create(:patient) }
  let(:api_key) { patient.api_key }
  let(:headers) { { 'API-KEY' => patient.api_key } }
  let(:injection_attributes) { { dose: 10, lot_number: 'ABC123', drug_name: 'Insulin' } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new injection and returns status 201' do
        request.headers.merge!(headers)
        expect {
          post :create, params: injection_attributes.merge(patient_id: patient.id)
        }.to change(Injection, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(Injection.last.patient).to eq(patient)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { dose: nil, lot_number: '', drug_name: '' } }

      it 'does not create an injection and returns validation errors' do
        request.headers.merge!(headers)
        expect {
          post :create, params: { patient_id: patient.id, injection: invalid_params }
        }.not_to change(Injection, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      create_list(:injection, 3, patient: patient)
      other_patient = create(:patient)
      create_list(:injection, 2, patient: other_patient)
    end

    it 'returns all injections for the authenticated patient' do
      request.headers.merge!(headers)
      get :index, params: { patient_id: patient.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'orders injections by created_at desc' do
      older = create(:injection, patient: patient, created_at: 2.days.ago)
      newer = create(:injection, patient: patient, created_at: 1.day.ago)
      newest = create(:injection, patient: patient, created_at: Time.current)

      request.headers.merge!(headers)
      get :index, params: { patient_id: patient.id }

      json_response = JSON.parse(response.body)
      expect(json_response.first['id']).to eq(newest.id)
      expect(json_response.last['id']).to eq(older.id)
    end
  end
end

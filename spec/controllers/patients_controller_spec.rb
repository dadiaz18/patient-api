require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new patient and returns status 201' do
      expect {
        post :create
      }.to change(Patient, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['id']).to eq(Patient.last.id)
      expect(JSON.parse(response.body)['api_key']).to eq(Patient.last.api_key)
    end
  end
end

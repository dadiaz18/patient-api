require 'swagger_helper'

RSpec.describe 'Patients API', type: :request do
  path '/patients' do
    post 'Create a new patient' do
      tags 'Patients'
      consumes 'application/json'
      produces 'application/json'

      response '201', 'Patient created' do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 api_key: { type: :string, example: 'randomly_generated_api_key' },
                 created_at: { type: :string, format: :date_time, example: '2023-01-01T00:00:00Z' },
                 updated_at: { type: :string, format: :date_time, example: '2023-01-01T00:00:00Z' }
               }

        run_test!
      end
    end
  end

  path '/patients/{patient_id}/adherence' do
    get 'Get adherence score for a patient' do
      tags 'Patients'
      produces 'application/json'
      security [ api_key: [] ]

      parameter name: :patient_id, in: :path, type: :string, description: 'ID of the patient'

      let(:patient) { create(:patient) }
      let(:patient_id) { patient.id }

      response '200', 'Adherence score retrieved' do
        let(:'API-KEY') { patient.api_key }

        schema type: :object,
               properties: {
                 score: { type: :number, example: 85.5 }
               }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to include('score')
        end
      end

      response '401', 'Unauthorized' do
        let(:'API-KEY') { nil }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Missing or invalid API-KEY header' }
               }

        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to include('error' => 'Missing or invalid API-KEY header')
        end
      end
    end
  end
end

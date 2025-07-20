require 'swagger_helper'

RSpec.describe 'Injections API', type: :request do
  path '/patients/{patient_id}/injections' do
    post 'Register a new injection' do
      tags 'Injections'
      consumes 'application/json'
      produces 'application/json'
      security [ api_key: [] ]

      parameter name: :patient_id, in: :path, type: :string, description: 'ID of the patient'
      parameter name: :injection, in: :body, schema: {
        type: :object,
        properties: {
          dose: { type: :number, example: 10.1 },
          lot_number: { type: :string, example: 'ABC123' },
          drug_name: { type: :string, example: 'Factor VIII' }
        },
        required: %w[dose lot_number drug_name]
      }

        response '201', 'Injection created' do
        let(:patient) { create(:patient) }
        let(:patient_id) { patient.id }
        let(:'API-KEY') { patient.api_key }
        let(:injection) do
          {
            dose: 10,
            lot_number: 'ABC123',
            drug_name: 'Factor VIII'
          }
        end

        schema type: :object,
               properties: {
                 id: { type: :integer, example: 123 },
                 patient_id: { type: :integer, example: 1 },
                 dose: { type: :number, example: 10.1 },
                 lot_number: { type: :string, example: 'ABC123' },
                 drug_name: { type: :string, example: 'Factor VIII' }
               }

        run_test! do |response|
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)).to include('dose' => 10, 'lot_number' => 'ABC123', 'drug_name' => 'Factor VIII')
        end
      end

      response '422', 'Invalid request' do
        let(:patient) { create(:patient) }
        let(:patient_id) { patient.id }
        let(:'API-KEY') { patient.api_key }
        let(:injection) do
          {
            dose: nil,
            lot_number: 'ABC123',
            drug_name: 'Factor VIII'
          }
        end

        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   properties: {
                     dose: { type: :array, items: { type: :string, example: 'is missing' } }
                   }
                 }
               }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to include('errors')
        end
      end
    end

    get 'Retrieve all injections for a patient' do
      tags 'Injections'
      produces 'application/json'
      security [ api_key: [] ]

      parameter name: :patient_id, in: :path, type: :string, description: 'ID of the patient'

      response '200', 'Injections retrieved' do
        let(:patient) { create(:patient) }
        let(:patient_id) { patient.id }
        let(:'API-KEY') { patient.api_key }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer, example: 1 },
                   dose: { type: :number, example: 3.0 },
                   lot_number: { type: :string, example: 'ABC123' },
                   drug_name: { type: :string, example: 'FactorX' },
                   created_at: { type: :string, format: :date_time, example: '2025-07-19T15:27:26.111Z' }
                 }
               }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to be_an(Array)
        end
      end

      response '401', 'Unauthorized' do
        let(:patient) { create(:patient) }
        let(:patient_id) { patient.id }
        let(:'API-KEY') { nil }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Missing or invalid API-KEY header' }
               }

        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to include('error')
        end
      end
    end
  end
end

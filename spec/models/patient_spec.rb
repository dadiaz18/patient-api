require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'associations' do
    it { should have_many(:injections).dependent(:destroy) }
  end

  describe 'callbacks' do
    it 'generates a unique api_key before creation' do
      patient = Patient.create
      expect(patient.api_key).to be_present
      expect(patient.api_key).to match(/\A[\w\-]{36}\z/)
    end
  end
end

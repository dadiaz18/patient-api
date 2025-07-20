require 'rails_helper'

RSpec.describe InjectionSchema do
  subject(:schema) { described_class.new }

  let(:valid_params) do
    { dose: 1.5, lot_number: 'ABC123', drug_name: 'Aspirin' }
  end

  context 'when parameters are valid' do
    it 'has no errors' do
      result = schema.call(valid_params)
      expect(result).to be_success
      expect(result.errors).to be_empty
    end
  end

  context 'required field validations' do
    it 'requires dose to be present' do
      result = schema.call(valid_params.except(:dose))
      expect(result.errors[:dose]).to include('is missing')
    end

    it 'requires lot_number to be present' do
      result = schema.call(valid_params.except(:lot_number))
      expect(result.errors[:lot_number]).to include('is missing')
    end

    it 'requires drug_name to be present' do
      result = schema.call(valid_params.except(:drug_name))
      expect(result.errors[:drug_name]).to include('is missing')
    end
  end

  context 'format validations' do
    it 'validates that lot_number has exactly 6 characters' do
      result = schema.call(valid_params.merge(lot_number: '123'))
      expect(result.errors[:lot_number]).to include('length must be 6')

      result = schema.call(valid_params.merge(lot_number: '123456'))
      expect(result.errors[:lot_number]).to be_nil
    end
  end

  context 'value validations' do
    it 'validates that dose is greater than 0' do
      result = schema.call(valid_params.merge(dose: 0))
      expect(result.errors[:dose]).to include('must be greater than 0')

      result = schema.call(valid_params.merge(dose: -1))
      expect(result.errors[:dose]).to include('must be greater than 0')
    end
  end
end

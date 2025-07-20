require 'rails_helper'

RSpec.describe AdherenceCalculator do
  let(:patient_1) { create(:patient, created_at: 10.days.ago) }
  let(:patient_2) { create(:patient, created_at: 5.days.ago) }
  let(:patient_3) { create(:patient, created_at: 6.days.ago) }

  before do
    # patient 1
    create(:injection, patient: patient_1, created_at: 10.days.ago)
    create(:injection, patient: patient_1, created_at: 7.days.ago)
    create(:injection, patient: patient_1, created_at: 4.days.ago)
    create(:injection, patient: patient_1, created_at: 1.day.ago)

    # patient 2
    create(:injection, patient: patient_2, created_at: 5.days.ago)
  end

  describe '#call' do
    it 'calculates the adherence score correctly perfect adherence' do
      calculator = AdherenceCalculator.new(patient_1)
      score = calculator.call

      expect(score).to eq(100.0)
    end

    it 'calculates the adherence score correctly partial adherence' do
      calculator = AdherenceCalculator.new(patient_2)
      score = calculator.call

      expect(score).to eq(50.0)
    end

    it 'calculates 33.33% adherence when 1 out of 3 expected injections match' do
      create(:injection, patient: patient_3, created_at: 3.days.ago)

      calculator = AdherenceCalculator.new(patient_3)
      score = calculator.call

      expect(score).to eq(33.33)
    end

    it 'returns 0.0 if no injections are on time' do
      patient_1.injections.destroy_all
      calculator = AdherenceCalculator.new(patient_1)
      score = calculator.call

      expect(score).to eq(0.0)
    end
  end
end

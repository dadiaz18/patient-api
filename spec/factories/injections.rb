FactoryBot.define do
  factory :injection do
    association :patient
    dose { 10 }
    lot_number { 'ABC123' }
    drug_name { 'Insulin' }
  end
end

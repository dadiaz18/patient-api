FactoryBot.define do
  factory :patient do
    api_key { SecureRandom.hex(16) }
  end
end

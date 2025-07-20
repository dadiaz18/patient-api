class InjectionSchema < Dry::Validation::Contract
  config.validate_keys = true

  params do
    required(:dose).filled(:float)
    required(:lot_number).filled(:string, size?: 6)
    required(:drug_name).filled(:string)
  end

  rule(:dose) do
    key.failure("must be greater than 0") if value <= 0
  end
end

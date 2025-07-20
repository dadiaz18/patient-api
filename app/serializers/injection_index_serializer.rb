class InjectionIndexSerializer < ActiveModel::Serializer
  attributes :id, :dose, :lot_number, :drug_name, :created_at
end

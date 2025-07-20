class InjectionSerializer < ActiveModel::Serializer
  attributes :id, :dose, :lot_number, :drug_name, :patient_id
end

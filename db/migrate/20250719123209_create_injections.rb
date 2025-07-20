class CreateInjections < ActiveRecord::Migration[8.0]
  def change
    create_table :injections do |t|
      t.float :dose
      t.string :lot_number
      t.string :drug_name
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end

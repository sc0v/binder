class CreateCharges < ActiveRecord::Migration[4.2]
  def change
    create_table :charges do |t|
      t.references :organization
      t.references :charge_type
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :description

      t.integer :issuing_participant_id
      t.integer :receiving_participant_id

      t.timestamps
    end
    add_index :charges, :organization_id
  end
end

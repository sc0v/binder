class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :organization
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :description

      t.integer :issuing_participant
      t.integer :receiving_participant

      t.timestamps
    end
    add_index :charges, :organization_id
  end
end

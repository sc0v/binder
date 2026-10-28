class CreateUrgents < ActiveRecord::Migration[8.0]
  def change
    create_table :urgents do |t|
      t.string :title
      t.string :value
      t.boolean :hidden, default: false, null: false
      t.integer :participant_id, null: false
      t.integer :organization_id
      t.datetime :archived_at

      t.timestamps
    end
  end
end

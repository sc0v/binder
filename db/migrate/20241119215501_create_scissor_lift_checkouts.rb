class CreateScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :scissor_lift_checkouts do |t|
      t.references :scissor_lift, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.datetime :checked_out_at
      t.datetime :checkout_duration

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateCheckouts < ActiveRecord::Migration[4.2]
  def change
    create_table :checkouts do |t|
      t.references :membership
      t.references :tool
      t.datetime :checked_out_at
      t.datetime :checked_in_at

      t.timestamps
    end
    add_index :checkouts, :membership_id
    add_index :checkouts, :tool_id
  end
end

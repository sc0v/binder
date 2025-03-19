# frozen_string_literal: true
class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.references :membership
      t.references :tool
      t.datetime :checked_out_at
      t.datetime :checked_in_at

      t.timestamps
    end
  end
end

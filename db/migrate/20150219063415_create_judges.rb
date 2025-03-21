# frozen_string_literal: true
class CreateJudges < ActiveRecord::Migration[6.0]
  def change
    create_table :judges do |t|
      t.string :name
      t.integer :category

      t.timestamps null: false
    end
  end
end

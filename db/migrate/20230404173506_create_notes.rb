# frozen_string_literal: true
class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :organization, null: true, foreign_key: true
      t.boolean :hidden
      t.string :title
      t.string :value
      t.string :color

      t.timestamps
    end
  end
end

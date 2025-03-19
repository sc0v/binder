# frozen_string_literal: true
class CreateCertificationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :certification_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

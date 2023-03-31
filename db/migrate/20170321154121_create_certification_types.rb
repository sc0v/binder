# frozen_string_literal: true
class CreateCertificationTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :certification_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

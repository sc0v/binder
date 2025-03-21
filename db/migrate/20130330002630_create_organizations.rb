# frozen_string_literal: true
class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.references :organization_category

      t.timestamps
    end
  end
end

# frozen_string_literal: true
class CreateOrganizationCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

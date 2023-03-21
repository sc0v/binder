# frozen_string_literal: true
class AddIndexToOrganizationCategoryName < ActiveRecord::Migration[7.0]
  def change
    add_index :organization_categories,
              :name,
              name: 'index_organization_categories_on_name',
              unique: true
  end
end

# frozen_string_literal: true
class AddIsBuildingToOrganizationCategory < ActiveRecord::Migration[4.2]
  def change
    add_column :organization_categories, :is_building, :boolean
  end
end

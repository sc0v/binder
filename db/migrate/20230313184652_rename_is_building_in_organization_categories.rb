# frozen_string_literal: true

class RenameIsBuildingInOrganizationCategories < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :organization_categories, :is_building, :building
  end

  def self.down
    rename_column :organization_categories, :building, :is_building
  end
end

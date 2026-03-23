# frozen_string_literal: true

class AddIsBuildingToOrganizationCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :organization_categories,
               :is_building,
               :boolean,
               null: false,
               default: false
  end
end

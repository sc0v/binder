# frozen_string_literal: true
class CreateOrganizationAliases < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_aliases do |t|
      t.string :alias
      t.references :organization

      t.timestamps
    end
    add_index :organization_aliases, :alias
  end
end

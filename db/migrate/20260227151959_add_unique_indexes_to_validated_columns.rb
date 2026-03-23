# frozen_string_literal: true

class AddUniqueIndexesToValidatedColumns < ActiveRecord::Migration[8.0]
  def change
    add_index :certification_types, :name, unique: true
    add_index :charge_types, :name, unique: true
    add_index :memberships, %i[participant_id organization_id], unique: true
    add_index :organizations, :name, unique: true
    add_index :participants, :eppn, unique: true
    add_index :shift_types, :name, unique: true
    add_index :store_items, :name, unique: true
    add_index :tool_types, :name, unique: true
    remove_index :tools, :barcode
    add_index :tools, :barcode, unique: true
  end
end

# frozen_string_literal: true
class AddShortNameToOrganization < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :short_name, :string
  end
end

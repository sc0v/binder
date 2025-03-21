# frozen_string_literal: true
class AddShortNameToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :short_name, :string
  end
end

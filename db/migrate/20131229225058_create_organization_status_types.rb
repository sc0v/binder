# frozen_string_literal: true
class CreateOrganizationStatusTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_status_types do |t|
      t.string :name
      t.boolean :display
    end
  end
end

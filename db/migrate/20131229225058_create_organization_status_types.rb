# frozen_string_literal: true
class CreateOrganizationStatusTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :organization_status_types do |t|
      t.string :name
      t.boolean :display
    end
  end
end

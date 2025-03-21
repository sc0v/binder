# frozen_string_literal: true
class AddFieldsToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :organization_id, :integer
    add_column :documents, :public, :boolean
  end
end

class AddFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :organization_id, :integer
    add_column :documents, :public, :boolean
  end
end

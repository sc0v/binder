class AddFieldsToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :organization_id, :integer
    add_column :documents, :public, :boolean
  end
end

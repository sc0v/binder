class AddCommentsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :comments, :text
  end
end

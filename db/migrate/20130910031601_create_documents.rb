class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :document_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end

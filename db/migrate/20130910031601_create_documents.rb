class CreateDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :documents do |t|
      t.integer :document_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end

# frozen_string_literal: true
class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.integer :document_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end

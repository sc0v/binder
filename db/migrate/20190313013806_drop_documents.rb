# frozen_string_literal: true
class DropDocuments < ActiveRecord::Migration[6.0]
  def change
    drop_table :documents
  end
end

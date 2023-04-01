# frozen_string_literal: true
class CreateTaskCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :task_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

# frozen_string_literal: true
class AddCreatedByToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :created_by, :integer
  end
end

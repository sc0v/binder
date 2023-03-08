# frozen_string_literal: true

class AddCreatedByToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :created_by, :integer
  end
end

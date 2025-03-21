# frozen_string_literal: true
class AddAssignedPersonToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :assigned_person, :integer
  end
end

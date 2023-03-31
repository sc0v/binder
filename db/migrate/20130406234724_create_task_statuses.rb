# frozen_string_literal: true
class CreateTaskStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :task_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end

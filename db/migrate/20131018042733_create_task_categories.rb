class CreateTaskCategories < ActiveRecord::Migration
  def change
    create_table :task_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

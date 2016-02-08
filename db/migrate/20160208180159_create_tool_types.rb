class CreateToolTypes < ActiveRecord::Migration
  def change
    create_table :tool_types do |t|
      t.string :name
      t.timestamps
    end
  end
end

class AddActiveToTools < ActiveRecord::Migration[7.0]
  def change
    add_column :tools, :active, :boolean
  end
end

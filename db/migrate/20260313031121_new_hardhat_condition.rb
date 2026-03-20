class NewHardhatCondition < ActiveRecord::Migration[7.0]
  def change
    add_column :tools, :status, :string
  end
end

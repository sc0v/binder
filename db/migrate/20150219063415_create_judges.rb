class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string :name
      t.integer :category

      t.timestamps null: false
    end
  end
end

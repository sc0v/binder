class CreateJudgementCategories < ActiveRecord::Migration
  def change
    create_table :judgement_categories do |t|
      t.integer :grouping
      t.string :name
      t.integer :max_value
      t.string :description

      t.timestamps null: false
    end
  end
end

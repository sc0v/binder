class CreateJudgements < ActiveRecord::Migration
  def change
    create_table :judgements do |t|
      t.references :judgement_category, index: true
      t.integer :value
      t.references :judge, index: true
      t.references :organization, index: true

      t.timestamps null: false
    end
    add_foreign_key :judgements, :judgement_categories
    add_foreign_key :judgements, :judges
    add_foreign_key :judgements, :organizations
  end
end

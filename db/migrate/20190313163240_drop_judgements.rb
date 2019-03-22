class DropJudgements < ActiveRecord::Migration
  def change
    
    remove_reference :judgements, :judge
    remove_reference :judgements, :judgement_category

    drop_table :judges
    drop_table :judgement_categories
    drop_table :judgements
  end
end

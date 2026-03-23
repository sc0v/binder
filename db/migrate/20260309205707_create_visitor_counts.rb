class CreateVisitorCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :visitor_counts do |t|
      t.references :organization, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end

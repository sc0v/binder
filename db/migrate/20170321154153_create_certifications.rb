class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.belongs_to :participant, index: true, foreign_key: true
      t.belongs_to :certification_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

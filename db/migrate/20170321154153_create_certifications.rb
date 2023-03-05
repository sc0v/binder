class CreateCertifications < ActiveRecord::Migration[4.2]
  def change
    create_table :certifications do |t|
      t.belongs_to :participant, index: true, foreign_key: true
      t.belongs_to :certification_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end

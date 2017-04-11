class CreateToolTypeCertifications < ActiveRecord::Migration
  def change
    create_table :tool_type_certifications do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.belongs_to :tool_type, index: true, foreign_key: true
      t.belongs_to :certification_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

# frozen_string_literal: true
class CreateToolTypeCertifications < ActiveRecord::Migration[6.0]
  def change
    create_table :tool_type_certifications do |t|
      t.belongs_to :tool_type, index: true, foreign_key: true
      t.belongs_to :certification_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end

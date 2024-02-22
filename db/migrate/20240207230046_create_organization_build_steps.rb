class CreateOrganizationBuildSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_build_steps do |t|
      t.string :title
      t.text :requirements
      t.integer :step
      t.boolean :completed
      t.references :organization_build_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateOrganizationBuildStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_build_statuses do |t|
      t.references :organization, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end

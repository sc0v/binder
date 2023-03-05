class CreateOrganizationStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :organization_statuses do |t|
      t.belongs_to :organization_status_type
      t.belongs_to :organization
      t.belongs_to :participant
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :organization_statuses, :organization_id
  end
end

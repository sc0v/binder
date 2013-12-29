class CreateOrganizationStatuses < ActiveRecord::Migration
  def change
    create_table :organization_statuses do |t|
      t.belongs_to :organization_status_type
      t.belongs_to :organization
      t.belongs_to :participant
      t.string :description
    end
    add_index :organization_statuses, :organization_id
  end
end

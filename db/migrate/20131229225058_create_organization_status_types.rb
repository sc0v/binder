class CreateOrganizationStatusTypes < ActiveRecord::Migration
  def change
    create_table :organization_status_types do |t|
      t.string :name
      t.boolean :display
    end
  end
end

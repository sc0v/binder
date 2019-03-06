class DropPhoneCarrier < ActiveRecord::Migration
  def change
    remove_foreign_key :participants, :phone_carrier
    remove_column :participants, :phone_carrier_id
    remove_index :participants, :name => "index_organization_timeline_entries_on_organization_id"
    drop_table :phone_carriers
  end
end

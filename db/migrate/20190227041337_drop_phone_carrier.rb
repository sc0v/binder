class DropPhoneCarrier < ActiveRecord::Migration
  def change
    drop_table :phone_carriers
    delete_column :participants, :phone_carrier_id
    remove_index :participants, :name => "index_participants_on_phone_carrier_id"
  end
end

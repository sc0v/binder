class DropPhoneCarrier < ActiveRecord::Migration
  def change
    remove_foreign_key :participants, :phone_carrier
    drop_table :phone_carriers
  end
end

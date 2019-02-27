class DropPhoneCarrier < ActiveRecord::Migration
  def change
    drop_table :phone_carriers
  end
end

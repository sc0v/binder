# frozen_string_literal: true

class DropPhoneCarrier < ActiveRecord::Migration[6.0]
  def up
    remove_reference :participants,
                     :phone_carrier,
                     index: true,
                     foreign_key: true
    drop_table :phone_carriers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

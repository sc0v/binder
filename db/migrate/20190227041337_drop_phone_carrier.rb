# frozen_string_literal: true

class DropPhoneCarrier < ActiveRecord::Migration[4.2]
  def change
    remove_reference :participants, :phone_carrier, index: true, foreign_key: true
    drop_table :phone_carriers
  end
end

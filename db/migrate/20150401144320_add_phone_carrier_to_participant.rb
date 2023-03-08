# frozen_string_literal: true

class AddPhoneCarrierToParticipant < ActiveRecord::Migration[4.2]
  def change
    add_reference :participants, :phone_carrier, index: true
    add_foreign_key :participants, :phone_carriers
  end
end

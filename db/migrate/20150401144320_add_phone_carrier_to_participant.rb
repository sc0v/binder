class AddPhoneCarrierToParticipant < ActiveRecord::Migration
  def change
    add_reference :participants, :phone_carrier, index: true
    add_foreign_key :participants, :phone_carriers
  end
end

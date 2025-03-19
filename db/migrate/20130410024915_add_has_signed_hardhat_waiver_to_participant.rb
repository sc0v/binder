# frozen_string_literal: true
class AddHasSignedHardhatWaiverToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :has_signed_hardhat_waiver, :boolean
  end
end

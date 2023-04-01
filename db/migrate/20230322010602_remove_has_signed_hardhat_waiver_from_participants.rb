# frozen_string_literal: true
class RemoveHasSignedHardhatWaiverFromParticipants < ActiveRecord::Migration[
  7.0
]
  def up
    remove_column :participants, :has_signed_hardhat_waiver
  end

  def down
    add_column :participants, :has_signed_hardhat_waiver, :boolean
  end
end

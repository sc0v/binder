class AddHasSignedHardhatWaiverToParticipant < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :has_signed_hardhat_waiver, :boolean
  end
end

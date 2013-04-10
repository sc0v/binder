class AddHasSignedHardhatWaiverToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :has_signed_hardhat_waiver, :boolean
  end
end

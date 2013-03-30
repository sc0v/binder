class AddHasSignedWaiverToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :has_signed_waiver, :boolean
  end
end

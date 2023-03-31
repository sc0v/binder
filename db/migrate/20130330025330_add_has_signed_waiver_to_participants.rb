# frozen_string_literal: true
class AddHasSignedWaiverToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :has_signed_waiver, :boolean
  end
end

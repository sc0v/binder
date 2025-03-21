# frozen_string_literal: true
class AddHasSignedWaiverToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :has_signed_waiver, :boolean
  end
end

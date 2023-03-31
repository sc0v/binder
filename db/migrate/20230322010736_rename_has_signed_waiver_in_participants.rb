# frozen_string_literal: true
class RenameHasSignedWaiverInParticipants < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :participants, :has_signed_waiver, :signed_waiver
  end

  def self.down
    rename_column :participants, :signed_waiver, :has_signed_waiver
  end
end

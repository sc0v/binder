# frozen_string_literal: true
class RenameAndrewidInParticipants < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :participants, :andrewid, :eppn
  end

  def self.down
    rename_column :participants, :eppn, :andrewid
  end
end

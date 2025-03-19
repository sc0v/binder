# frozen_string_literal: true
class ReplaceMembershipWithParticipantAndOrganizationInCheckouts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts, :participant_id, :integer
    add_column :checkouts, :organization_id, :integer
    remove_column :checkouts, :membership_id
  end
end

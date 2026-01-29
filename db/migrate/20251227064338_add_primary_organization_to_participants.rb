class AddPrimaryOrganizationToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_reference :participants,
                  :primary_organization,
                  foreign_key: { to_table: :organizations }
  end
end

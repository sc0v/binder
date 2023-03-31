# frozen_string_literal: true
class CreateMemberships < ActiveRecord::Migration[4.2]
  def change
    create_table :memberships do |t|
      t.references :organization
      t.references :participant
      t.boolean :is_chair

      t.timestamps
    end
    add_index :memberships, :organization_id
    add_index :memberships, :participant_id
  end
end

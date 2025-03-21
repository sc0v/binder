# frozen_string_literal: true
class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :organization
      t.references :participant
      t.boolean :is_chair

      t.timestamps
    end
  end
end

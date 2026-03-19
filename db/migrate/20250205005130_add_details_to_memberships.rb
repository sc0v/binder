# frozen_string_literal: true

class AddDetailsToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :is_in_csv, :boolean, null: false, default: false
    add_column :memberships,
               :is_added_by_csv,
               :boolean,
               null: false,
               default: false
  end
end

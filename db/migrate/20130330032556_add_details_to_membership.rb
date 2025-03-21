# frozen_string_literal: true
class AddDetailsToMembership < ActiveRecord::Migration[6.0]
  def up
    add_column :memberships, :is_booth_chair, :boolean
    add_column :memberships, :title, :string

    remove_column :memberships, :is_chair
  end

  def down
    remove_column :memberships, :is_booth_chair
    remove_column :memberships, :title

    add_column :memberships, :is_chair, :boolean
  end
end

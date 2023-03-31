# frozen_string_literal: true
class AddBoothChairOrderToMembership < ActiveRecord::Migration[4.2]
  def change
    add_column :memberships, :booth_chair_order, :integer
  end
end

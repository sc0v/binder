# frozen_string_literal: true
class AddBoothChairOrderToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :booth_chair_order, :integer
  end
end

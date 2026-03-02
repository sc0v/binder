# frozen_string_literal: true

class AddIsForfeitToScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    add_column :scissor_lift_checkouts,
               :is_forfeit,
               :boolean,
               null: false,
               default: false
  end
end

class AddIsForfeitToScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    add_column :scissor_lift_checkouts, :is_forfeit, :boolean
  end
end

class RemoveCheckoutDurationFromScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :scissor_lift_checkouts, :checkout_duration, :datetime
  end
end

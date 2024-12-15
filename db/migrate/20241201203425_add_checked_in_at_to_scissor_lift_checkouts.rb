class AddCheckedInAtToScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    add_column :scissor_lift_checkouts, :checked_in_at, :datetime
  end
end

class AddDueAtToScissorLiftCheckouts < ActiveRecord::Migration[7.0]
  def change
    add_column :scissor_lift_checkouts, :due_at, :datetime
  end
end

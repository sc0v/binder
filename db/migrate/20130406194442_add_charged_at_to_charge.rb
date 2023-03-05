class AddChargedAtToCharge < ActiveRecord::Migration[4.2]
  def change
    add_column :charges, :charged_at, :datetime
  end
end

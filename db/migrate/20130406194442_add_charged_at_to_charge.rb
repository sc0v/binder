class AddChargedAtToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :charged_at, :datetime
  end
end

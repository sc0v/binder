# frozen_string_literal: true
class AddChargedAtToCharge < ActiveRecord::Migration[6.0]
  def change
    add_column :charges, :charged_at, :datetime
  end
end

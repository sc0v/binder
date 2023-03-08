# frozen_string_literal: true

class StoreItem < ApplicationRecord
  has_many :store_purchases

  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def quantity_available
    return if quantity.nil?

    quantity - (store_purchases.where(charge: nil).pluck(:quantity_purchased).inject do |sum, x|
                  sum + x
                end || 0)
  end
end

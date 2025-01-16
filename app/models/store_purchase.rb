# frozen_string_literal: true

class StorePurchase < ApplicationRecord
  include Rails.application.routes.url_helpers
  # relationships
  belongs_to :charge, optional: true
  belongs_to :store_item
  has_one :organization, through: :charge

  # scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  delegate :name, to: :store_item, allow_nil: true 

  # methods
  def self.items_in_cart
    where(charge: nil)
  end

  def self.items_in_cart?
    items_in_cart.size.positive?
  end
end

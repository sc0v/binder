class StorePurchase < ActiveRecord::Base
  #relationships
  belongs_to :charge
  belongs_to :store_item
  has_one :organization, through: :charge
  
  #scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  #methods
  def self.items_in_cart
    self.where(charge: nil)
  end

  def self.items_in_cart?
    items_in_cart.size > 0
  end

end

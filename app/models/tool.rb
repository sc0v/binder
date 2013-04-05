class Tool < ActiveRecord::Base
  attr_accessible :barcode, :description, :name, :checkouts
  validates :barcode, :uniqueness => true
  validates :name, :presence => true

  has_many :checkouts

  scope :not_hardhats, where('NAME NOT LIKE "%hardhat"')
  scope :hardhats, where('NAME LIKE "%hardhat"')

  def current_organization
    if not self.checkouts.current.empty?
      return self.checkouts.current[0].organization
    end
  end

  def current_participant
    if not self.checkouts.current.empty?
      return self.checkouts.current[0].participant
    end
  end

  def is_checked_out
    return not(self.checkouts.current.empty?)
  end
end

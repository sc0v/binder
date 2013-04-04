class Tool < ActiveRecord::Base
  attr_accessible :barcode, :description, :name, :checkouts
  validates :barcode, :uniqueness => true
  validates :name, :presence => true

  has_many :checkouts
end

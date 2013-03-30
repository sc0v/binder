class Tool < ActiveRecord::Base
  attr_accessible :barcode, :description, :name
  validates :barcode, :uniqueness => true
  validates :name, :presence => true

  has_many :checkouts
end

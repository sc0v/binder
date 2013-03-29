class Organization < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  belongs_to :category
  validates_associated :category
  has_many :members
end

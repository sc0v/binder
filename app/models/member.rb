class Member < ActiveRecord::Base
  attr_accessible :andrewid, :first_name, :last_name, :chair
  validates :andrewid, :presence => true, :uniqueness => true
  validates :first_name, :last_name, :organization_id, :chair, :presence => true
  belongs_to :organization
  validates_associated :organizaion
end

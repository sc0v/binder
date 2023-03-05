class OrganizationCategory < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organizations, :dependent => :destroy
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
end


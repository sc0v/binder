class OrganizationCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :organizations
end

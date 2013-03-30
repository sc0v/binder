class Organization < ActiveRecord::Base
  belongs_to :organization_category
  attr_accessible :name
end

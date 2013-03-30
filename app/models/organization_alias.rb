class OrganizationAlias < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :alias
end

class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :participant
  attr_accessible :is_booth_chair, :title
end

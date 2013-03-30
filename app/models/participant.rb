class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :has_signed_waiver
  validates :andrewid, :presence => true, :uniqueness => true
  validates :has_signed_waiver, :acceptance => true
end

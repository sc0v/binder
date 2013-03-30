class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :cardnumber
  validates :andrewid, :presence => true, :uniqueness => true
end

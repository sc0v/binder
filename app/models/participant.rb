class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :has_signed_waiver
  validates :andrewid, :presence => true, :uniqueness => true
  validates :has_signed_waiver, :acceptance => true
  has_many :organizations, :through => :memberships
  has_many :shifts, :through => :shift_participants
  has_many :organizations, :through => :memberships
  has_many :memberships
  has_many :shift_participants
end

class Participant < ActiveRecord::Base
  attr_accessible :andrewid, :has_signed_waiver, :phone_number
  validates :andrewid, :presence => true, :uniqueness => true
  validates :has_signed_waiver, :acceptance => true
  validates :phone_number, :length => { :minimum => 10, :maximum => 10}, :numericality => true, :allow_nil => true
  has_many :organizations, :through => :memberships
  has_many :shifts, :through => :shift_participants
  has_many :organizations, :through => :memberships
  has_many :memberships
  has_many :shift_participants
end

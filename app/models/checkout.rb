class Checkout < ActiveRecord::Base
  attr_accessible :checked_in_at, :checked_out_at, :membership, :tool, :participant, :organization
  validates :checked_out_at, :membership_id, :tool_id , :presence => true
  belongs_to :membership
  has_one :participant, :through => :membership
  has_one :organization, :through => :membership
  belongs_to :tool
  attr_accessible :membership_id
  scope :old, where('checked_in_at is not null')
  scope :current, where('checked_in_at is null').limit(1)

end

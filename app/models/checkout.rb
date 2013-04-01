class Checkout < ActiveRecord::Base
  attr_accessible :checked_in_at, :checked_out_at, :membership, :tool
  validates :checked_out_at, :membership_id, :tool_id , :presence => true
  belongs_to :membership
  belongs_to :tool
  attr_accessible :membership_id
end

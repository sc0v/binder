class Checkout < ActiveRecord::Base
  attr_accessible :checked_in_at, :checked_out_at, :membership, :tool
  belongs_to :membership
  belongs_to :tool
  attr_accessible :membership_id
end

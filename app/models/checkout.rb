class Checkout < ActiveRecord::Base
  attr_accessible :checked_in_at, :checked_out_at, :tool, :participant, :organization, 
    :participant_id, :organization_id, :tool_id
  validates :checked_out_at, :tool_id, :presence => true
  belongs_to :participant
  belongs_to :organization
  belongs_to :tool

  default_scope order('tool_id and checked_out_at DESC')
  scope :old, where('checked_in_at is not null')
  scope :current, where('checked_in_at is null')
end

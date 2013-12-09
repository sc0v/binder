class Checkout < ActiveRecord::Base
  # attr_accessible :checked_in_at, :checked_out_at, :participant, :organization, :tool

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

  validates_presence_of :tool, :organization
  validates_associated :tool, :organization

  before_save :checked_out_at, :presence => true

  belongs_to :participant
  belongs_to :organization
  belongs_to :tool

  default_scope { order('tool_id ASC, checked_out_at DESC') }
  scope :old, -> { where('checked_in_at IS NOT NULL') }
  scope :current, -> { where('checked_in_at IS NULL') }

end

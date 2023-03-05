class Checkout < ActiveRecord::Base
  include Messenger

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

  validates_presence_of :tool, :organization, :checked_out_at
  validates_associated :tool, :organization, :participant

  belongs_to :participant, :touch => true
  belongs_to :organization, :touch => true
  belongs_to :tool, :touch => true

  default_scope { order('tool_id ASC, checked_out_at DESC') }
  scope :old, -> { where('checked_in_at IS NOT NULL') }
  scope :current, -> { where('checked_in_at IS NULL') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

end

class EventType < ActiveRecord::Base
  has_many :events, dependent: :destroy
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end

# frozen_string_literal: true

class NotificationSubscription < ApplicationRecord
  belongs_to :participant

  validates :endpoint, presence: true
  validates :endpoint, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end

# frozen_string_literal: true

class EventType < ApplicationRecord
  has_many :events, dependent: :destroy
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end

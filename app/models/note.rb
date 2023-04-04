# frozen_string_literal: true
class Note < ApplicationRecord
  belongs_to :participant
  belongs_to :organization, optional: true

  scope :unhidden, -> { where(hidden: false) }
end

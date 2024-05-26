# frozen_string_literal: true
class Note < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  belongs_to :participant
  belongs_to :organization, optional: true

  scope :unhidden, -> { where(hidden: false) }
  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  delegate :name, to: :participant, prefix: :participant, allow_nil: true
  delegate :link, to: :participant, prefix: :participant, allow_nil: true
  delegate :name, to: :organization, prefix: :organization, allow_nil: true
  delegate :link, to: :organization, prefix: :organization, allow_nil: true
  
  def link
    note_path(self)
  end

   def updated_at(format: :timestamp)
    I18n.l self[:updated_at], format:
  end
end

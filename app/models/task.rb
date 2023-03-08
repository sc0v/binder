# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :due_at, presence: true
  # validates :completed_by, :presence => true, :unless => :is_uncompleted?

  belongs_to :completed_by, class_name: 'Participant'

  default_scope { order('due_at ASC') }
  scope :upcoming, -> { where('due_at < ?', DateTime.now + 4.hours) }
  scope :is_incomplete, -> { where(is_completed: [false, nil]) }
  scope :is_complete, -> { where(is_completed: true) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def is_past_due
    due_at < Time.zone.now
  end
end

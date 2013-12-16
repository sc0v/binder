class Task < ActiveRecord::Base

  validates :name, :due_at, :presence => true
  #validates :completed_by, :presence => true, :unless => :is_uncompleted?

  belongs_to :completed_by, :class_name => "Participant"

  default_scope { order('due_at DESC') }
  scope :upcoming, lambda{ where("due_at < ? and is_completed = ?", Time.now + 1.hour, true) }

  def is_past_due
    return self.due_at < Time.now
  end
end


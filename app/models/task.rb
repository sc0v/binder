class Task < ActiveRecord::Base

  validates :name, :due_at, :presence => true
  #validates :completed_by, :presence => true, :unless => :is_uncompleted?

  belongs_to :completed_by, :class_name => "Participant"

  default_scope { order('due_at ASC') }
  scope :upcoming, lambda{ where("due_at < ?", DateTime.now + 4.hour) }
  scope :is_incomplete, lambda{ where(is_completed: [false, nil])}
  scope :is_complete, lambda{ where(is_completed: true)}
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
  def is_past_due
    return self.due_at < Time.now
  end
end


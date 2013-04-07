class Task < ActiveRecord::Base
  attr_accessible :completed_by, :description, :display_duration, :due_at, :name, :task_status
  validates :name, :due_at, :task_status_id, :presence => true
  belongs_to :task_status
  belongs_to :completed_by, :class_name => "Participant"
end

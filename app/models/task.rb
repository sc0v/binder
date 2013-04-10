class Task < ActiveRecord::Base
  attr_accessible :completed_by, :description, :display_duration, :due_at, :name, :task_status
  validates :name, :due_at, :task_status_id, :presence => true
  belongs_to :task_status
  belongs_to :completed_by, :class_name => "Participant"

  default_scope order('due_at DESC')
  scope :completed, where(:task_status_id => TaskStatus.find_by_name("Completed"))
  scope :uncompleted, where(:task_status_id => TaskStatus.find_by_name("Not Completed"))
  scope :unable_to_complete, where(:task_status_id => TaskStatus.find_by_name("Unable To Complete"))
  scope :upcoming, lambda{ where("display_duration < ? and task_status_id = ?", Time.now, TaskStatus.find_by_name("Not Completed")) }

  def is_past_due
    return self.due_at < Time.now
  end
end

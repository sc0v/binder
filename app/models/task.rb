# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`completed_by_id`**  | `integer`          |
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`due_at`**           | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`is_completed`**     | `boolean`          |
# **`name`**             | `string(255)`      |
# **`updated_at`**       | `datetime`         |
#

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


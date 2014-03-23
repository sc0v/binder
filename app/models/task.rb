# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`completed_by_id`**  | `integer`          |
# **`created_at`**       | `datetime`         |
# **`description`**      | `text`             |
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
  scope :upcoming, lambda{ where("due_at < ? and is_completed = ?", Time.now + 4.hour, true) }

  def is_past_due
    return self.due_at < Time.now
  end
end


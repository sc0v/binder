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
# **`name`**             | `string`           |
# **`updated_at`**       | `datetime`         |
#

class Task < ActiveRecord::Base
  #AS OF 2018 TASKS HAVE BEEN REPLACED BY GOOGLE CALENDAR API
  #Uncomment if you are reimplementing the Task model



  # validates :name, :due_at, :presence => true

  # belongs_to :completed_by, :class_name => "Participant"

  # default_scope { order('due_at ASC') }
  # scope :upcoming, lambda{ where("due_at < ?", DateTime.now + 4.hour) }
  # scope :is_incomplete, lambda{ where(is_completed: [false, nil])}
  # scope :is_complete, lambda{ where(is_completed: true)}
  # def is_past_due
  #   return self.due_at < Time.now
  # end
end


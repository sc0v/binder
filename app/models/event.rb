# ## Schema Information
#
# Table name: `events`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`active`**          | `boolean`          | `default(TRUE)`
# **`created_at`**      | `datetime`         |
# **`description`**     | `text(65535)`      |
# **`event_type_id`**   | `integer`          |
# **`id`**              | `integer`          | `not null, primary key`
# **`is_done`**         | `boolean`          |
# **`participant_id`**  | `integer`          |
# **`updated_at`**      | `datetime`         |
#

include Messenger
class Event < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :participant

  after_create :send_notifications

  scope :displayable, -> { joins(:event_type).where(is_done:false).where('event_types.display = ?', true) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  #send notification to assignee if their phone is in system
  def send_notifications
    if self.participant != nil
      if self.participant.phone_number.length == 10
        #grab first 95 characters of description to serve as a preview
        description_preview = self.description[0...95]
        send_sms(self.participant.phone_number, "An event in Binder has been assigned to you: " + description_preview + "...")
      end
    end
  end

end

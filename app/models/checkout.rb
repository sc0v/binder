# ## Schema Information
#
# Table name: `checkouts`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`checked_in_at`**    | `datetime`         |
# **`checked_out_at`**   | `datetime`         |
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_id`**          | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_checkouts_on_tool_id`:
#     * **`tool_id`**
#

class Checkout < ActiveRecord::Base
  include Messenger

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

  # def reply_to(message_content)
  #   process_text(message_content)
  # end

  validates_presence_of :tool, :organization
  validates_associated :tool, :organization, :participant

  before_save :checked_out_at, :presence => true
  after_update :notify

  belongs_to :participant, :touch => true
  belongs_to :organization, :touch => true
  belongs_to :tool, :touch => true

  default_scope { order('tool_id ASC, checked_out_at DESC') }
  scope :old, -> { where('checked_in_at IS NOT NULL') }
  scope :current, -> { where('checked_in_at IS NULL') }

  private

  def notify
    if (self.checked_in_at != nil)
      toolCategory = self.tool.tool_type
      waitlist = ToolWaitlist.for_tool_type(toolCategory.id).by_wait_start_time
      if (waitlist.count != 0)
        nextPerson = waitlist.first.participant
        unless (nextPerson.phone_number.blank?)
          number = nextPerson.phone_number
          content = "#{toolCategory.name} is now available at the trailer. Please come pick it up within 5 minutes!"
          send_sms(number, content)
        end
      end
    end
  end

  # def process_text(message_content)
  #   mc = message_content.downcase
  #   if (!self.checked_in_at.blank?)
  #     if (mc.match("cancel"))
  #       toolCategory = self.tool.tool_type
  #       waitlist = ToolWaitlist.for_tool_type(toolCategory.id).by_wait_start_time
  #       nextPerson = waitlist.first.participant
  #       first_wait = waitlist.first
  #       first_wait.destroy
  #       unless (nextPerson.phone_number.blank?)
  #         number = nextPerson.phone_number
  #         content = "You have been removed from the waitlist for #{toolCategory.name}! Happy building!"
  #         send_sms(number, content)
  #         puts("I sent out my text boy!!!! \n\n\n")
  #       end
  #     else
  #       puts("Don't send non-keywords back!")
  #     end
  #   end
  # end
end
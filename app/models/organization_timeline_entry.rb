# ## Schema Information
#
# Table name: `organization_timeline_entries`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`ended_at`**         | `datetime`         |
# **`entry_type`**       | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`started_at`**       | `datetime`         |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_organization_timeline_entries_on_organization_id`:
#     * **`organization_id`**
#

include Messenger

class OrganizationTimelineEntry < ActiveRecord::Base
  validates_presence_of :organization, :started_at, :entry_type
  validates_associated :organization

  enum entry_type: { structural: 0, electrical: 1, downtime: 2}

  belongs_to :organization, :touch => true

  default_scope { order('started_at asc') }
  scope :current, -> { where(ended_at: nil) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def duration
    return ended_at.to_i - started_at.to_i unless ended_at.blank?
    return DateTime.now.to_i - started_at.to_i
  end

  def already_in_queue?
    ['structural', 'electrical'].include?(entry_type) &&
      !organization.organization_timeline_entries.current.send(entry_type).empty?
  end

  #notifcations 
  after_create :notifyStart, :notify_booth_committee
  after_update :notifyEnd

  def notifyStart
    if entry_type == 'downtime'
      for chair in organization.booth_chairs
        if chair.phone_number.length == 10
          send_sms(chair.phone_number, "Downtime for your organization, " +organization.name+", has started.")
        end
      end
    end
  end

  def notifyEnd
    if entry_type == 'downtime'
      for chair in organization.booth_chairs
        if chair.phone_number.length == 10
          send_sms(chair.phone_number, "Downtime for your organization, " +organization.name+", has ended. You have "+Time.at(organization.remaining_downtime).utc.strftime("%H hours %M minutes")+" left.")
        end
      end
    end
  end

  def notify_booth_committee
    # post in the relevant groupme when someone joins a queue
    bot_id = case entry_type
      when 'structural'
        ENV["STRUCTURAL_BOT_ID"]
      when 'electrical'
        ENV["ELECTRICAL_BOT_ID"]
    end

    if not bot_id.nil?
      description_text = description.blank? ? "was added" : "needs #{description}"
      send_groupme(bot_id, "#{entry_type.titlecase} Queue: #{organization.short_name} #{description_text}")
    end
  end
end

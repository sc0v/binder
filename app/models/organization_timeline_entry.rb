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
    # post in the relevant groupme/slack when someone joins a queue
    
    slack_webhook_urls = case entry_type
      when 'structural'
        [ ENV["SLACK_BOT_STRUCTURAL_WEBHOOK_URL"] ]
      when 'electrical'
        [ ENV["SLACK_BOT_ELECTRICAL_WEBHOOK_URL"], ENV["SLACK_BOT_ELECTRICAL_PRIVATE_WEBHOOK_URL"] ]
    end
    
    groupme_bot_ids = case entry_type
      when 'structural'
        [ ENV["GROUPME_STRUCTURAL_BOT_ID"] ]
      when 'electrical'
        [ ENV["GROUPME_ELECTRICAL_BOT_ID"] ]
    end
    
    description_text = description.blank? ? "was added" : "was added for: #{description}"
    message_text = "#{entry_type.titlecase} Queue: #{organization.short_name} #{description_text}"

    slack_webhook_urls.each do |slack_webhook_url|
      if not slack_webhook_url.nil?
        send_slack(slack_webhook_url, message_text)
      end
    end
    
    groupme_bot_ids.each do |groupme_bot_id|
      if not groupme_bot_id.nil?
        send_groupme(groupme_bot_id, message_text)
      end
    end
    
  end
end

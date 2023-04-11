# frozen_string_literal: true

include Messenger
# require 'twilio-ruby'
# require 'daemons'
# require 'delayed_job'
# require 'delayed_job_active_record'

class Shift < ApplicationRecord
  validates :starts_at, :ends_at, :required_number_of_participants, presence: true
  validates_associated :organization, :shift_type

  belongs_to :organization
  belongs_to :shift_type

  has_many :shift_participants, dependent: :destroy
  has_many :participants, through: :shift_participants

  default_scope { order('starts_at asc') }
  scope :current, -> { where('starts_at < ? and ends_at > ?', Time.zone.now, Time.zone.now) }
  scope :future, -> { where('starts_at > ?', Time.zone.now) }
  scope :upcoming, -> { where('starts_at > ? and starts_at < ?', Time.zone.now, 4.hours.from_now) }
  scope :past, -> { where('ends_at < ?', Time.zone.now) }
  scope :missed, lambda {
                   where("required_number_of_participants > (
                                    SELECT COUNT(*)
                                    FROM shift_participants
                                    WHERE shift_participants.shift_id = shifts.id)")
                 }

  # scopes for each type of shift, selected by their shift_type ID
  # TODO: These can almost definitely be made more elegant
  scope :watch_shifts, -> { where(shift_type_id: ShiftType.where('name = "Watch Shift"').first.id) }
  scope :sec_shifts, -> { where(shift_type_id: ShiftType.where('name = "Security Shift"').first.id) }
  scope :coord_shifts, -> { where(shift_type_id: ShiftType.where('name = "Coordinator Shift"').first.id) }

  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  @@notify = 1.hour
  @@notify2 = 5.minutes

  after_create :send_notifications
  after_create :send_late_notifications

  def formatted_name
    if organization.blank?
      "#{shift_type.name} @ #{starts_at.strftime('%b %e at %l:%M %p')}"
    else
      "#{shift_type.name} @ #{starts_at.strftime('%b %e at %l:%M %p')} - #{organization.name}"
    end
  end

  def is_checked_in
    participants.size == required_number_of_participants
    puts "size: #{participants.size}, required: #{required_number_of_participants}"
  end

  def self.for_organizations(organizations)
    if organizations.nil?
      all
    else
      where(organization_id: organizations)
    end
  end

  def when_to_run_normal
    starts_at - @@notify
  end

  def when_to_run_late
    starts_at + @@notify2
  end

  # send notification to booth chairs of shift's org 1 hour before watch shift starts
  def send_notifications
    return unless shift_type.name == 'Watch Shift'

    organization.booth_chairs.each do |chair|
      if chair.phone_number.length == 10
        send_sms(chair.phone_number, "A watch shift for #{organization.name} starts in 1 hour.")
      end
    end
  end

  # send notification to booth chairs of shift's org if required # of people haven't clocked in
  def send_late_notifications
    if shift_type.name == 'Watch Shift' && is_checked_in == false
      organization.booth_chairs.each do |chair|
        if chair.phone_number.length == 10
          send_sms(chair.phone_number,
                   "Only #{participants.size} of #{required_number_of_participants} people for your watch shift have checked in. Please send more people as soon as possible.")
        end
      end
    elsif shift_type.name == 'Watch Shift' && is_checked_in == true
      organization.booth_chairs.each do |chair|
        if chair.phone_number.length == 10
          send_sms(chair.phone_number,
                   'The required number of people for your watch shift have checked in. Thank you!')
        end
      end
    end
  end

  # delays all jobs using delayed_jobs gem
  # handle_asynchronously :send_notifications, :run_at => Proc.new { |i| i.when_to_run_normal }
  # handle_asynchronously :send_late_notifications, :run_at => Proc.new { |i| i.when_to_run_late }
end

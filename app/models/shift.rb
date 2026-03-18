# frozen_string_literal: true

# require 'twilio-ruby'
# require 'daemons'
# require 'delayed_job'
# require 'delayed_job_active_record'

class Shift < ApplicationRecord
  include Messenger

  validates :andrew_id, presence: true
  validates :starts_at,
            :ends_at,
            presence: true
  validates_associated :organization, :shift_type

  belongs_to :organization
  belongs_to :shift_type

  has_many :shift_participants, dependent: :destroy
  has_many :participants, through: :shift_participants

  default_scope { order(:starts_at) }
  scope :current,
        lambda {
          where('starts_at < ? and ends_at > ?', Time.zone.now, Time.zone.now)
        }
  scope :future, -> { where('starts_at > ?', Time.zone.now) }
  scope :upcoming,
        lambda {
          where(
            'starts_at > ? and starts_at < ?',
            Time.zone.now,
            4.hours.from_now
          )
        }
  scope :past, -> { where(ends_at: ...Time.zone.now) }
  # scope :missed,
  #       lambda {
  #         where(
  #           'required_number_of_participants > (
  #                                   SELECT COUNT(*)
  #                                   FROM shift_participants
  #                                   WHERE shift_participants.shift_id = shifts.id)'
  #         )
  #       }

  # scopes for each type of shift, selected by their shift_type ID
  # TODO: These can almost definitely be made more elegant
  scope :watch_shifts,
        lambda {
          where(shift_type_id: ShiftType.where('name = "Watch Shift"').first.id)
        }
  scope :sec_shifts,
        lambda {
          where(shift_type_id: ShiftType.find_by(name: 'Security Shift').id)
        }
  scope :coord_shifts,
        lambda {
          where(
            shift_type_id:
              ShiftType.where('name = "Coordinator Shift"').first.id
          )
        }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  NOTIFY_BEFORE_START = 1.hour
  NOTIFY_AFTER_START = 5.minutes

  after_create :send_notifications
  after_create :send_late_notifications

  def formatted_name
    if organization.blank?
      "#{shift_type.name} @ #{starts_at.strftime('%b %e at %l:%M %p')}"
    else
      "#{shift_type.name} @ #{starts_at.strftime('%b %e at %l:%M %p')} - #{organization.name}"
    end
  end

  def checked_in?
    participants.size
    # required_number_of_participants
    # Rails.logger.debug do
    #   "size: #{participants.size}, required: #{required_number_of_participants}"
    # end
  end

  def self.for_organizations(organizations)
    organizations.nil? ? all : where(organization_id: organizations)
  end

  def when_to_run_normal
    starts_at - NOTIFY_BEFORE_START
  end

  def when_to_run_late
    starts_at + NOTIFY_AFTER_START
  end

  # send notification to booth chairs of shift's org 1 hour before watch shift starts
  def send_notifications
    return unless shift_type.name == 'Watch Shift'

    notify_booth_chairs(
      "A watch shift for #{organization.name} starts in 1 hour."
    )
  end

  # send notification to booth chairs of shift's org if required # of people haven't clocked in
  def send_late_notifications
    return unless shift_type.name == 'Watch Shift'

    message =
      checked_in? ? late_checked_in_message : late_not_checked_in_message
    notify_booth_chairs(message)
  end

  # delays all jobs using delayed_jobs gem
  # handle_asynchronously :send_notifications, :run_at => Proc.new { |i| i.when_to_run_normal }
  # handle_asynchronously :send_late_notifications, :run_at => Proc.new { |i| i.when_to_run_late }

  private

  def notify_booth_chairs(message)
    organization.booth_chairs.each do |chair|
      next unless chair.phone_number.length == 10

      send_sms(chair.phone_number, message)
    end
  end

  def late_not_checked_in_message
    # "Only #{participants.size} of #{required_number_of_participants} people for your " \
    #   'watch shift have checked in. Please send more people as soon as possible.'
    'Not everyone from your organization checked in, please send more people as soon as possible.'
  end

  def late_checked_in_message
    'The required number of people for your watch shift have checked in. Thank you!'
  end

  after_create :create_default_participant
  def create_default_participant
    return if andrew_id.blank?

    eppn = "#{andrew_id}@andrew.cmu.edu"
    participant = Participant.find_by(eppn:)
    return if participant.nil?

    ShiftParticipant.create!(shift: self, participant:)
  end
end

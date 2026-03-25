# frozen_string_literal: true
module Participants::SafetyBriefingsHelper
  def safety_video_duration(duration)
    ActiveSupport::Duration.build(duration).inspect
  end

  def page_title(participant)
    if participant.watched_safety_video?
      'Review Mandatory Safety Video'
    else
      'Watch the Mandatory Safety Video'
    end
  end

  def page_instructions(participant, duration)
    if can?(:skip_safety_video, Current.user)
      if Current.user == participant
        Current.user.watched_safety_video? ? NOTE_REWATCHING : NOTE_ADMIN
      else
        note_admin_visitor(participant)
      end
    else # user's first time watching the video
      'Please watch the safety video prior to signing the waiver. It will ' \
        "take #{safety_video_duration(duration)}."
    end
  end

  NOTE_ADMIN =
    '<strong>Note:</strong> This is a privileged user account with playback ' \
      'controls enabled.'
  private_constant :NOTE_ADMIN

  NOTE_REWATCHING =
    'You have already watched the safety video all the way through, so ' \
      'playback controls are enabled.'
  private_constant :NOTE_REWATCHING

  private

  def note_admin_visitor(participant)
    "<strong>Note for #{Current.user.name}</strong>:<br />" \
      'You are currently on the safety briefing page for ' \
      "<strong>#{participant.name}</strong>. Please ensure they are familiar " \
      'with the content if you are going to skip ahead to the end of the video.'
  end
end

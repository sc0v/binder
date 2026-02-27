# frozen_string_literal: true

class OrganizationBuildStep < ApplicationRecord
  belongs_to :organization_build_status
  belongs_to :approver, class_name: "Participant", optional: true

  scope :enabled, -> { where(is_enabled: true) }
  scope :disabled, -> { where(is_enabled: [nil, false]) }

  def self.format_note(note)
    return "No notes or requirements listed." if note.blank?

    # Replace URLs with links (https://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string)
    regex =
      %r{(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])}
    note = note.gsub(regex) { |link| "<a href=#{link}>#{link}</a>" }

    ActionController::Base.helpers.simple_format(note)
  end
end

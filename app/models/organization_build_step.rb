class OrganizationBuildStep < ApplicationRecord  
  belongs_to :organization_build_status
  belongs_to :approver, class_name: 'Participant', optional: true

  scope :enabled, -> { where(is_enabled: true) }
  scope :disabled, -> { where(is_enabled: [nil, false]) }

  def self.format_note(note)
    unless note.present? 
      return "No notes or requirements listed."
    end

    # Replace URLs with links (https://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string)
    regex = /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])/
    note = note.gsub(regex) { |link| "<a href=#{link}>#{link}</a>"}

    return ActionController::Base.helpers.simple_format(note)
  end
end

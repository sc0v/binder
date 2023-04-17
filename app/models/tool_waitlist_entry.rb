class ToolWaitlistEntry < ApplicationRecord
  before_create do 
    validate_tool_request
    if errors.present?
      throw(:abort)
    end
  end

  belongs_to :organization
  belongs_to :participant
  belongs_to :tool_waitlist

  enum :status, { waiting: 1, fulfilled: 2, cancelled: 3 }, scopes: true, default: :waiting
  
  scope :by_organization, -> (organization){where('organization_id = ?', organization.id)}

  def change_status_to_fulfilled
    self.update_attribute(:status, 2)
    self.update_attribute(:end_at, DateTime.current)
  end

  def change_status_to_cancelled
    self.update_attribute(:status, 3)
    self.update_attribute(:end_at, DateTime.current)
  end

  private
    def validate_tool_request
      requests = ToolWaitlistEntry.by_organization(self.organization).waiting.count
      # note: must use < and NOT <= in order to get boolean to work properly
      unless (requests < 2)
          errors.add(:tool_waitlist_entry, "You cannot request this tool, you have already reached your limit!");
      end
    end
end

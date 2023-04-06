class WaitlistEntry < ApplicationRecord
  belongs_to :organization
  belongs_to :participant
  belongs_to :tool_type
  belongs_to :tool_waitlist

  enum :status, { waiting: 1, fulfilled: 2, cancelled: 3 }, scopes: true, default: :waiting

  # def validate_tool_request
  #   t = ToolType.find(self.tools.size)
  #   @requests = ToolWaitlist.tool_type_for_org(self.organization_id, self.tool_type_id)
  #   unless quota_not_reached?(@requests)
  #       errors.add(:tool_waitlist, “You cannot request this tool, you have already reached your limit!”);
  #   end
  # end

  # def quota_not_reached?(@requests)
  #   return @requests.pending.count < 2;
  # end    
end

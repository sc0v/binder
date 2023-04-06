class ToolType < ApplicationRecord
    before_save :validate_tool_request

    has_many :organizations
    has_many :participants, through: :organizations
    has_many :waitlist_entries

    scope :pending, -> { where(‘end_at = ?’, nil)}
    scope :completed, -> { where(‘end_at != ?’, nil)}
    scope :for_organization, -> (organization) {where('organization_id = ?', organization_id)}
    scope :for_tool_type, -> (tool_type) {where('tool_type_id = ?', tool_type_id)}
    scope :tool_type_for_org, -> (organization, tool_type) {where('organization_id = ? AND tool_type_id = ?', organization_id, tool_type_id)}

    private

    # def validate_tool_request
    #     t = ToolType.find(self.tools.size)
    #     @requests = ToolWaitlist.tool_type_for_org(self.organization_id, self.tool_type_id)
    #     unless quota_not_reached?(@requests)
    #         errors.add(:tool_waitlist, “cannot request multiple of the same tool”)
    #     end
    # end
    
    # def quota_not_reached?(@requests)
    #     return @requests.pending.count < 2
    # end    

    # def check_if_off_waitlist
    #     if self.end_at.nil?
    #         return false
    #     else
    #         return true
    #     end
    # end 
    

end
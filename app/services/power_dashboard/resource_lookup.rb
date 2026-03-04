# frozen_string_literal: true

module PowerDashboard
  class ResourceLookup
    def lookup_resource(input)
      organization = Organization.find_by_query(input, exact: true)
      return { type: :organization, record: organization } if organization.present?

      scissor_lift = ScissorLift.find_by_query(input)
      return { type: :scissor_lift, record: scissor_lift } if scissor_lift.present?

      tool = Tool.find_by_query(input)
      return { type: :tool, record: tool } if tool.present?

      participant = Participant.find_by_query(input)
      return { type: :participant, record: participant } if participant.present?

      organization = Organization.find_by_query(input)
      return { type: :organization, record: organization } if organization.present?

      nil
    end
  end
end

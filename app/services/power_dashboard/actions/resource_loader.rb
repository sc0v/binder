# frozen_string_literal: true

module PowerDashboard
  module Actions
    module ResourceLoader
      RESOURCE_DEFS = {
        tool: { model: Tool, param: 'tool_id', error_key: 'resources.tool.not_found' },
        scissor_lift: { model: ScissorLift, param: 'scissor_lift_id', error_key: 'resources.scissor_lift.not_found' },
        participant: { model: Participant, param: 'participant_id', error_key: 'resources.participant.missing' },
        organization: { model: Organization, param: 'organization_id', error_key: 'resources.organization.not_found' },
        organization_required: { model: Organization, param: 'organization_id', error_key: 'resources.organization.missing' },
        scissor_lift_required: { model: ScissorLift, param: 'scissor_lift_id', error_key: 'resources.scissor_lift.missing' }
      }.freeze

      def load_resources_for(handler, pending, allow_missing: false)
        requirements = handler.required_resources(pending)
        requirements.each_with_object({}) do |resource_key, resources|
          definition = RESOURCE_DEFS.fetch(resource_key)
          record = definition[:model].find_by(id: pending[definition[:param]])
          if record.blank? && !allow_missing
            return { error: I18n.t(definition[:error_key]) }
          end
          resources[resource_key] = record
        end
      end
    end
  end
end

# frozen_string_literal: true

module Dashboard
  # Resolves scan inputs and mutates flow with selected ids.
  class ScanResolver
    def call(flow:, target:, input:)
      case target
      when 'tool' then resolve_tool(flow, input)
      when 'participant' then resolve_participant(flow, input)
      when 'organization' then resolve_organization(flow, input)
      when 'scissor_lift' then resolve_scissor_lift(flow, input)
      when 'lookup' then resolve_lookup(flow, input)
      else { error: 'Invalid scan target.' }
      end
    end

    private

    def resolve_tool(flow, input)
      tool = Tool.lookup(input)
      return { error: 'Tool not found.' } if tool.blank?

      toggle_tool_in_flow(flow, tool)
    end

    def resolve_participant(flow, input)
      participant = Participant.lookup(input)
      return { error: 'Participant not found.' } if participant.blank?

      flow['participant_id'] = participant.id
      flow['organization_id'] = nil
      { notice: "Borrower set to #{participant.formatted_name}." }
    end

    def resolve_organization(flow, input)
      organization = Organization.lookup(input)
      return { error: 'Organization not found.' } if organization.blank?

      flow['organization_id'] = organization.id
      { notice: "Organization set to #{organization.name}." }
    end

    def resolve_scissor_lift(flow, input)
      lift = ScissorLift.lookup(input)
      return { error: 'Scissor lift not found.' } if lift.blank?

      flow['scissor_lift_id'] = lift.id
      { notice: "Scissor lift set to #{lift.name}." }
    end

    def resolve_lookup(flow, input)
      resource = Dashboard::ResourceLookup.new.lookup_resource(input)
      return { error: "No match found for \"#{input}\"." } if resource.blank?

      flow['lookup_type'] = resource[:type].to_s
      flow['lookup_id'] = resource[:record].id
      { notice: "#{resource[:type].to_s.humanize} selected." }
    end

    def toggle_tool_in_flow(flow, tool)
      tool_ids = Array(flow['tool_ids']).map(&:to_i)
      if tool_ids.include?(tool.id)
        flow['tool_ids'] = tool_ids - [tool.id]
        return { notice: "Removed #{tool.formatted_name}." }
      end

      flow['tool_ids'] = tool_ids + [tool.id]
      state = tool.checked_out? ? 'checked out' : 'checked in'
      { notice: "Added #{tool.formatted_name} (#{state})." }
    end
  end
end

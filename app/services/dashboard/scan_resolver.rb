# frozen_string_literal: true

module Dashboard
  # Resolves scan inputs and mutates flow with selected ids.
  class ScanResolver
    def call(flow:, target:, input:)
      case target
      when 'tool'
        resolve_tool(flow, input)
      when 'participant'
        resolve_participant(flow, input)
      when 'organization'
        resolve_organization(flow, input)
      when 'scissor_lift'
        resolve_scissor_lift(flow, input)
      when 'lookup'
        resolve_lookup(flow, input)
      else
        { error: I18n.t('dashboard.errors.invalid_scan_target') }
      end
    end

    private

    def resolve_tool(flow, input)
      tool = Tool.lookup(input)
      return { error: I18n.t('resources.tool.not_found') } if tool.blank?

      toggle_tool_in_flow(flow, tool)
    end

    def resolve_participant(flow, input)
      participant = Participant.lookup(input)
      if participant.blank?
        return { error: I18n.t('resources.participant.missing') }
      end

      flow['participant_id'] = participant.id
      flow['organization_id'] = nil
      {
        notice:
          I18n.t(
            'dashboard.notices.borrower_set',
            name: participant.formatted_name
          )
      }
    end

    def resolve_organization(flow, input)
      organization = Organization.lookup(input)
      if organization.blank?
        return { error: I18n.t('resources.organization.not_found') }
      end

      flow['organization_id'] = organization.id
      {
        notice:
          I18n.t('dashboard.notices.organization_set', name: organization.name)
      }
    end

    def resolve_scissor_lift(flow, input)
      lift = ScissorLift.lookup(input)
      if lift.blank?
        return { error: I18n.t('resources.scissor_lift.not_found') }
      end

      flow['scissor_lift_id'] = lift.id
      { notice: I18n.t('dashboard.notices.scissor_lift_set', name: lift.name) }
    end

    def resolve_lookup(flow, input)
      resource = Dashboard::ResourceLookup.new.lookup_resource(input)
      if resource.blank?
        return { error: I18n.t('dashboard.errors.no_match', input: input) }
      end

      flow['lookup_type'] = resource[:type].to_s
      flow['lookup_id'] = resource[:record].id
      {
        notice:
          I18n.t(
            'dashboard.notices.lookup_selected',
            type: resource[:type].to_s.humanize
          )
      }
    end

    def toggle_tool_in_flow(flow, tool)
      tool_ids = Array(flow['tool_ids']).map(&:to_i)
      if tool_ids.include?(tool.id)
        flow['tool_ids'] = tool_ids - [tool.id]
        return(
          {
            notice:
              I18n.t(
                'dashboard.notices.tool_removed',
                name: tool.formatted_name
              )
          }
        )
      end

      flow['tool_ids'] = tool_ids + [tool.id]
      state =
        (
          if tool.checked_out?
            I18n.t('dashboard.states.checked_out')
          else
            I18n.t('dashboard.states.checked_in')
          end
        )
      {
        notice:
          I18n.t(
            'dashboard.notices.tool_added',
            name: tool.formatted_name,
            state: state
          )
      }
    end
  end
end

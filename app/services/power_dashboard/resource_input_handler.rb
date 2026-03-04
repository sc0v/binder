# frozen_string_literal: true

module PowerDashboard
  class ResourceInputHandler
    SELECTION_HANDLERS = {
      tool: :select_tool,
      participant: :select_participant,
      organization: :select_organization,
      scissor_lift: :select_scissor_lift
    }.freeze

    def initialize(session_state:, resource_lookup:)
      @session_state = session_state
      @resource_lookup = resource_lookup
      @session = session_state.session
    end

    def handle(input)
      resource = resource_lookup.lookup_resource(input)
      return { error: t('power_dashboard.selection.no_match', input: input) } if resource.blank?

      type, record = resource.values_at(:type, :record)
      handler = SELECTION_HANDLERS[type]
      return { error: t('power_dashboard.selection.unknown') } if handler.blank?

      result = send(handler, record)
      return result if result[:error].present?

      session_state.set_current_resource(type, record)
      flash_result(notice: result[:message])
    end

    private

    attr_reader :session_state, :resource_lookup, :session

    def select_tool(tool)
      in_cart = Array(session[:tools]).include?(tool.id)
      if session_state.auto_add_tools?
        unless in_cart
          session[:tools] ||= []
          session[:tools] << tool.id
        end
        message = in_cart ? t('power_dashboard.selection.tool_selected') :
          t('power_dashboard.selection.tool_added_to_cart', name: tool.formatted_name)
        return selection_message(message)
      end

      message = t('power_dashboard.selection.tool_selected')

      selection_message(message)
    end

    def select_participant(participant)
      session_state.set_participant(participant)
      selection_message(t('power_dashboard.selection.participant_selected'))
    end

    def select_organization(organization)
      if session_state.organization_allowed?(organization)
        session[:power_organization_id] = organization.id
      end
      selection_message(t('power_dashboard.selection.organization_selected'))
    end

    def select_scissor_lift(_lift)
      selection_message(t('power_dashboard.selection.scissor_lift_selected'))
    end

    def flash_result(payload)
      { flash: payload }
    end

    def selection_message(message)
      { message: message }
    end

    def t(key, **options)
      I18n.t(key, **options)
    end
  end
end

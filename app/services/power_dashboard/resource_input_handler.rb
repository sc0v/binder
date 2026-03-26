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

      session_state.assign_resource(type, record)
      flash_result(notice: result[:message])
    end

    private

    attr_reader :session_state, :resource_lookup, :session

    def select_tool(tool)
      in_cart = Array(session[:tools]).include?(tool.id)
      if session_state.auto_add_tools? && !in_cart
        session[:tools] ||= []
        session[:tools] << tool.id
        return selection_message(t('power_dashboard.selection.tool_added_to_cart', name: tool.formatted_name))
      end

      selection_message(t('power_dashboard.selection.tool_selected'))
    end

    def select_participant(participant)
      session_state.assign_participant(participant)
      selection_message(t('power_dashboard.selection.participant_selected'))
    end

    def select_organization(organization)
      session[:power_organization_id] = organization.id if session_state.organization_allowed?(organization)
      selection_message(t('power_dashboard.selection.organization_selected'))
    end

    def select_scissor_lift(_lift)
      selection_message(t('power_dashboard.selection.scissor_lift_selected'))
    end

    def flash_result(payload)
      { flash: payload }
    end

    def selection_message(text)
      { message: text }
    end

    def t(key, **)
      I18n.t(key, **)
    end
  end
end

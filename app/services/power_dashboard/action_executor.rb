# frozen_string_literal: true

module PowerDashboard
  class ActionExecutor
    include Actions::ResourceLoader

    def initialize(session_state:, ability:)
      @session_state = session_state
      @session = session_state.session
      @ability = ability
    end

    def execute(pending)
      pending = pending.stringify_keys
      handler = ActionRegistry.handler_for_action(pending['action'])
      return error_result('Unknown action.') if handler.blank?
      if handler.confirmation_required? && !pending['confirmed']
        return error_result(I18n.t('power_dashboard.actions.confirmation_required'))
      end
      resources = load_resources_for(handler, pending)
      return error_result(resources[:error]) if resources[:error]

      result = handler.execute(pending, resources: resources, session_state: session_state, ability: ability)
      return error_result(I18n.t('power_dashboard.actions.unknown')) if result.blank?
      result[:error].present? ? error_result(result[:error]) : result
    end

    private

    attr_reader :session_state, :session, :ability

    def error_result(message)
      { error: message }
    end
  end
end

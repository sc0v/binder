# frozen_string_literal: true

module PowerDashboard
  module Actions
    class SessionClear < Base
      def name
        'clear_session'
      end

      def command_words
        %w[clear]
      end

      def suggestions
        [{ label: 'clear', value: 'clear', type: 'action' }]
      end

      def parse(_rest, session_state:, command:)
        pending
      end

      def execute(_pending, resources:, session_state:, ability:)
        return error(t('resources.session.update_not_authorized')) unless ability.call(:read, Tool)
        session_state.clear_power_session
        message(t('resources.session.cleared'))
      end
    end
  end
end

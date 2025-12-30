# frozen_string_literal: true

module PowerDashboard
  module Actions
    class AutoAddToggle < Base
      def name
        'toggle_auto_add'
      end

      def command_words
        %w[auto]
      end

      def suggestions
        [{ label: 'auto', value: 'auto', type: 'action' }]
      end

      def parse(_rest, session_state:, command:)
        pending
      end

      def execute(_pending, resources:, session_state:, ability:)
        enabled = session_state.toggle_auto_add_tools
        status = enabled ? 'enabled' : 'disabled'
        message(t('resources.session.auto_add_status', status: status))
      end
    end
  end
end

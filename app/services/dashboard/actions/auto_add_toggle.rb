# frozen_string_literal: true

module Dashboard
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

      def parse(_rest, _session_state:, _command:)
        pending
      end

      def execute(_pending, _resources:, session_state:, _ability:)
        enabled = session_state.toggle_auto_add_tools
        status = enabled ? 'enabled' : 'disabled'
        message(t('resources.session.auto_add_status', status: status))
      end
    end
  end
end

# frozen_string_literal: true

module PowerDashboard
  module Actions
    class ToolAdd < Base
      def name
        'add_tool'
      end

      def command_words
        %w[add a]
      end

      def suggestions
        [
          { label: 'add', value: 'add', type: 'action' },
          { label: 'a', value: 'a', type: 'action' }
        ]
      end

      def parse(_rest, session_state:, command:)
        tool = session_state.current_tool
        return error(t('resources.tool.select_first')) if tool.blank?

        pending(tool_id: tool.id)
      end

      def required_resources(_pending)
        %i[tool]
      end

      def execute(_pending, resources:, session_state:, ability:)
        tool = resources[:tool]
        return error(t('resources.tool.checkout_not_authorized')) unless ability.call(:create, Checkout)
        session = session_state.session
        session[:tools] ||= []
        session[:tools] << tool.id unless session[:tools].include?(tool.id)
        message(t('resources.tool.added_to_cart', name: tool.formatted_name))
      end

    end
  end
end

# frozen_string_literal: true

module PowerDashboard
  module Actions
    class ToolRemove < Base
      def name
        'remove_tool'
      end

      def command_words
        %w[remove rem r]
      end

      def suggestions
        [
          { label: 'remove', value: 'remove', type: 'action' },
          { label: 'rem', value: 'rem', type: 'action' },
          { label: 'r', value: 'r', type: 'action' }
        ]
      end

      def parse(rest, session_state:, command:)
        tool = rest.present? ? Tool.find_by(barcode: rest) : session_state.current_tool
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
        if session[:tools].include?(tool.id)
          session[:tools].delete(tool.id)
          message(t('resources.tool.removed_from_cart', name: tool.formatted_name))
        else
          error(t('resources.tool.not_in_cart'))
        end
      end
    end
  end
end

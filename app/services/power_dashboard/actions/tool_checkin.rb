# frozen_string_literal: true

module PowerDashboard
  module Actions
    class ToolCheckin < Base
      def name
        'checkin_tool'
      end

      def command_words
        %w[checkin in]
      end

      def suggestions
        [{ label: 'checkin', value: 'checkin', type: 'action' }, { label: 'in', value: 'in', type: 'action' }]
      end

      def priority
        10
      end

      def match?(rest, session_state:)
        return false if targets_tools_cart?(rest)

        session_state.current_tool.present?
      end

      def confirmation_required?
        true
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

        return error(t('resources.tool.checkin_not_authorized')) unless ability.call(:update, Checkout)

        checkout = tool.checkouts.current.first
        return error(t('resources.tool.not_checked_out')) if checkout.blank?

        checkout.checkin
        return error(checkout.errors.full_messages.join(', ')) if checkout.errors.any?
        message(t('resources.tool.checked_in', barcode: tool.barcode))
      end

      def receipt(_pending, resources:, session:)
        tool = resources[:tool]
        receipt_payload(t('resources.receipts.checkin_tool_title'), [
          receipt_line(t('resources.labels.tool'), tool&.formatted_name)
        ])
      end
    end
  end
end

# frozen_string_literal: true

module PowerDashboard
  module Actions
    class ToolsCartCheckin < Base
      def name
        'checkin_tools_cart'
      end

      def command_words
        %w[checkin in]
      end

      def suggestions
        [{ label: 'checkin cart', value: 'checkin cart', type: 'action' }]
      end

      def priority
        0
      end

      def match?(rest, session_state:)
        targets_tools_cart?(rest)
      end

      def confirmation_required?
        true
      end

      def parse(_rest, session_state:, command:)
        return error(t('resources.tool.cart_empty')) if Array(session_state.session[:tools]).empty?

        pending
      end

      def execute(_pending, resources:, session_state:, ability:)
        return error(t('resources.tool.checkin_not_authorized')) unless ability.call(:update, Checkout)
        session = session_state.session
        tool_ids = Array(session[:tools]).map(&:to_i)
        return error(t('resources.tool.cart_empty')) if tool_ids.empty?

        result = Checkout.checkin_batch(tool_ids: tool_ids)

        session[:tools] = result[:remaining_ids]

        if result[:errors].any?
          error_messages = result[:errors].map do |error|
            case error[:type]
            when :missing_tool
              t('resources.tool.cart_tool_missing', id: error[:id])
            when :not_checked_out
              t('resources.tool.cart_tool_not_checked_out', barcode: error[:barcode])
            when :checkin_error
              error[:message]
            else
              error[:message] || error.inspect
            end
          end
          error(t('resources.tool.cart_checked_in_with_errors', count: result[:checked_in], errors: error_messages.join(', ')))
        else
          message(t('resources.tool.cart_checked_in', count: result[:checked_in]))
        end
      end

      def receipt(_pending, resources:, session:)
        receipt_payload(t('resources.receipts.checkin_tools_cart_title'), [
          receipt_line(t('resources.labels.tools_in_cart'), Array(session[:tools]).size.to_s),
          receipt_list(t('resources.labels.cart_contents'), cart_tool_names(session))
        ])
      end
    end
  end
end

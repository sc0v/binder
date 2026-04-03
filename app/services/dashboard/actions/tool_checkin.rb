# frozen_string_literal: true

module Dashboard
  module Actions
    class ToolCheckin < Base
      def name
        'checkin_tool'
      end

      def command_words
        %w[checkin in]
      end

      def suggestions
        [
          { label: 'checkin', value: 'checkin', type: 'action' },
          { label: 'in', value: 'in', type: 'action' }
        ]
      end

      def priority
        20
      end

      def match?(rest, session_state:)
        return false if targets_tools_cart?(rest) || lift_match?(rest)
        return false if session_state.current_scissor_lift.present?
        return false if Array(session_state.session[:tools]).any?

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
        unless ability.can?(:update, Checkout)
          return error(t('resources.tool.checkin_not_authorized'))
        end

        checkout = tool.checkouts.current.first
        return error(t('resources.tool.not_checked_out')) if checkout.blank?

        checkout.checkin
        if checkout.errors.any?
          return error(checkout.errors.full_messages.join(', '))
        end

        message(t('resources.tool.checked_in', barcode: tool.barcode))
      end

      def receipt(_pending, resources:, session:)
        tool = resources[:tool]
        checkout = tool ? tool.checkouts.current.first : nil
        receipt_payload(
          t('resources.receipts.checkin_tool_title'),
          [
            receipt_line(t('resources.labels.tool'), tool&.formatted_name),
            receipt_line(
              t('resources.labels.checked_out_to'),
              checked_out_to_label(checkout)
            )
          ]
        )
      end
    end
  end
end

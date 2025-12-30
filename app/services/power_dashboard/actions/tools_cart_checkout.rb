# frozen_string_literal: true

module PowerDashboard
  module Actions
    class ToolsCartCheckout < Base
      def name
        'checkout_tools_cart'
      end

      def command_words
        %w[checkout out]
      end

      def suggestions
        [
          { label: 'checkout', value: 'checkout', type: 'action' },
          { label: 'out', value: 'out', type: 'action' }
        ]
      end

      def priority
        0
      end

      def match?(rest, session_state:)
        !lift_match?(rest)
      end

      def confirmation_required?
        true
      end

      def parse(_rest, session_state:, command:)
        borrower = session_state.current_borrower
        return error(t('resources.participant.select_first')) if borrower.blank?
        return error(t('resources.tool.cart_empty')) if Array(session_state.session[:tools]).empty?

        organization = session_state.selected_organization_for_borrower
        if organization.blank?
          return pending(participant_id: borrower.id, needs_org_selection: true)
        end

        pending(participant_id: borrower.id, organization_id: organization.id)
      end

      def required_resources(_pending)
        %i[participant organization_required]
      end

      def execute(_pending, resources:, session_state:, ability:)
        borrower = resources[:participant]
        organization = resources[:organization_required]
        return error(t('resources.tool.checkout_not_authorized')) unless ability.call(:create, Checkout)
        session = session_state.session
        tool_ids = Array(session[:tools]).map(&:to_i)
        result = Checkout.checkout_batch(
          organization: organization,
          participant: borrower,
          tool_ids: tool_ids
        )
        session[:tools] = result[:remaining_ids]

        if result[:failed].empty? && session[:tools].empty?
          session[:borrower_id] = nil
          message(t('resources.tool.checkout_success', name: borrower.name))
        else
          failed_messages = result[:failed].flat_map { |checkout| checkout.errors.full_messages }
          msg = failed_messages.presence || [t('resources.tool.checkout_failed')]
          error(msg.join(', '))
        end
      end

      def receipt(_pending, resources:, session:)
        borrower = resources[:participant]
        organization = resources[:organization_required]
        receipt_payload(t('resources.receipts.checkout_tools_cart_title'), [
          receipt_line(t('resources.labels.borrower'), borrower&.formatted_name),
          receipt_line(t('resources.labels.organization'), organization&.name),
          receipt_list(t('resources.labels.cart_contents'), cart_tool_names(session))
        ])
      end
    end
  end
end

# frozen_string_literal: true

module Dashboard
  module Actions
    class ToolDirectCheckout < Base
      def name
        'checkout_tool'
      end

      def command_words
        %w[checkout out]
      end

      def suggestions
        []
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

        borrower = session_state.current_borrower
        return error(t('resources.participant.select_first')) if borrower.blank?

        organization = session_state.selected_organization_for_borrower
        if organization.blank?
          return pending(tool_id: tool.id, participant_id: borrower.id, needs_org_selection: true)
        end

        pending(tool_id: tool.id, participant_id: borrower.id, organization_id: organization.id)
      end

      def required_resources(_pending)
        %i[tool participant organization_required]
      end

      def execute(_pending, resources:, session_state:, ability:)
        tool = resources[:tool]
        borrower = resources[:participant]
        organization = resources[:organization_required]

        return error(t('resources.tool.checkout_not_authorized')) unless ability.can?(:create, Checkout)

        checkout = Checkout.new(
          organization: organization,
          participant: borrower,
          tool: tool,
          checked_out_at: Time.zone.now
        )
        unless checkout.save
          return error(checkout.errors.full_messages.join(', ').presence || t('resources.tool.checkout_failed'))
        end

        message(t('resources.tool.checkout_success', name: borrower.name))
      end

      def receipt(_pending, resources:, session:)
        tool = resources[:tool]
        borrower = resources[:participant]
        organization = resources[:organization_required]
        receipt_payload(t('resources.receipts.checkout_tool_title'), [
                          receipt_line(t('resources.labels.tool'), tool&.formatted_name),
                          receipt_line(t('resources.labels.borrower'), borrower&.formatted_name),
                          receipt_line(t('resources.labels.organization'), organization&.name)
                        ])
      end
    end
  end
end

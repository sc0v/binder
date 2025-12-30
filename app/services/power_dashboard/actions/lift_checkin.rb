# frozen_string_literal: true

module PowerDashboard
  module Actions
    class LiftCheckin < Base
      def name
        'checkin_scissor_lift'
      end

      def command_words
        %w[checkin in]
      end

      def priority
        10
      end

      def match?(rest, session_state:)
        return false if targets_tools_cart?(rest)

        session_state.current_scissor_lift.present?
      end

      def confirmation_required?
        true
      end

      def parse(_rest, session_state:, command:)
        lift = session_state.current_scissor_lift
        return error(t('resources.checkin.missing_resource')) if lift.blank?

        pending(scissor_lift_id: lift.id)
      end

      def required_resources(_pending)
        %i[scissor_lift]
      end

      def execute(pending, resources:, session_state:, ability:)
        lift = resources[:scissor_lift]
        return error(t('resources.scissor_lift.checkin_not_authorized')) unless ability.call(:update, ScissorLiftCheckout)

        # Ensure the lift is currently checked out before checkin.
        checkout = lift.current_checkout
        return error(t('resources.scissor_lift.not_checked_out')) if checkout.blank?

        checkout.checkin(forfeit: false)
        return error(checkout.errors.full_messages.join(', ')) if checkout.errors.any?

        message(t('resources.scissor_lift.checked_in', lift: lift.name))
      end

      def receipt(pending, resources:, session:)
        lift = resources[:scissor_lift]
        receipt_payload(t('resources.receipts.checkin_scissor_lift_title'), [
          receipt_line(t('resources.labels.scissor_lift'), lift&.name)
        ])
      end
    end
  end
end

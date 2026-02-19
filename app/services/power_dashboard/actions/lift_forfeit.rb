# frozen_string_literal: true

module PowerDashboard
  module Actions
    class LiftForfeit < Base
      def name
        'forfeit_scissor_lift'
      end

      def command_words
        %w[forfeit]
      end

      def suggestions
        [{ label: 'forfeit', value: 'forfeit', type: 'action' }]
      end

      def confirmation_required?
        true
      end

      def parse(_rest, session_state:, command:)
        lift = session_state.current_scissor_lift
        return error(t('resources.scissor_lift.select_first')) if lift.blank?
        pending(scissor_lift_id: lift.id)
      end

      def required_resources(_pending)
        %i[scissor_lift]
      end

      def execute(_pending, resources:, session_state:, ability:)
        lift = resources[:scissor_lift]
        return error(t('resources.scissor_lift.checkin_not_authorized')) unless ability.call(:update, ScissorLiftCheckout)

        # Forfeit uses the same checkin flow, but marks it as forfeited.
        checkout = lift.current_checkout
        return error(t('resources.scissor_lift.not_checked_out')) if checkout.blank?

        checkout.checkin(forfeit: true)
        return error(checkout.errors.full_messages.join(', ')) if checkout.errors.any?

        message(t('resources.scissor_lift.forfeited', lift: lift.name))
      end

      def receipt(_pending, resources:, session:)
        lift = resources[:scissor_lift]
        checkout = lift&.current_checkout
        receipt_payload(t('resources.receipts.checkin_scissor_lift_forfeit_title'), [
          receipt_line(t('resources.labels.scissor_lift'), lift&.name),
          receipt_line(t('resources.labels.checked_out_to'), checked_out_to_label(checkout))
        ])
      end
    end
  end
end

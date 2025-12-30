# frozen_string_literal: true

module PowerDashboard
  module Actions
    class LiftCheckout < Base
      def name
        'checkout_scissor_lift'
      end

      def command_words
        %w[checkout out]
      end

      def suggestions
        [
          { label: 'checkout lift', value: 'checkout lift', type: 'action' }
        ]
      end

      def priority
        10
      end

      def match?(rest, session_state:)
        lift_match?(rest)
      end

      def confirmation_required?
        true
      end

      def parse(rest, session_state:, command:)
        # Resolve a lift to use, preferring the current selection.
        available_lift = ScissorLift.where.not(
          id: ScissorLiftCheckout.where(checked_in_at: nil).select(:scissor_lift_id)
        ).order(:name).first
        lift = session_state.current_scissor_lift || available_lift
        return error(t('resources.scissor_lift.not_available')) if lift.blank?

        # Require a borrower and organization before checkout.
        borrower = session_state.current_borrower
        return error(t('resources.participant.select_first')) if borrower.blank?
        organization = session_state.selected_organization_for_borrower
        if organization.blank?
          return pending(scissor_lift_id: lift.id, participant_id: borrower.id, needs_org_selection: true)
        end
        pending(scissor_lift_id: lift.id, participant_id: borrower.id, organization_id: organization.id)
      end

      def required_resources(_pending)
        %i[scissor_lift_required participant organization_required]
      end

      def execute(_pending, resources:, session_state:, ability:)
        lift = resources[:scissor_lift_required]
        borrower = resources[:participant]
        organization = resources[:organization_required]
        return error(t('resources.scissor_lift.checkout_not_authorized')) unless ability.call(:create, ScissorLiftCheckout)

        result = ScissorLiftCheckout.checkout_batch(
          organization: organization,
          participant: borrower,
          scissor_lift_ids: [lift.id]
        )
        if result[:failed].present?
          message = result[:failed].map { |checkout| checkout.errors.full_messages.join(', ') }.join(', ')
          return error(message.presence || t('resources.scissor_lift.checkout_failed'))
        end

        message(t('resources.scissor_lift.checkout_success', lift: lift.name, name: borrower.name))
      end

      def receipt(_pending, resources:, session:)
        lift = resources[:scissor_lift_required]
        borrower = resources[:participant]
        organization = resources[:organization_required]
        receipt_payload(t('resources.receipts.checkout_scissor_lift_title'), [
          receipt_line(t('resources.labels.scissor_lift'), lift&.name),
          receipt_line(t('resources.labels.borrower'), borrower&.formatted_name),
          receipt_line(t('resources.labels.organization'), organization&.name)
        ])
      end
    end
  end
end

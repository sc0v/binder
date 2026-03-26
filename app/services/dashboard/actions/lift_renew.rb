# frozen_string_literal: true

module Dashboard
  module Actions
    class LiftRenew < Base
      def name
        'renew_scissor_lift'
      end

      def command_words
        %w[renew ren]
      end

      def suggestions
        [
          { label: 'renew <hours>', value: 'renew ', type: 'action' },
          { label: 'ren <hours>', value: 'ren ', type: 'action' }
        ]
      end

      def confirmation_required?
        true
      end

      def parse(rest, session_state:, command:)
        lift = session_state.current_scissor_lift
        return error(t('resources.scissor_lift.select_first')) if lift.blank?

        hours = parse_hours(rest)
        if hours.blank?
          return error(t('resources.scissor_lift.renew_requires_hours'))
        end

        pending(scissor_lift_id: lift.id, hours: hours)
      end

      def required_resources(_pending)
        %i[scissor_lift]
      end

      def execute(pending, resources:, session_state:, ability:)
        lift = resources[:scissor_lift]
        unless ability.can?(:update, ScissorLiftCheckout)
          return error(t('resources.scissor_lift.renew_not_authorized'))
        end

        checkout = lift.current_checkout
        if checkout.blank?
          return error(t('resources.scissor_lift.not_checked_out'))
        end

        checkout.renew_for(duration_hours: pending['hours'].to_i)
        if checkout.errors.any?
          return error(checkout.errors.full_messages.join(', '))
        end

        message(
          t(
            'resources.scissor_lift.renew_success',
            lift: lift.name,
            hours: pending['hours']
          )
        )
      end

      def receipt(pending, resources:, session:)
        lift = resources[:scissor_lift]
        receipt_payload(
          t('resources.receipts.renew_scissor_lift_title'),
          [
            receipt_line(t('resources.labels.scissor_lift'), lift&.name),
            receipt_line(
              t('resources.labels.duration'),
              t(
                'resources.scissor_lift.duration_hours',
                hours: pending['hours']
              )
            )
          ]
        )
      end

      private

      def parse_hours(input)
        Integer(input.to_s.strip, 10)
      rescue ArgumentError, TypeError
        nil
      end
    end
  end
end

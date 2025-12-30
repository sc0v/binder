# frozen_string_literal: true

module PowerDashboard
  module Actions
    # Handles the checkin action when the resource is not check-in-able

    class CheckinMissingResource < Base
      def name
        'checkin_missing_resource'
      end

      def command_words
        %w[checkin in]
      end

      def priority
        30
      end

      def match?(rest, session_state:)
        return false if targets_tools_cart?(rest)

        session_state.current_tool.blank? && session_state.current_scissor_lift.blank?
      end

      def parse(_rest, session_state:, command:)
        error(t('resources.checkin.missing_resource'))
      end

      def execute(_pending, resources:, session_state:, ability:)
        unless ability.call(:update, Checkout) || ability.call(:update, ScissorLiftCheckout)
          return error(t('resources.checkin.not_authorized'))
        end
        error(t('resources.checkin.missing_resource'))
      end
    end
  end
end

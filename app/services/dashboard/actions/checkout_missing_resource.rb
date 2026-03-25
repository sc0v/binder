# frozen_string_literal: true

module Dashboard
  module Actions
    # Handles the checkout action when nothing can be checked out

    class CheckoutMissingResource < Base
      def name
        'checkout_missing_resource'
      end

      def command_words
        %w[checkout out]
      end

      def priority
        30
      end

      def match?(_rest, _session_state:)
        true
      end

      def parse(_rest, _session_state:, _command:)
        error(t('resources.checkout.missing_resource'))
      end
    end
  end
end

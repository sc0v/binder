# frozen_string_literal: true

module Dashboard
  module Actions
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

      def match?(_rest, session_state:)
        true
      end

      def parse(_rest, session_state:, command:)
        error(t('resources.checkout.missing_resource'))
      end
    end
  end
end

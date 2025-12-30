# frozen_string_literal: true

module PowerDashboard
  module Actions
    class QueueBase < Base
      def command_words
        %w[electrical structural e s]
      end

      protected

      def normalize_queue_type(command)
        case command
        when 'e'
          'electrical'
        when 's'
          'structural'
        else
          command
        end
      end

      def add_match?(rest)
        rest.to_s.strip.match?(/\A(add|a)\b/i)
      end

      def remove_match?(rest)
        rest.to_s.strip.match?(/\A(remove|rem|r)\b/i)
      end
    end
  end
end

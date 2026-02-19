# frozen_string_literal: true

module PowerDashboard
  module Actions
    class QueueBase < Base
      def command_words
        %w[electrical structural e s queue q]
      end

      protected

      def queue_type_for(session_state:, command:)
        queue_type = normalize_queue_type(command)
        return queue_type if %w[electrical structural].include?(queue_type)

        return unless %w[queue q].include?(command.to_s)
        return unless session_state.current_resource_type == 'queue'

        normalize_queue_type(session_state.current_resource_id.to_s)
      end

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

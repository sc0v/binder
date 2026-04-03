# frozen_string_literal: true

module Dashboard
  module Actions
    class QueueSelect < QueueBase
      def name
        'select_queue'
      end

      def command_words
        %w[electrical structural e s]
      end

      def suggestions
        [
          { label: 'electrical', value: 'electrical', type: 'action' },
          { label: 'structural', value: 'structural', type: 'action' }
        ]
      end

      def priority
        20
      end

      def match?(rest, session_state:)
        !add_match?(rest) && !remove_match?(rest)
      end

      def parse(_rest, session_state:, command:)
        queue_type = normalize_queue_type(command)
        pending(queue_type: queue_type)
      end

      def execute(pending, resources:, session_state:, ability:)
        queue_type = pending['queue_type'].to_s
        unless %w[electrical structural].include?(queue_type)
          return error(t('resources.queue.unknown'))
        end
        unless ability.can?(:read, OrganizationTimelineEntry)
          return error(t('resources.queue.view_not_authorized'))
        end

        session_state.assign_queue_resource(queue_type)
        message(
          t('resources.queue.select_success', queue_type: queue_type.titlecase)
        )
      end
    end
  end
end

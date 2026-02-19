# frozen_string_literal: true

module PowerDashboard
  module Actions
    class QueueSelect < QueueBase
      def command_words
        %w[electrical structural e s]
      end

      def name
        'select_queue'
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
        return error(t('resources.queue.unknown')) unless %w[electrical structural].include?(queue_type)

        return error(t('resources.queue.view_not_authorized')) unless ability.call(:read, OrganizationTimelineEntry)

        session_state.set_queue_resource(queue_type)
        message(t('resources.queue.select_success', queue_type: queue_type.titlecase))
      end
    end
  end
end

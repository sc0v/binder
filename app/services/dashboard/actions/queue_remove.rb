# frozen_string_literal: true

module Dashboard
  module Actions
    class QueueRemove < QueueBase
      def name
        'remove_queue'
      end

      def suggestions
        [
          { label: 'queue remove', value: 'queue remove', type: 'action' },
          {
            label: 'electrical remove',
            value: 'electrical remove',
            type: 'action'
          },
          { label: 'e rem', value: 'e rem', type: 'action' },
          {
            label: 'structural remove',
            value: 'structural remove',
            type: 'action'
          },
          { label: 's rem', value: 's rem', type: 'action' }
        ]
      end

      def priority
        20
      end

      def match?(rest, session_state:)
        remove_match?(rest)
      end

      def parse(_rest, session_state:, command:)
        queue_type = queue_type_for(session_state:, command:)
        if queue_type.blank?
          return error(t('resources.queue.select_queue_first'))
        end

        organization = session_state.organization_for_queue
        if organization.blank?
          return error(t('resources.organization.select_first'))
        end

        pending(queue_type: queue_type, organization_id: organization.id)
      end

      def required_resources(_pending)
        %i[organization]
      end

      def execute(pending, resources:, session_state:, ability:)
        queue_type = pending['queue_type'].to_s
        unless %w[electrical structural].include?(queue_type)
          return error(t('resources.queue.unknown'))
        end

        organization = resources[:organization]
        unless ability.can?(:update, OrganizationTimelineEntry)
          return error(t('resources.queue.remove_not_authorized'))
        end

        entry =
          OrganizationTimelineEntry
            .current
            .where(entry_type: queue_type, organization: organization)
            .first
        return error(t('resources.queue.not_in_queue')) if entry.blank?

        entry.update(ended_at: Time.zone.now)
        return error(entry.errors.full_messages.join(', ')) if entry.errors.any?

        message(
          t(
            'resources.queue.remove_success',
            name: organization.name,
            queue_type: queue_type
          )
        )
      end
    end
  end
end

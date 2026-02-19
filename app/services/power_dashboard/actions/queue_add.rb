# frozen_string_literal: true

module PowerDashboard
  module Actions
    class QueueAdd < QueueBase
      def name
        'add_queue'
      end

      def suggestions
        [
          { label: 'queue add <message>', value: 'queue add ', type: 'action' },
          { label: 'electrical add <message>', value: 'electrical add ', type: 'action' },
          { label: 'e add <message>', value: 'e add ', type: 'action' },
          { label: 'structural add <message>', value: 'structural add ', type: 'action' },
          { label: 's add <message>', value: 's add ', type: 'action' }
        ]
      end

      def priority
        20
      end

      def match?(rest, session_state:)
        add_match?(rest)
      end

      def confirmation_required?
        true
      end

      def parse(rest, session_state:, command:)
        queue_type = queue_type_for(session_state:, command:)
        return error(t('resources.queue.select_queue_first')) if queue_type.blank?

        queue_message = extract_queue_message(rest)
        return error(t('resources.queue.message_required')) if queue_message.blank?

        organization = session_state.organization_for_queue
        if organization.blank?
          return pending(queue_type: queue_type, queue_message: queue_message, needs_org_selection: true)
        end
        pending(queue_type: queue_type, queue_message: queue_message, organization_id: organization.id)
      end

      def required_resources(_pending)
        %i[organization]
      end

      def execute(pending, resources:, session_state:, ability:)
        organization = resources[:organization]
        return error(t('resources.queue.add_not_authorized')) unless ability.call(:create, OrganizationTimelineEntry)

        entry = OrganizationTimelineEntry.new(
          organization: organization,
          started_at: Time.zone.now,
          entry_type: pending['queue_type'],
          description: pending['queue_message']
        )
        return error(t('resources.queue.already_in_queue')) if entry.already_in_queue?
        return error(entry.errors.full_messages.join(', ').presence || t('resources.queue.add_problem')) unless entry.save
        message(t('resources.queue.add_success', queue_type: pending['queue_type']))
      end

      def receipt(pending, resources:, session:)
        organization = resources[:organization]
        receipt_payload(t('resources.receipts.add_queue_title', queue_type: pending['queue_type']), [
          receipt_line(t('resources.labels.organization'), organization&.name),
          receipt_line(t('resources.labels.message'), pending['queue_message'])
        ])
      end

      private

      def extract_queue_message(rest)
        text = rest.to_s.strip
        return if text.blank?

        text.sub(/\A(add|a)\b/i, '').strip.presence
      end
    end
  end
end

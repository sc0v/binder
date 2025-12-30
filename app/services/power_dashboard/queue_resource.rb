# frozen_string_literal: true

module PowerDashboard
  class QueueResource
    attr_reader :queue_type

    def initialize(queue_type)
      @queue_type = queue_type.to_s
    end

    def id
      queue_type
    end

    def name
      "#{queue_type.titlecase} Queue"
    end

    def path
      case queue_type
      when 'structural'
        '/structural'
      when 'electrical'
        '/electrical'
      end
    end

    def entries
      OrganizationTimelineEntry
        .current
        .where(entry_type: queue_type)
        .includes(:organization)
    end
  end
end

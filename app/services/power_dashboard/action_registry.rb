# frozen_string_literal: true

module PowerDashboard
  class ActionRegistry
    COMMAND_ORDER = %w[
      add remove clear rem a r
      checkin checkout renew forfeit in out ren
      electrical structural e s
      lifts
      auto
    ].freeze

    def self.handlers
      @handlers ||= [
        Actions::ToolAdd.new,
        Actions::ToolRemove.new,
        Actions::SessionClear.new,
        Actions::ToolCheckin.new,
        Actions::LiftCheckin.new,
        Actions::ToolsCartCheckin.new,
        Actions::CheckinMissingResource.new,
        Actions::LiftCheckout.new,
        Actions::ToolsCartCheckout.new,
        Actions::LiftRenew.new,
        Actions::LiftForfeit.new,
        Actions::QueueAdd.new,
        Actions::QueueRemove.new,
        Actions::QueueSelect.new,
        Actions::LiftOverviewSelect.new,
        Actions::AutoAddToggle.new
      ]
    end

    def self.handler_for_action(action_name)
      handlers.find { |handler| handler.name == action_name }
    end

    def self.handler_for_command(command, rest:, session_state:)
      candidates = handlers.select { |handler| handler.command_words.include?(command) }
      # Priorities only break ties for shared command words; match? should be decisive.
      # Tiering: 0 cart actions, 10 resource actions, 20 queue actions, 30 fallbacks, 100 default.
      candidates.sort_by(&:priority).find { |handler| handler.match?(rest, session_state: session_state) }
    end

    def self.suggestions
      suggestions = handlers.flat_map(&:suggestions)
      suggestions.each_with_index
        .sort_by do |(suggestion, index)|
          key = suggestion[:value].to_s.split(/\s+/, 2).first
          [COMMAND_ORDER.index(key) || COMMAND_ORDER.length, index]
        end
        .map(&:first)
    end
  end
end

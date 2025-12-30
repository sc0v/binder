# frozen_string_literal: true

module PowerDashboard
  class ActionParser
    def initialize(session_state:)
      @session_state = session_state
    end

    def parse(input)
      action, rest = input.split(/\s+/, 2)
      command = action.to_s.downcase
      handler = ActionRegistry.handler_for_command(command, rest: rest, session_state: session_state)
      return nil if handler.blank?

      handler.parse(rest, session_state: session_state, command: command)
    end

    private

    attr_reader :session_state
  end
end

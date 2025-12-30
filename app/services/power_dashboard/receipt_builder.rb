# frozen_string_literal: true

module PowerDashboard
  class ReceiptBuilder
    include Actions::ResourceLoader

    def initialize(session_state:)
      @session = session_state.session
    end

    def build(pending)
      pending = pending.stringify_keys
      handler = ActionRegistry.handler_for_action(pending['action'])
      return receipt_payload('Unknown action', []) if handler.blank?

      resources = load_resources_for(handler, pending, allow_missing: true)
      handler.receipt(pending, resources: resources, session: session) || receipt_payload('Unknown action', [])
    end

    private

    attr_reader :session
  end
end

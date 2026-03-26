# frozen_string_literal: true

module PowerDashboard
  class AutocompleteSuggestions
    def initialize(query:, include_actions: true)
      @query = query.to_s.strip
      @normalized = @query.downcase
      @include_actions = include_actions
    end

    def call
      return [] if @normalized.length < 2

      suggestions = []
      suggestions.concat(action_suggestions) if @include_actions
      suggestions.concat(organization_suggestions)
      suggestions.concat(participant_suggestions)
      suggestions.concat(tool_suggestions)
      suggestions.concat(scissor_lift_suggestions)
      suggestions.take(20)
    end

    class << self
      def cached_action_suggestions
        @cached_action_suggestions ||= Dashboard::ActionRegistry.suggestions.freeze
      end
    end

    def action_suggestions
      self.class.cached_action_suggestions
          .filter { |s| action_matches?(s) }
          .map { |s| s.merge(type: 'action') }
    end

    def action_matches?(suggestion)
      label = suggestion[:label].downcase
      value = suggestion[:value].downcase
      label.start_with?(@normalized) ||
        value.start_with?(@normalized) ||
        label.split.any? { |word| word.start_with?(@normalized) }
    end
    private :action_matches?

    def organization_suggestions
      Organization.autocomplete_matches(@normalized).order(:name).limit(5).map do |org|
        label = org.short_name.present? ? "Organization: #{org.name} (#{org.short_name})" : "Organization: #{org.name}"
        { label: label, value: org.short_name.presence || org.name, type: 'organization' }
      end
    end

    def participant_suggestions
      Participant.autocomplete_matches(@normalized).order(:cached_name).limit(5).map do |participant|
        label = if participant.email.present?
                  "Participant: #{participant.name} (#{participant.email})"
                else
                  "Participant: #{participant.name}"
                end
        { label: label, value: participant.eppn.presence || participant.formatted_name, type: 'participant' }
      end
    end

    def tool_suggestions
      Tool.autocomplete_matches(@normalized).order(:barcode).limit(5).map do |tool|
        { label: "Tool: #{tool.formatted_name} (#{tool.barcode})", value: tool.barcode, type: 'tool' }
      end
    end

    def scissor_lift_suggestions
      ScissorLift.autocomplete_matches(@normalized).order(:name).limit(5).map do |lift|
        { label: "Scissor lift: #{lift.name}", value: lift.name, type: 'scissor_lift' }
      end
    end
  end
end

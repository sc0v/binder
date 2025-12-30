# frozen_string_literal: true

module PowerDashboard
  class AutocompleteSuggestions
    def initialize(query:)
      @query = query.to_s.strip
      @normalized = @query.downcase
    end

    def call
      return [] if @normalized.length < 2

      suggestions = []
      suggestions.concat(action_suggestions)
      suggestions.concat(organization_suggestions)
      suggestions.concat(participant_suggestions)
      suggestions.concat(tool_suggestions)
      suggestions.concat(scissor_lift_suggestions)
      suggestions.take(20)
    end

    private

    def action_suggestions
      ActionRegistry.suggestions.filter do |suggestion|
        label = suggestion[:label].downcase
        value = suggestion[:value].downcase
        label.start_with?(@normalized) ||
          value.start_with?(@normalized) ||
          label.split.any? { |word| word.start_with?(@normalized) }
      end.map { |suggestion| suggestion.merge(type: 'action') }
    end

    def organization_suggestions
      Organization
        .autocomplete_matches(@normalized)
        .order(:name)
        .limit(5)
        .map do |organization|
          label = organization.short_name.present? ?
                    "Organization: #{organization.name} (#{organization.short_name})" :
                    "Organization: #{organization.name}"
          value = organization.short_name.presence || organization.name
          { label: label, value: value, type: 'organization' }
        end
    end

    def participant_suggestions
      normalized = @normalized
      Participant
        .autocomplete_matches(normalized)
        .order(:cached_name)
        .limit(5)
        .map do |participant|
          label = participant.email.present? ?
                    "Participant: #{participant.name} (#{participant.email})" :
                    "Participant: #{participant.name}"
          value = participant.eppn.presence || participant.formatted_name
          { label: label, value: value, type: 'participant' }
        end
    end

    def tool_suggestions
      Tool
        .autocomplete_matches(@normalized)
        .order(:barcode)
        .limit(5)
        .map do |tool|
          label = "Tool: #{tool.formatted_name} (#{tool.barcode})"
          { label: label, value: tool.barcode, type: 'tool' }
        end
    end

    def scissor_lift_suggestions
      ScissorLift
        .autocomplete_matches(@normalized)
        .order(:name)
        .limit(5)
        .map do |lift|
          { label: "Scissor lift: #{lift.name}", value: lift.name, type: 'scissor_lift' }
        end
    end
  end
end

# frozen_string_literal: true

module Dashboard
  # Parses and serializes dashboard flow state from URL/form params.
  class FlowState
    def initialize(params)
      @params = params
    end

    def flow
      kind = @params[:kind].to_s
      return if kind.blank?
      return unless FlowDefinition.valid_kind?(kind)

      flow = {
        'kind' => kind,
        'tool_ids' => self.class.parse_ids(@params[:tool_ids]),
        'participant_id' => @params[:participant_id].presence,
        'organization_id' => @params[:organization_id].presence,
        'scissor_lift_id' => @params[:scissor_lift_id].presence,
        'queue_type' => @params[:queue_type].presence,
        'queue_action' => @params[:queue_action].presence,
        'queue_source' => @params[:queue_source].presence,
        'queue_message' => @params[:queue_message].to_s.strip.presence,
        'lift_action' => @params[:lift_action].presence,
        'hours' => @params[:hours].presence,
        'lookup_type' => @params[:lookup_type].presence,
        'lookup_id' => @params[:lookup_id].presence
      }
      flow['step'] = normalized_step(flow, @params[:step])
      flow
    end

    def default_flow(kind)
      {
        'kind' => kind,
        'step' => FlowDefinition.initial_step(kind),
        'tool_ids' => []
      }
    end

    def self.to_params(flow)
      return {} if flow.blank?

      {
        kind: flow['kind'],
        step: flow['step'],
        tool_ids: Array(flow['tool_ids']).join(','),
        participant_id: flow['participant_id'],
        organization_id: flow['organization_id'],
        scissor_lift_id: flow['scissor_lift_id'],
        queue_type: flow['queue_type'],
        queue_action: flow['queue_action'],
        queue_source: flow['queue_source'],
        queue_message: flow['queue_message'],
        lift_action: flow['lift_action'],
        hours: flow['hours'],
        lookup_type: flow['lookup_type'],
        lookup_id: flow['lookup_id']
      }.compact
    end

    def self.parse_ids(value)
      value.to_s.split(',').map(&:strip).reject(&:blank?).map(&:to_i).uniq
    end

    private

    def normalized_step(flow, step)
      candidate = step.to_s
      return FlowDefinition.initial_step(flow['kind']) if candidate.blank?
      return candidate if FlowDefinition.valid_step?(flow, candidate)

      FlowDefinition.initial_step(flow['kind'])
    end
  end
end

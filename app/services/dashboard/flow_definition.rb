# frozen_string_literal: true

module Dashboard
  # Central definition for wizard flow sequencing.
  # Keep action/step additions here so controller/view logic stays small.
  class FlowDefinition
    FLOW_KINDS = %w[checkout checkin queue lift lookup].freeze

    def self.valid_kind?(kind)
      FLOW_KINDS.include?(kind.to_s)
    end

    def self.initial_step(kind)
      case kind.to_s
      when 'checkout', 'checkin'
        'tools'
      when 'queue'
        'queue_type'
      when 'lift'
        'lift_action'
      when 'lookup'
        'lookup'
      else
        'tools'
      end
    end

    def self.valid_step?(flow, step)
      sequence(flow).include?(step.to_s) || auxiliary_step?(flow, step)
    end

    def self.previous_step(flow)
      return 'queue_action' if flow['kind'] == 'queue' && flow['step'] == 'queue_current'
      return 'lift_action' if flow['kind'] == 'lift' && flow['step'] == 'lift_current'

      steps = sequence(flow)
      index = steps.index(flow['step'].to_s)
      return if index.blank? || index.zero?

      steps[index - 1]
    end

    def self.terminal_step?(flow)
      return false if flow.blank?

      kind = flow['kind'].to_s
      step = flow['step'].to_s
      case kind
      when 'checkout'
        step == 'organization'
      when 'lift'
        (flow['lift_action'] == 'forfeit' && step == 'scissor_lift') ||
          (flow['lift_action'] == 'checkin' && step == 'scissor_lift') ||
          (flow['lift_action'] == 'renew' && step == 'renew_hours') ||
          (flow['lift_action'] == 'checkout' && step == 'organization')
      else
        false
      end
    end

    def self.sequence(flow)
      case flow['kind'].to_s
      when 'checkout'
        %w[tools participant organization]
      when 'checkin'
        %w[tools]
      when 'queue'
        if flow['queue_action'] == 'remove'
          %w[queue_type queue_action organization]
        elsif flow['queue_source'] == 'by_user'
          %w[queue_type queue_action queue_source participant organization queue_message]
        else
          %w[queue_type queue_action queue_source organization queue_message]
        end
      when 'lift'
        if flow['lift_action'] == 'checkout'
          %w[lift_action scissor_lift participant organization]
        elsif flow['lift_action'] == 'renew'
          %w[lift_action scissor_lift renew_hours renew_custom]
        else
          %w[lift_action scissor_lift]
        end
      when 'lookup'
        %w[lookup result]
      else
        []
      end
    end

    def self.auxiliary_step?(flow, step)
      case flow['kind'].to_s
      when 'queue'
        step.to_s == 'queue_current'
      when 'lift'
        step.to_s == 'lift_current'
      else
        false
      end
    end
  end
end

# frozen_string_literal: true

module Dashboard
  # Central definition for wizard flow sequencing.
  class FlowDefinition
    FLOW_KINDS = %w[checkout checkin queue lift lookup].freeze

    INITIAL_STEP = {
      'checkout' => 'tools',
      'checkin' => 'tools',
      'queue' => 'queue_type',
      'lift' => 'lift_action',
      'lookup' => 'lookup'
    }.freeze

    def self.valid_kind?(kind)
      FLOW_KINDS.include?(kind.to_s)
    end

    def self.initial_step(kind)
      INITIAL_STEP.fetch(kind.to_s, 'tools')
    end

    def self.valid_step?(flow, step)
      sequence(flow).include?(step.to_s) || auxiliary_step?(flow, step)
    end

    def self.previous_step(flow)
      if flow['kind'] == 'queue' && flow['step'] == 'queue_current'
        return 'queue_action'
      end
      if flow['kind'] == 'lift' && flow['step'] == 'lift_current'
        return 'lift_action'
      end

      steps = sequence(flow)
      index = steps.index(flow['step'].to_s)
      return if index.blank? || index.zero?

      steps[index - 1]
    end

    def self.terminal_step?(flow)
      return false if flow.blank?

      case flow['kind'].to_s
      when 'checkout'
        flow['step'] == 'organization'
      when 'lift'
        lift_terminal?(flow)
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
        queue_sequence(flow)
      when 'lift'
        lift_sequence(flow)
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

    def self.lift_terminal?(flow)
      step = flow['step']
      (flow['lift_action'] == 'checkin' && step == 'scissor_lift') ||
        (flow['lift_action'] == 'renew' && step == 'renew_hours') ||
        (flow['lift_action'] == 'checkout' && step == 'organization')
    end
    private_class_method :lift_terminal?

    def self.queue_sequence(flow)
      if flow['queue_action'] == 'remove'
        return %w[queue_type queue_action organization]
      end

      if flow['queue_source'] == 'by_user'
        return(
          %w[
            queue_type
            queue_action
            queue_source
            participant
            organization
            queue_message
          ]
        )
      end

      %w[queue_type queue_action queue_source organization queue_message]
    end
    private_class_method :queue_sequence

    def self.lift_sequence(flow)
      case flow['lift_action']
      when 'checkout'
        %w[lift_action scissor_lift participant organization]
      when 'renew'
        %w[lift_action scissor_lift renew_hours renew_custom]
      else
        %w[lift_action scissor_lift]
      end
    end
    private_class_method :lift_sequence
  end
end

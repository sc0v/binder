# frozen_string_literal: true

module Dashboard
  # Applies step-specific updates while clearing stale dependent fields.
  class FlowUpdater
    def initialize(flow:, params:)
      @flow = flow
      @params = params
    end

    def call
      @flow['queue_type'] = @params[:queue_type] if @params[:queue_type].present?
      apply_queue_action
      apply_queue_source
      @flow['organization_id'] = @params[:organization_id].presence if @params.key?(:organization_id)
      @flow['queue_message'] = @params[:queue_message].to_s.strip if @params.key?(:queue_message)
      @flow['scissor_lift_id'] = @params[:scissor_lift_id] if @params[:scissor_lift_id].present?
      apply_lift_action
      hours_error = apply_hours
      return { error: hours_error } if hours_error.present?
      apply_next_step
      { flow: @flow }
    rescue ArgumentError
      { error: 'Hours must be a whole number.' }
    end

    private

    def apply_queue_action
      return unless @params[:queue_action].present?

      new_queue_action = @params[:queue_action]
      @flow['queue_message'] = nil if @flow['queue_action'] != new_queue_action
      @flow['queue_action'] = new_queue_action
      return unless new_queue_action == 'remove'

      @flow['queue_source'] = nil
      @flow['participant_id'] = nil
    end

    def apply_queue_source
      return unless @params[:queue_source].present?

      @flow['queue_source'] = @params[:queue_source]
      @flow['participant_id'] = nil if @flow['queue_source'] == 'by_org'
      @flow['organization_id'] = nil
      @flow['queue_message'] = nil
    end

    def apply_lift_action
      return unless @params[:lift_action].present?

      new_lift_action = @params[:lift_action]
      if @flow['lift_action'] != new_lift_action
        @flow['hours'] = nil
        @flow['participant_id'] = nil
        @flow['organization_id'] = nil
      end
      @flow['lift_action'] = new_lift_action
    end

    def apply_hours
      return if @params[:hours].blank?

      hours = Integer(@params[:hours], 10)
      return 'Hours must be greater than zero.' if hours <= 0

      @flow['hours'] = hours
      nil
    end

    def apply_next_step
      next_step = @params[:next_step].to_s
      return if next_step.blank?
      return unless FlowDefinition.valid_step?(@flow, next_step)

      @flow['step'] = next_step
    end
  end
end

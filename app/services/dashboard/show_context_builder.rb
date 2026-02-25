# frozen_string_literal: true

module Dashboard
  # Builds all data needed by dashboard/show from a parsed flow.
  class ShowContextBuilder
    def initialize(flow:)
      @flow = flow
    end

    def call
      flow_kind = @flow&.dig('kind')
      flow_participant = Participant.find_by(id: @flow&.dig('participant_id'))
      checked_out_lift_ids = ScissorLiftCheckout.where(checked_in_at: nil).select(:scissor_lift_id)
      checked_out_lifts = ScissorLift.where(id: checked_out_lift_ids).order(:name).to_a
      available_lifts = ScissorLift.where.not(id: checked_out_lift_ids).order(:name).to_a

      {
        flow: @flow,
        flow_kind: flow_kind,
        step: @flow&.dig('step'),
        initial_step: flow_kind.present? ? FlowDefinition.initial_step(flow_kind) : nil,
        terminal_step: @flow.present? ? FlowDefinition.terminal_step?(@flow) : false,
        flow_tools: Tool.where(id: Array(@flow&.dig('tool_ids')).map(&:to_i)).index_by(&:id),
        flow_participant: flow_participant,
        flow_participant_organizations: flow_participant&.organizations&.order(:name)&.to_a || [],
        flow_organization: Organization.find_by(id: @flow&.dig('organization_id')),
        all_organizations: Organization.order(:name).to_a,
        queued_organizations: queued_organizations_for(@flow&.dig('queue_type')),
        queue_current_resource: queue_resource_for(flow_kind),
        flow_lift: ScissorLift.find_by(id: @flow&.dig('scissor_lift_id')),
        checked_out_lifts: checked_out_lifts,
        available_lifts: available_lifts,
        random_available_lift: available_lifts.sample,
        lift_overview_resource: flow_kind == 'lift' ? PowerDashboard::ScissorLiftOverviewResource.new : nil,
        lookup_resource: lookup_resource_for(@flow),
        flow_params: FlowState.to_params(@flow)
      }
    end

    private

    def queue_resource_for(flow_kind)
      return unless flow_kind == 'queue'
      return if @flow['queue_type'].blank?

      PowerDashboard::QueueResource.new(@flow['queue_type'])
    end

    def lookup_resource_for(flow)
      return if flow.blank? || flow['kind'] != 'lookup'
      return if flow['lookup_type'].blank? || flow['lookup_id'].blank?

      case flow['lookup_type']
      when 'tool' then Tool.find_by(id: flow['lookup_id'])
      when 'participant' then Participant.find_by(id: flow['lookup_id'])
      when 'organization' then Organization.find_by(id: flow['lookup_id'])
      when 'scissor_lift' then ScissorLift.find_by(id: flow['lookup_id'])
      end
    end

    def queued_organizations_for(queue_type)
      return [] unless %w[electrical structural].include?(queue_type.to_s)

      OrganizationTimelineEntry.current
                               .where(entry_type: queue_type)
                               .includes(:organization)
                               .filter_map(&:organization)
                               .uniq(&:id)
                               .sort_by(&:name)
    end
  end
end

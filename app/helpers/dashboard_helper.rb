# frozen_string_literal: true

module DashboardHelper
  include PowerDashboardHelper

  def dashboard_h1(flow_kind, step, flow = {})
    return 'Dashboard' if flow_kind.blank?

    "#{flow_kind.to_s.titleize}: #{dashboard_step_label(flow_kind, step, flow)}"
  end

  def dashboard_flow_hidden_fields(flow_params, except: [])
    return if flow_params.blank?

    keys_to_skip = Array(except).map(&:to_s)
    fields = flow_params.except(*keys_to_skip).map do |key, value|
      hidden_field_tag(key, value)
    end
    safe_join(fields)
  end

  def dashboard_tool_state(tool)
    tool.is_checked_out? ? 'Checked out' : 'Checked in'
  end

  def dashboard_tool_state_class(tool)
    tool.is_checked_out? ? 'power-item-unavailable' : 'power-item-available'
  end

  private

  def dashboard_step_label(flow_kind, step, flow)
    case [flow_kind.to_s, step.to_s]
    when ['checkout', 'tools'], ['checkin', 'tools']
      'Scan Tools'
    when ['checkout', 'participant'], ['lift', 'participant'], ['queue', 'participant']
      'Scan Borrower'
    when ['checkout', 'organization'], ['lift', 'organization'], ['queue', 'organization']
      'Select Organization'
    when ['queue', 'queue_type']
      'Select Queue Type'
    when ['queue', 'queue_action']
      'Select Queue Action'
    when ['queue', 'queue_source']
      'Select Source'
    when ['queue', 'queue_message']
      'Enter Message'
    when ['queue', 'queue_current']
      'Current Queue'
    when ['lift', 'lift_action']
      'Select Lift Action'
    when ['lift', 'scissor_lift']
      %w[renew checkin].include?(flow['lift_action']) ? 'Select Checked Out Lift' : 'Select Lift'
    when ['lift', 'renew_hours']
      'Select Renewal Hours'
    when ['lift', 'renew_custom']
      'Custom Renewal Hours'
    when ['lift', 'lift_current']
      'Current Lifts'
    when ['lookup', 'lookup']
      'Lookup'
    when ['lookup', 'result']
      'Lookup Result'
    else
      step.to_s.humanize.presence || 'Step'
    end
  end
end

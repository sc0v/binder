# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :require_authentication
  # Flow state is carried in params, not session, so leaving/reloading resets wizard state.

  def show
    load_flow
  end

  def start
    kind = params[:kind].to_s
    unless Dashboard::FlowDefinition.valid_kind?(kind)
      redirect_to dashboard_path, alert: 'Select a valid action.'
      return
    end

    redirect_to dashboard_path(flow_to_params(flow_state.default_flow(kind)))
  end

  def scan
    flow = flow_from_params
    if flow.blank?
      redirect_to dashboard_path, alert: 'Choose an action first.'
      return
    end

    input = params[:scan_input].to_s.strip
    target = params[:target].to_s
    continue_to = params[:continue_to].to_s

    if input.present?
      result = scan_resolver.call(flow: flow, target: target, input: input)
      if result[:error].present?
        redirect_to dashboard_path(flow_to_params(flow)), alert: result[:error]
        return
      end

      if target != 'tool' && continue_to.present? && Dashboard::FlowDefinition.valid_step?(flow, continue_to)
        flow['step'] = next_step_after_successful_scan(flow, target, continue_to)
      end

      return advance_ready_flow(flow) if auto_selected_org_ready_for_next_stage?(flow, target, continue_to)

      flash_key = result[:flash_key].presence || :notice
      redirect_to dashboard_path(flow_to_params(flow)), flash: { flash_key => result[:notice] }
      return
    end

    if continue_to == 'confirm' && (
      (flow['kind'] == 'checkin' && target == 'tool') ||
      (flow['kind'] == 'lift' && flow['lift_action'] == 'forfeit' && target == 'scissor_lift')
    )
      unless scan_requirement_satisfied?(flow, target)
        redirect_to dashboard_path(flow_to_params(flow)), alert: 'Scan required before continuing.'
        return
      end

      return advance_ready_flow(flow)
    end

    if continue_to.present? && Dashboard::FlowDefinition.valid_step?(flow, continue_to)
      unless scan_requirement_satisfied?(flow, target)
        redirect_to dashboard_path(flow_to_params(flow)), alert: 'Scan required before continuing.'
        return
      end

      flow['step'] = continue_to
      redirect_to dashboard_path(flow_to_params(flow))
      return
    end

    redirect_to dashboard_path(flow_to_params(flow)), alert: 'Scan or enter a value first.'
  end

  def update
    flow = flow_from_params
    if flow.blank?
      redirect_to dashboard_path, alert: 'Choose an action first.'
      return
    end

    update_result = Dashboard::FlowUpdater.new(flow: flow, params: params).call
    if update_result[:error].present?
      redirect_to dashboard_path(flow_to_params(flow)), alert: update_result[:error]
      return
    end

    redirect_to dashboard_path(flow_to_params(update_result[:flow]))
  end

  def undo
    flow = flow_from_params
    if flow.blank?
      redirect_to dashboard_path
      return
    end

    previous = Dashboard::FlowDefinition.previous_step(flow)
    flow['step'] = previous if previous.present?
    redirect_to dashboard_path(flow_to_params(flow))
  end

  def complete
    flow = flow_from_params
    if flow.blank?
      redirect_to dashboard_path, alert: 'Choose an action first.'
      return
    end

    if flow['kind'] == 'lookup'
      redirect_to dashboard_path(flow_to_params(flow)), notice: 'Lookup does not execute actions.'
      return
    end

    pending_result = pending_builder.call(flow)
    if pending_result[:error].present?
      redirect_to dashboard_path(flow_to_params(flow)), alert: pending_result[:error]
      return
    end

    pending = pending_result[:pending]
    pending['requires_confirmation'] = action_requires_confirmation?(pending['action'])
    sync_cart_to_session(flow)

    if pending['requires_confirmation']
      redirect_to dashboard_confirm_path(build_confirm_params(flow: flow, pending: pending))
      return
    end

    result = action_executor.execute(pending)
    redirect_to dashboard_path(flow_to_params(flow)), **flash_for(result)
  end

  def confirm
    # Uses pending_action so Rails' reserved params[:action] is not overwritten.
    @pending_action = params.permit(:pending_action, :participant_id, :organization_id, :scissor_lift_id, :queue_type, :hours,
                                    :requires_confirmation, :flow_tool_ids, :queue_message).to_h
    @flow_params_for_confirm = params.permit(:kind, :step, :tool_ids, :participant_id, :organization_id, :scissor_lift_id,
                                             :queue_type, :queue_action, :lift_action, :hours, :lookup_type, :lookup_id,
                                             :queue_message, :undo_step).to_h
    if @pending_action['pending_action'].blank?
      redirect_to dashboard_path, alert: 'No action to confirm.'
      return
    end

    @pending_receipt = receipt_builder.build(@pending_action.merge('action' => @pending_action['pending_action']))
  end

  def execute
    pending = params.permit(:pending_action, :participant_id, :organization_id, :scissor_lift_id, :queue_type, :hours,
                            :requires_confirmation, :flow_tool_ids, :queue_message).to_h
    if pending['pending_action'].blank?
      redirect_to dashboard_path, alert: 'No action to confirm.'
      return
    end

    pending['action'] = pending.delete('pending_action')
    pre_checkout_tool_ids = Dashboard::FlowState.parse_ids(pending['flow_tool_ids'])
    pending['confirmed'] = true
    result = action_executor.execute(pending)

    if pending['action'] == 'checkout_tools_cart'
      remaining_ids = Array(session[:tools]).map(&:to_i)
      checked_out_ids = pre_checkout_tool_ids - remaining_ids

      if result[:error].blank? && remaining_ids.empty?
        session[:tools] = []
        redirect_to dashboard_path, notice: result[:message].presence || 'Checkout complete.'
        return
      end

      redirect_to dashboard_result_path(
        message: result[:error].presence || result[:message],
        checked_out_ids: checked_out_ids.join(','),
        remaining_ids: remaining_ids.join(','),
        participant_id: pending['participant_id'],
        organization_id: pending['organization_id']
      )
      return
    end

    redirect_to dashboard_path, **flash_for(result)
  end

  def cancel
    flow = flow_from_params
    if flow.present?
      target_step = params[:undo_step].presence || Dashboard::FlowDefinition.previous_step(flow)
      flow['step'] = target_step if target_step.present?
      redirect_to dashboard_path(flow_to_params(flow)), notice: 'Action canceled.'
      return
    end

    redirect_to dashboard_path, notice: 'Action canceled.'
  end

  def result
    @message = params[:message].to_s
    @checked_out_tools = Tool.where(id: Dashboard::FlowState.parse_ids(params[:checked_out_ids]))
    @remaining_tools = Tool.where(id: Dashboard::FlowState.parse_ids(params[:remaining_ids]))
    @continue_params = {
      kind: 'checkout',
      step: 'organization',
      tool_ids: params[:remaining_ids].to_s,
      participant_id: params[:participant_id].presence,
      organization_id: params[:organization_id].presence
    }.compact
  end

  def reset
    session[:tools] = []
    redirect_to dashboard_path
  end

  private

  def load_flow
    Dashboard::ShowContextBuilder.new(flow: flow_from_params).call.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def flow_state
    @flow_state ||= Dashboard::FlowState.new(params)
  end

  def flow_from_params
    flow_state.flow
  end

  def flow_to_params(flow)
    Dashboard::FlowState.to_params(flow)
  end

  def scan_resolver
    @scan_resolver ||= Dashboard::ScanResolver.new
  end

  def sync_cart_to_session(flow)
    return unless %w[checkin checkout].include?(flow['kind'])

    session[:tools] = Array(flow['tool_ids']).map(&:to_i)
  end

  def flash_for(result)
    result[:error].present? ? { alert: result[:error] } : { notice: result[:message] }
  end

  def action_executor
    @action_executor ||= PowerDashboard::ActionExecutor.new(
      session_state: PowerDashboard::SessionState.new(session),
      ability: method(:can?)
    )
  end

  def receipt_builder
    @receipt_builder ||= PowerDashboard::ReceiptBuilder.new(
      session_state: PowerDashboard::SessionState.new(session)
    )
  end

  def next_step_after_successful_scan(flow, target, continue_to)
    return continue_to unless target == 'participant' && continue_to == 'organization'

    participant = Participant.find_by(id: flow['participant_id'])
    return continue_to if participant.blank?

    organizations = participant.organizations.order(:name).to_a
    return continue_to unless organizations.size == 1

    flow['organization_id'] = organizations.first.id
    return flow['queue_action'] == 'add' ? 'queue_message' : 'organization' if flow['kind'] == 'queue'

    'organization'
  end

  def auto_selected_org_ready_for_next_stage?(flow, target, continue_to)
    return false unless target == 'participant' && continue_to == 'organization'
    return false if flow['organization_id'].blank?

    flow['kind'] == 'checkout' || (flow['kind'] == 'lift' && flow['lift_action'] == 'checkout')
  end

  def advance_ready_flow(flow)
    pending_result = pending_builder.call(flow)
    if pending_result[:error].present?
      return redirect_to dashboard_path(flow_to_params(flow)), alert: pending_result[:error]
    end

    pending = pending_result[:pending]
    pending['requires_confirmation'] = action_requires_confirmation?(pending['action'])
    sync_cart_to_session(flow)

    if pending['requires_confirmation']
      return redirect_to dashboard_confirm_path(build_confirm_params(flow: flow, pending: pending))
    end

    result = action_executor.execute(pending)
    redirect_to dashboard_path(flow_to_params(flow)), **flash_for(result)
  end

  def scan_requirement_satisfied?(flow, target)
    case target
    when 'tool' then Array(flow['tool_ids']).any?
    when 'participant' then flow['participant_id'].present?
    when 'organization' then flow['organization_id'].present?
    when 'scissor_lift' then flow['scissor_lift_id'].present?
    when 'lookup' then flow['lookup_id'].present? && flow['lookup_type'].present?
    else false
    end
  end

  def build_confirm_params(flow:, pending:)
    pending.except('action').merge(
      'pending_action' => pending['action'],
      'flow_tool_ids' => Array(flow['tool_ids']).join(','),
      'undo_step' => Dashboard::FlowDefinition.previous_step(flow)
    ).merge(flow_to_params(flow))
  end

  def pending_builder
    @pending_builder ||= Dashboard::PendingBuilder.new
  end

  def action_requires_confirmation?(action_name)
    handler = PowerDashboard::ActionRegistry.handler_for_action(action_name)
    handler&.confirmation_required? == true
  end
end

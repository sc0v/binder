# frozen_string_literal: true

class PowerDashboardController < ApplicationController
  before_action :require_authentication

  def show
    session_state.update_auto_add_from_params(params)
    load_session_state
  end

  def autocomplete
    query = params[:q].to_s.strip
    suggestions = PowerDashboard::AutocompleteSuggestions.new(query:).call
    render json: { suggestions: suggestions }
  rescue StandardError => e
    render json: { error: e.message, suggestions: [] }, status: :internal_server_error
  end

  def submit
    input = params[:power_input].to_s.strip
    if input.blank?
      redirect_to power_dashboard_path, alert: t('power_dashboard.submit.blank_input')
      return
    end

    # Reset any previous action so this input is the source of truth.
    session_state.clear_pending_action

    # First, interpret command-style actions (checkin/checkout/etc).
    action = action_parser.parse(input)
    if action
      if action[:error].present?
        redirect_to power_dashboard_path, alert: action[:error]
        return
      end

      # Pending actions are staged in the session and may require more input or confirmation.
      pending = action[:pending]
      if pending[:needs_org_selection]
        # Strip the selection flag and redirect; apply_organization will restore the action.
        session[:power_pending_action] = pending.except(:needs_org_selection)
        redirect_to power_dashboard_select_organization_path
        return
      end

      if pending[:requires_confirmation]
        # Persist the pending action and show a receipt/confirm page before execution.
        session[:power_pending_action] = pending
        redirect_to power_dashboard_confirm_path
        return
      end

      result = action_executor.execute(pending)
      if result[:error].present?
        redirect_to power_dashboard_path, alert: result[:error]
      else
        redirect_to power_dashboard_path, notice: result[:message]
      end
      return
    end

    # Otherwise, treat input as a resource selection (tool/participant/org).
    result = resource_input_handler.handle(input)
    if result[:flash].present?
      redirect_to power_dashboard_path, **result[:flash]
      return
    end

    if result[:error].present?
      load_session_state
      flash.now[:alert] = result[:error]
      render :show
    end
  end

  def confirm
    load_session_state
    @pending_action = session[:power_pending_action]
    if @pending_action.blank?
      redirect_to power_dashboard_path, alert: t('power_dashboard.confirm.missing_action')
      return
    end
    @pending_receipt = receipt_builder.build(@pending_action)
  end

  def execute
    pending = session[:power_pending_action]
    if pending.blank?
      redirect_to power_dashboard_path, alert: t('power_dashboard.confirm.missing_action')
      return
    end

    pending['confirmed'] = true
    result = action_executor.execute(pending)
    session[:power_pending_action] = nil

    if result[:error].present?
      redirect_to power_dashboard_path, alert: result[:error]
      return
    end

    redirect_to power_dashboard_path, notice: result[:message]
  end

  def cancel
    session[:power_pending_action] = nil
    redirect_to power_dashboard_path, notice: t('power_dashboard.cancel.notice')
  end

  def select_organization
    load_session_state
    @borrower = session_state.current_borrower
    if @borrower.blank?
      redirect_to power_dashboard_path, alert: t('resources.participant.select_first')
      return
    end
    @organizations = @borrower.organizations.order(:name)
  end

  def apply_organization
    borrower = session_state.current_borrower
    if borrower.blank?
      redirect_to power_dashboard_path, alert: t('resources.participant.select_first')
      return
    end

    organization = borrower.organizations.find_by(id: params[:organization_id])
    if organization.blank?
      redirect_to power_dashboard_select_organization_path, alert: t('power_dashboard.select_organization.invalid_organization')
      return
    end

    session[:power_organization_id] = organization.id
    session_state.set_current_resource(:organization, organization)

    if session[:power_pending_action].present?
      session[:power_pending_action]['organization_id'] ||= organization.id
      redirect_to power_dashboard_confirm_path
    else
      redirect_to power_dashboard_path, notice: t('power_dashboard.organization.selected', name: organization.name)
    end
  end

  private

  def load_session_state
    state = session_state.load_state
    @borrower = state[:borrower]
    @organization = state[:organization]
    @current_resource_type = state[:current_resource_type]
    @current_resource = state[:current_resource]
    @tools = state[:tools]
    @auto_add_tools = state[:auto_add_tools]
  end

  def session_state
    @session_state ||= PowerDashboard::SessionState.new(session)
  end

  def resource_lookup
    @resource_lookup ||= PowerDashboard::ResourceLookup.new
  end

  def action_parser
    @action_parser ||= PowerDashboard::ActionParser.new(session_state:)
  end

  def action_executor
    @action_executor ||= PowerDashboard::ActionExecutor.new(session_state:, ability: method(:can?))
  end

  def resource_input_handler
    @resource_input_handler ||= PowerDashboard::ResourceInputHandler.new(session_state:, resource_lookup:)
  end

  def receipt_builder
    @receipt_builder ||= PowerDashboard::ReceiptBuilder.new(session_state:)
  end
end

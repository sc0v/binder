# frozen_string_literal: true

class PowerDashboardController < ApplicationController
  before_action :require_authentication

  def show
    session_state.update_auto_add_from_params(params)
    load_session_state
  end

  def autocomplete
    query = params[:q].to_s.strip
    include_actions = params[:mode].to_s != 'resources'
    suggestions = PowerDashboard::AutocompleteSuggestions.new(query:, include_actions:).call
    render json: { suggestions: }
  rescue StandardError => e
    render json: { error: e.message, suggestions: [] }, status: :internal_server_error
  end

  def submit
    input = params[:power_input].to_s.strip
    if input.blank?
      redirect_to power_dashboard_path, alert: t('.blank_input')
      return
    end

    # Each submit starts fresh — clear any leftover pending action from a
    # previous interaction before we parse the new input.
    session_state.clear_pending_action

    # Try to parse the input as a command (checkin, checkout, add, clear, etc.).
    # If it matches, dispatch to the appropriate action path.
    action = action_parser.parse(input)
    return dispatch_action(action) if action

    # Input wasn't a command — treat it as a resource identifier (barcode,
    # eppn, lift name, etc.) and update the session context accordingly.
    handle_resource_input(input)
  end

  private

  # Routes a parsed action to confirm, org selection, or immediate execution.
  def dispatch_action(action)
    if action[:error].present?
      redirect_to power_dashboard_path, alert: action[:error]
      return
    end

    pending = action[:pending]

    # Checkout needs an org but the participant belongs to multiple — ask first.
    if pending[:needs_org_selection]
      session[:power_pending_action] = pending.except(:needs_org_selection)
      redirect_to power_dashboard_select_organization_path
      return
    end

    # Destructive actions (checkin, checkout) require explicit confirmation.
    if pending[:requires_confirmation]
      session[:power_pending_action] = pending
      redirect_to power_dashboard_confirm_path
      return
    end

    # Safe actions (add, remove, clear, select queue, etc.) execute immediately.
    result = action_executor.execute(pending)
    redirect_to power_dashboard_path, **flash_for(result)
  end

  # Resolves the input as a resource and updates the session context.
  # On success, redirects with a notice. On unrecognised input, re-renders
  # the show page with an inline error so the input field stays focused.
  def handle_resource_input(input)
    result = resource_input_handler.handle(input)

    if result[:flash].present?
      redirect_to power_dashboard_path, **result[:flash]
      return
    end

    return if result[:error].blank?

    load_session_state
    flash.now[:alert] = result[:error]
    render :show
  end

  def confirm
    load_session_state
    @pending_action = session[:power_pending_action]
    if @pending_action.blank?
      redirect_to power_dashboard_path, alert: t('.missing_action')
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

    return redirect_to power_dashboard_path, alert: result[:error] if result[:error].present?

    redirect_to power_dashboard_path, notice: result[:message]
  end

  def cancel
    session[:power_pending_action] = nil
    redirect_to power_dashboard_path, notice: t('.notice')
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
      redirect_to power_dashboard_select_organization_path,
                  alert: t('power_dashboard.select_organization.invalid_organization')
      return
    end

    session[:power_organization_id] = organization.id
    session_state.assign_resource(:organization, organization)

    if session[:power_pending_action].present?
      session[:power_pending_action]['organization_id'] ||= organization.id
      redirect_to power_dashboard_confirm_path
    else
      redirect_to power_dashboard_path, notice: t('power_dashboard.organization.selected', name: organization.name)
    end
  end

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
    @session_state ||= Dashboard::SessionState.new(session)
  end

  def resource_lookup
    @resource_lookup ||= Dashboard::ResourceLookup.new
  end

  def action_parser
    @action_parser ||= PowerDashboard::ActionParser.new(session_state:)
  end

  def action_executor
    @action_executor ||= Dashboard::ActionExecutor.new(session_state:, ability: current_ability)
  end

  def resource_input_handler
    @resource_input_handler ||= PowerDashboard::ResourceInputHandler.new(session_state:, resource_lookup:)
  end

  def receipt_builder
    @receipt_builder ||= Dashboard::ReceiptBuilder.new(session_state:)
  end
end

# frozen_string_literal: true

module PowerDashboard
  class SessionState
    attr_reader :session

    def initialize(session)
      @session = session
    end

    def load_state
      borrower = current_borrower
      organization = current_organization
      current_resource_type = current_resource_type()
      current_resource = current_resource()

      tool_ids = Array(session[:tools]).map(&:to_i)
      tools_by_id = Tool.where(id: tool_ids).index_by(&:id)
      tools = tool_ids.filter_map { |tool_id| tools_by_id[tool_id] }

      {
        borrower:,
        organization:,
        current_resource_type:,
        current_resource:,
        tools:,
        auto_add_tools: auto_add_tools?
      }
    end

    def update_auto_add_from_params(params)
      return unless params.key?(:auto_add_tools)

      session[:power_auto_add_tools] = params[:auto_add_tools].to_s == '1'
    end

    def auto_add_tools?
      session[:power_auto_add_tools] == true
    end

    def toggle_auto_add_tools
      session[:power_auto_add_tools] = !auto_add_tools?
    end

    def current_borrower
      return @current_borrower if defined?(@current_borrower)

      @current_borrower = Participant.find_by(id: session[:borrower_id])
    end

    def current_tool
      return unless current_resource_type == 'tool'

      current_resource
    end

    def current_scissor_lift
      return unless current_resource_type == 'scissor_lift'

      current_resource
    end

    def current_resource
      return @current_resource if defined?(@current_resource)

      @current_resource = load_current_resource
    end

    def current_resource_type
      session[:power_current_resource_type]
    end

    def current_resource_id
      session[:power_current_resource_id]
    end

    def current_organization
      return @current_organization if defined?(@current_organization)

      organization = Organization.find_by(id: session[:power_organization_id])
      if organization.present? && current_borrower.present? && !current_borrower.organizations.exists?(organization.id)
        organization = nil
        session[:power_organization_id] = nil
      end
      @current_organization = organization
    end

    def set_participant(participant)
      session[:borrower_id] = participant.id
      organizations = participant.organizations
      if organizations.count == 1
        session[:power_organization_id] = organizations.first.id
      else
        session[:power_organization_id] = nil
      end
    end

    def set_current_resource(type, record)
      session[:power_current_resource_type] = type.to_s
      session[:power_current_resource_id] = record.id
    end

    def set_queue_resource(queue_type)
      session[:power_current_resource_type] = 'queue'
      session[:power_current_resource_id] = queue_type.to_s
    end

    def set_scissor_lift_overview
      session[:power_current_resource_type] = 'scissor_lift_overview'
      session[:power_current_resource_id] = 'overview'
    end

    def clear_pending_action
      session[:power_pending_action] = nil
    end

    def clear_power_session
      session[:borrower_id] = nil
      session[:power_organization_id] = nil
      session[:power_current_resource_type] = nil
      session[:power_current_resource_id] = nil
      session[:power_pending_action] = nil
      session[:power_auto_add_tools] = nil
      session[:tools] = []
    end

    def organization_allowed?(organization)
      borrower = current_borrower
      return true if borrower.blank?
      return false if organization.blank?

      borrower.organizations.exists?(organization.id)
    end

    def selected_organization_for_borrower
      allowed_organization(session[:power_organization_id])
    end

    def organization_for_queue
      if current_resource_type == 'organization'
        return Organization.find_by(id: current_resource_id)
      end

      allowed_organization(session[:power_organization_id])
    end

    private

    def load_current_resource
      case current_resource_type
      when 'tool'
        Tool.find_by(id: current_resource_id)
      when 'scissor_lift'
        ScissorLift.find_by(id: current_resource_id)
      when 'organization'
        Organization.find_by(id: current_resource_id)
      when 'participant'
        Participant.find_by(id: current_resource_id)
      when 'queue'
        PowerDashboard::QueueResource.new(current_resource_id)
      when 'scissor_lift_overview'
        PowerDashboard::ScissorLiftOverviewResource.new
      end
    end

    def allowed_organization(organization_id)
      organization = Organization.find_by(id: organization_id)
      return if organization.blank? || !organization_allowed?(organization)

      organization
    end
  end
end

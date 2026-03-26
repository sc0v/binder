# frozen_string_literal: true

module DashboardHelper
  STEP_LABELS = {
    %w[checkout tools] => 'Scan Tools',
    %w[checkin tools] => 'Scan Tools',
    %w[checkout participant] => 'Scan Borrower',
    %w[lift participant] => 'Scan Borrower',
    %w[queue participant] => 'Scan Borrower',
    %w[checkout organization] => 'Select Organization',
    %w[lift organization] => 'Select Organization',
    %w[queue organization] => 'Select Organization',
    %w[queue queue_type] => 'Select Queue Type',
    %w[queue queue_action] => 'Select Queue Action',
    %w[queue queue_source] => 'Select Source',
    %w[queue queue_message] => 'Enter Message',
    %w[queue queue_current] => 'Current Queue',
    %w[lift lift_action] => 'Select Lift Action',
    %w[lift renew_hours] => 'Select Renewal Hours',
    %w[lift renew_custom] => 'Custom Renewal Hours',
    %w[lift lift_current] => 'Current Lifts',
    %w[lookup lookup] => 'Lookup',
    %w[lookup result] => 'Lookup Result'
  }.freeze

  def dashboard_h1(flow_kind, step, flow = {})
    return 'Dashboard' if flow_kind.blank?

    "#{flow_kind.to_s.titleize}: #{dashboard_step_label(flow_kind, step, flow)}"
  end

  def dashboard_flow_hidden_fields(flow_params, except: [])
    return if flow_params.blank?

    keys_to_skip = Array(except).map(&:to_s)
    safe_join(
      flow_params.except(*keys_to_skip).map { |k, v| hidden_field_tag(k, v) }
    )
  end

  def dashboard_tool_state(tool)
    tool.checked_out? ? 'Checked out' : 'Checked in'
  end

  def dashboard_tool_state_class(tool)
    tool.checked_out? ? 'power-item-unavailable' : 'power-item-available'
  end

  def current_resource_config(resource)
    title =
      resource&.try(:formatted_name) || resource&.try(:name) ||
        'Current Resource'
    config = { title:, link: nil, partial: nil, locals: {} }
    apply_resource_display_config(config, resource)
    config
  end

  def lift_overview_status(lift)
    checkout = lift.current_checkout
    if checkout&.due_at.present? && checkout.due_at < Time.zone.now
      return %w[Overdue power-item-overdue]
    end
    return 'Checked out', 'power-item-unavailable' if lift.checked_out?

    %w[Available power-item-available]
  end

  def lift_overview_org_label(checkout)
    organization = checkout&.organization
    return if organization.blank?

    organization.short_name.presence || organization.name
  end

  def lift_overview_due_label(checkout)
    return if checkout&.due_at.blank?

    prefix = checkout.due_at < Time.zone.now ? 'overdue by' : 'due in'
    "#{prefix} #{time_ago_in_words(checkout.due_at)}"
  end

  def receipt_line_html(line)
    return receipt_list_html(line) if line[:list].present?

    content_tag(:p) do
      safe_join(["#{line[:label]}: ", content_tag(:strong, line[:value])])
    end
  end

  private

  def apply_resource_display_config(config, resource)
    case resource
    when Participant
      config.merge!(
        partial: 'shared/resources/participant',
        locals: {
          participant: resource
        },
        link: resource
      )
    when Organization
      config.merge!(
        partial: 'shared/resources/organization',
        locals: {
          organization: resource
        },
        link: resource
      )
    when Tool
      config.merge!(
        partial: 'shared/resources/tool',
        locals: {
          tool: resource
        },
        link: resource
      )
    when ScissorLift
      config.merge!(
        partial: 'shared/resources/scissor_lift',
        locals: {
          lift: resource
        },
        link: resource
      )
    when Dashboard::QueueResource
      config.merge!(queue_resource_display(resource))
    when Dashboard::ScissorLiftOverviewResource
      config.merge!(lift_overview_display(resource))
    end
  end

  def queue_resource_display(resource)
    link = resource.path.presence
    {
      title: resource.queue_type.to_s.titleize,
      partial: 'shared/resources/queue',
      locals: {
        queue: resource
      },
      link:
    }
  end

  def lift_overview_display(resource)
    {
      title: 'Scissor Lifts Overview',
      partial: 'shared/resources/scissor_lifts_overview',
      locals: {
        overview: resource
      },
      link: resource.path
    }
  end

  def receipt_list_html(line)
    items =
      line[:list].map do |item|
        if item.is_a?(Hash)
          content_tag(:li, item[:label], class: item[:status_class])
        else
          content_tag(:li, item)
        end
      end
    safe_join(
      [
        content_tag(:p) { content_tag(:strong, "#{line[:label]}:") },
        content_tag(:ul) { safe_join(items) }
      ]
    )
  end

  def dashboard_step_label(flow_kind, step, flow)
    key = [flow_kind.to_s, step.to_s]
    if key == %w[lift scissor_lift]
      return(
        (
          if %w[renew checkin].include?(flow['lift_action'])
            'Select Checked Out Lift'
          else
            'Select Lift'
          end
        )
      )
    end

    STEP_LABELS[key] || step.to_s.humanize.presence || 'Step'
  end
end

# frozen_string_literal: true

module PowerDashboardHelper
  def current_resource_config(resource)
    title = resource&.try(:formatted_name) || resource&.try(:name) || 'Current Resource'
    config = { title: title, link: nil, partial: nil, locals: {} }

    case resource
    when Participant
      config[:partial] = 'power_dashboard/resources/participant'
      config[:locals] = { participant: resource }
      config[:link] = resource
    when Organization
      config[:partial] = 'power_dashboard/resources/organization'
      config[:locals] = { organization: resource }
      config[:link] = resource
    when Tool
      config[:partial] = 'power_dashboard/resources/tool'
      config[:locals] = { tool: resource }
      config[:link] = resource
    when ScissorLift
      config[:partial] = 'power_dashboard/resources/scissor_lift'
      config[:locals] = { lift: resource }
      config[:link] = resource
    when PowerDashboard::QueueResource
      config[:partial] = 'power_dashboard/resources/queue'
      config[:locals] = { queue: resource }
      config[:link] = resource.path if resource.path.present?
    when PowerDashboard::ScissorLiftOverviewResource
      config[:partial] = 'power_dashboard/resources/scissor_lifts_overview'
      config[:locals] = { overview: resource }
      config[:link] = resource.path
    end

    config
  end

  def lift_overview_status(lift)
    checkout = lift.current_checkout
    overdue = checkout&.due_at.present? && checkout.due_at < Time.zone.now

    return ['Overdue', 'power-item-overdue'] if overdue
    return ['Checked out', 'power-item-unavailable'] if lift.is_checked_out?

    ['Available', 'power-item-available']
  end

  def lift_overview_org_label(checkout)
    organization = checkout&.organization
    return if organization.blank?

    organization.short_name.presence || organization.name
  end

  def lift_overview_due_label(checkout)
    return if checkout&.due_at.blank?

    if checkout.due_at < Time.zone.now
      "overdue by #{time_ago_in_words(checkout.due_at)}"
    else
      "due in #{time_ago_in_words(checkout.due_at)}"
    end
  end

  def receipt_line_html(line)
    if line[:list].present?
      items = line[:list].map do |item|
        if item.is_a?(Hash)
          content_tag(:li, item[:label], class: item[:status_class])
        else
          content_tag(:li, item)
        end
      end

      safe_join([
        content_tag(:p) { content_tag(:strong, "#{line[:label]}:") },
        content_tag(:ul) { safe_join(items) }
      ])
    else
      content_tag(:p) do
        safe_join([("#{line[:label]}: "), content_tag(:strong, line[:value])])
      end
    end
  end
end

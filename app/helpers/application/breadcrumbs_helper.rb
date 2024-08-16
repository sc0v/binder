# frozen_string_literal: true
module Application::BreadcrumbsHelper
  # Breadcrumbs
  #
  # Construct breadcrumbs in views dynamically. e.g.:
  #   update_breadcrumbs(add: link_to('Queues', queues_path))
  #   update_breadcrumbs(add: "Electrical")
  # will generate:
  #   Spring Carnival › Binder › Queues › Electrical
  def breadcrumbs
    content_for :breadcrumbs
  end

  def update_breadcrumbs(add: [], sep: '&nbsp;›&nbsp;')
    unless content_for? :breadcrumbs
      content_for :breadcrumbs do
        default_breadcrumbs(sep)
      end
    end

    return if add.blank?

    content_for(:breadcrumbs, sanitize(Array(add).join(sep).prepend(sep)))
  end

  private

  def default_breadcrumbs(sep)
    sanitize([link_to('Spring Carnival Binder', root_url)].join(sep))
  end
end

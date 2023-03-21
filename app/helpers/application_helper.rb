# frozen_string_literal: true

module ApplicationHelper
  # Document Title
  #
  # Construct document title in views dynamically. e.g.:
  #   update_document_title(add: "Queues")
  #   update_document_title(add: "Electrical")
  # will generate:
  #   Electrical - Queues - Binder - Spring Carnival - Carnegie Mellon University
  def document_title
    update_document_title unless content_for? :document_title
    content_for :document_title
  end

  def update_document_title(add: [], sep: ' - ')
    document_title = Array(add).join(sep)
    document_title += sep unless document_title.empty?

    document_title +=
      if content_for? :document_title
        content_for :document_title
      else
        ['Binder', 'Spring Carnival', 'Carnegie Mellon University'].join(sep)
      end

    content_for(:document_title, document_title, flush: true)
  end

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

  def flash_css_class(name)
    "flash-#{name} " +
      case name
      when 'notice'
        'green invert'
      when 'alert'
        'red invert'
      else
        'gold'
      end
  end

  private

  def default_breadcrumbs(sep)
    sanitize(
      [
        link_to('Spring Carnival', spring_carnival_url),
        link_to('Binder', root_url)
      ].join(sep)
    )
  end
end

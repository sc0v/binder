# frozen_string_literal: true
module Application::DocumentTitleHelper
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
end

# frozen_string_literal: true
module Application::NavigationHelper # rubocop:disable Metrics/ModuleLength
  # Navigation
  #
  # Construct navigation link structures and allow views to flag the active
  # element, e.g.:
  #   nav(active: 'organizations')
  #   nav
  def nav(active: nil)
    content_for :navigation do
      sanitize(nav_section(items: nav_items, active: active).join)
    end
  end

  private

  def nav_section(items: [], active: nil)
    items.map do |item|
      item[:class] = item[:class].to_a.append('active') if item[:key] == active
      next if item[:can].blank?
      next unless can?(item[:can][:action], item[:can][:subject])

      content_tag(
        :li,
        nav_link(item: item, active: active),
        class: item[:class]
      )
    end
  end

  def nav_link(item:, active:)
    children =
      content_tag(
        :ul,
        sanitize(nav_section(items: item[:children], active: active).join)
      ) if item[:children].present?

    link_to(item[:label], item[:url]) +
      (children unless children == content_tag(:ul))
  end

  def nav_items # rubocop:disable Metrics/MethodLength
    [
      {
        label: 'Organizations',
        url: organizations_path,
        key: 'organizations',
        can: {
          action: :index,
          subject: Organization
        }
      },
      {
        label: 'People',
        url: participants_path,
        key: 'participants',
        can: {
          action: :index,
          subject: Participant
        }
      },
      {
        label: 'Tools',
        url: tools_path,
        key: 'tools',
        can: {
          action: :index,
          subject: Tool
        }
      },
      {
        label: 'Store',
        url: store_path,
        key: 'store',
        can: {
          action: :index,
          subject: StoreItem
        }
      },
      {
        label: 'Queues',
        url: queues_path,
        key: 'queues',
        can: {
          action: :index,
          subject: QueuesController
        }
      },
      {
        label: 'FAQ',
        url: faq_index_path,
        key: 'faq',
        can: {
          action: :index,
          subject: FAQ
        },
        children: [
          {
            label: 'Add Question',
            url: new_faq_path,
            key: 'new_faq',
            can: {
              action: :create,
              subject: FAQ
            }
          }
        ]
      },
      {
        label: 'Applets',
        url: applets_path,
        key: 'applets',
        class: ['secondary'],
        can: {
          action: :index,
          subject: AppletsController
        },
        children: [
          {
            label: 'PPE Distribution',
            url: ppe_distribution_path,
            key: 'ppe_distribution',
            can: {
              action: :create,
              subject: Applets::PPEDistributionController
            }
          }
        ]
      },
      {
        label: 'Charges',
        url: charges_path,
        key: 'charges',
        class: ['secondary'],
        can: {
          action: :index,
          subject: Charge
        }
      },
      {
        label: 'Notes',
        url: notes_path,
        key: 'notes',
        class: ['secondary'],
        can: {
          action: :index,
          subject: Note
        },
        children: [
          {
            label: 'New Note',
            url: new_note_path,
            key: 'new_note',
            can: {
              action: :create,
              subject: Note
            }
          }
        ]
      },
      {
        label: 'Shifts',
        url: shifts_path,
        key: 'shifts',
        class: ['secondary'],
        can: {
          action: :index,
          subject: Shift
        }
      },
      {
        label: 'Tasks',
        url: tasks_path,
        key: 'tasks',
        class: ['secondary'],
        can: {
          action: :index,
          subject: Task
        },
        children: [
          {
            label: 'New Task',
            url: new_task_path,
            key: 'new_task',
            can: {
              action: :create,
              subject: Task
            }
          }
        ]
      }
    ]
  end
end

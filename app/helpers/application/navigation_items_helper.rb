# frozen_string_literal: true

# Binder's navigation items, drawn by Application::NavigationHelper. Each
# item: label, url, key, can: [action, subject], and optional secondary
# (menu only) and children.
#
# Six tabs, then the menu-only items. The home page is the committee's
# operations hub, so it isn't in the list; the site name links to it.
# Actions such as New Task stay on their pages: an item with a sub-list makes
# the menu start open beside the page.
module Application::NavigationItemsHelper
  private

  def nav_tree
    [
      nav_organizations, nav_people, nav_tools,
      { label: 'Store', url: store_path, key: 'store', can: [:index, StoreItem] },
      nav_queues,
      { label: 'FAQ', url: faq_index_path, key: 'faq', can: [:index, FAQ] },
      nav_applets,
      { label: 'Notes', url: notes_path, key: 'notes', secondary: true, can: [:index, Note] },
      { label: 'Tasks', url: tasks_path, key: 'tasks', secondary: true, can: [:index, Task] },
      # Shifts belong to people (coordinators' trailer shifts) and to
      # organizations, so they sit with the operations items instead of
      # under either
      { label: 'Shifts', url: shifts_path, key: 'shifts', secondary: true, can: [:index, Shift] }
    ]
  end

  def nav_organizations
    {
      label: 'Organizations', url: organizations_path, key: 'organizations',
      can: [:index, Organization],
      children: [
        {
          label: 'Build Progress', url: organization_build_statuses_path,
          key: 'build_progress', can: [:manage, OrganizationBuildStatus]
        },
        { label: 'Charges', url: charges_path, key: 'charges', can: [:index, Charge] },
        { label: 'Downtime', url: downtime_path, key: 'downtime', can: [:index, OrganizationTimelineEntry] }
      ]
    }
  end

  def nav_people
    { label: 'People', url: participants_path, key: 'participants', can: [:index, Participant] }
  end

  def nav_tools
    {
      label: 'Tools', url: tools_path, key: 'tools', can: [:index, Tool],
      children: [
        { label: 'Scissor Lifts', url: scissor_lifts_path, key: 'scissor_lifts', can: [:index, ScissorLift] }
      ]
    }
  end

  def nav_queues
    {
      label: 'Queues', url: queues_path, key: 'queues', can: [:queues, OrganizationTimelineEntry],
      children: [
        { label: 'Structural', url: structural_path, key: 'structural', can: [:structural, OrganizationTimelineEntry] },
        { label: 'Electrical', url: electrical_path, key: 'electrical', can: [:electrical, OrganizationTimelineEntry] },
        { label: 'History', url: queue_history_path, key: 'queue_history', can: [:history, OrganizationTimelineEntry] }
      ]
    }
  end

  def nav_applets
    {
      label: 'Applets', url: applets_path, key: 'applets', secondary: true,
      can: [:index, AppletsController],
      children: [
        {
          label: 'PPE Distribution', url: ppe_distribution_path,
          key: 'ppe_distribution', can: [:create, Applets::PPEDistributionController]
        },
        {
          label: 'PPE Collection', url: ppe_collection_path,
          key: 'ppe_collection', can: [:create, Applets::PPECollectionController]
        },
        {
          label: 'Wristband Lookup', url: wristband_lookup_path,
          key: 'wristband_lookup', can: [:index, AppletsController]
        },
        {
          label: 'Push Broadcast', url: push_broadcast_path,
          key: 'push_broadcast', can: [:manage, NotificationSubscription]
        }
      ]
    }
  end
end

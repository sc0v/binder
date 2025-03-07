require "test/sets/certification_types"
require "test/sets/certifications"
require "test/sets/charge_types"
require "test/sets/charges"
require "test/sets/checkouts"
require "test/sets/delayed_jobs"
require "test/sets/event_types"
require "test/sets/events"
require "test/sets/faq"
require "test/sets/memberships"
require "test/sets/notes"
require "test/sets/organization_aliases"
require "test/sets/organization_build_statuses"
require "test/sets/organization_build_steps"
require "test/sets/organization_categories"
require "test/sets/organization_status_types"
require "test/sets/organization_timeline_entries"
require "test/sets/organization_timeline_entry_types"
require "test/sets/organizations"
require "test/sets/participants"
require "test/sets/scissor_lift_checkouts"
require "test/sets/scissor_lifts"
require "test/sets/shift_participants"
require "test/sets/shift_types"
require "test/sets/shifts"
require "test/sets/store_items"
require "test/sets/store_purchases"
require "test/sets/tasks"
require "test/sets/tool_inventories"
require "test/sets/tool_inventory_tools"
require "test/sets/tool_type_certifications"
require "test/sets/tool_types"
require "test/sets/tools"

module Contexts 
    include Contexts::CertificationTypes
    include Contexts::Certifications
    include Contexts::ChargeTypes
    include Contexts::Charges
    include Contexts::Checkouts
    include Contexts::DelayedJobs
    include Contexts::EventTypes
    include Contexts::Events
    include Contexts::Faq
    include Contexts::Memberships
    include Contexts::Notes
    include Contexts::OrganizationAliases
    include Contexts::OrganizationBuildStatuses
    include Contexts::OrganizationBuildSteps
    include Contexts::OrganizationCategories
    include Contexts::OrganizationStatusTypes
    include Contexts::OrganizationTimelineEntries
    include Contexts::OrganizationTimelineEntryTypes
    include Contexts::Organizations
    include Contexts::Participants
    include Contexts::ScissorLiftCheckouts
    include Contexts::ScissorLifts
    include Contexts::ShiftParticipants
    include Contexts::ShiftTypes
    include Contexts::Shifts
    include Contexts::StoreItems
    include Contexts::StorePurchases
    include Contexts::Tasks
    include Contexts::ToolInventories
    include Contexts::ToolInventoryTools
    include Contexts::ToolTypeCertifications
    include Contexts::ToolTypes
    include Contexts::Tools

    def create_all
        create_certification_types
        create_certifications
        create_charge_types
        create_charges
        create_checkouts
        create_delayed_jobs
        create_event_types
        create_events
        create_faq
        create_memberships
        create_notes
        create_organization_aliases
        create_organization_build_statuses
        create_organization_build_steps
        create_organization_categories
        create_organization_status_types
        create_organization_timeline_entries
        create_organization_timeline_entry_types
        create_organizations
        create_participants
        create_scissor_lift_checkouts
        create_scissor_lifts
        create_shift_participants
        create_shift_types
        create_shifts
        create_store_items
        create_store_purchases
        create_tasks
        create_tool_inventories
        create_tool_inventory_tools
        create_tool_type_certifications
        create_tool_types
        create_tools
    end

    def destroy_all
        destroy_certification_types
        destroy_certifications
        destroy_charge_types
        destroy_charges
        destroy_checkouts
        destroy_delayed_jobs
        destroy_event_types
        destroy_events
        destroy_faq
        destroy_memberships
        destroy_notes
        destroy_organization_aliases
        destroy_organization_build_statuses
        destroy_organization_build_steps
        destroy_organization_categories
        destroy_organization_status_types
        destroy_organization_timeline_entries
        destroy_organization_timeline_entry_types
        destroy_organizations
        destroy_participants
        destroy_scissor_lift_checkouts
        destroy_scissor_lifts
        destroy_shift_participants
        destroy_shift_types
        destroy_shifts
        destroy_store_items
        destroy_store_purchases
        destroy_tasks
        destroy_tool_inventories
        destroy_tool_inventory_tools
        destroy_tool_type_certifications
        destroy_tool_types
        destroy_tools
    end
end

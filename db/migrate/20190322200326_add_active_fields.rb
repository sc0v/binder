class AddActiveFields < ActiveRecord::Migration
  def change
    add_column :certification_types, :active, :boolean, default: true
    add_column :certifications, :active, :boolean, default: true
    add_column :charge_types, :active, :boolean, default: true
    add_column :charges, :active, :boolean, default: true
    add_column :checkouts, :active, :boolean, default: true
    add_column :delayed_jobs, :active, :boolean, default: true
    add_column :event_types, :active, :boolean, default: true
    add_column :events, :active, :boolean, default: true
    add_column :faqs, :active, :boolean, default: true
    add_column :memberships, :active, :boolean, default: true
    add_column :organization_aliases, :active, :boolean, default: true
    add_column :organization_categories, :active, :boolean, default: true
    add_column :organization_status_types, :active, :boolean, default: true
    add_column :organization_statuses, :active, :boolean, default: true
    add_column :organization_timeline_entries, :active, :boolean, default: true
    add_column :organization_timeline_entry_types, :active, :boolean, default: true
    add_column :organizations, :active, :boolean, default: true
    add_column :participants, :active, :boolean, default: true
    add_column :roles, :active, :boolean, default: true
    add_column :shift_participants, :active, :boolean, default: true
    add_column :shift_types, :active, :boolean, default: true
    add_column :shifts, :active, :boolean, default: true
    add_column :store_items, :active, :boolean, default: true
    add_column :store_purchases, :active, :boolean, default: true
    add_column :tasks, :active, :boolean, default: true
    add_column :tool_type_certifications, :active, :boolean, default: true
    add_column :tool_types, :active, :boolean, default: true
    add_column :tools, :active, :boolean, default: true
    add_column :users, :active, :boolean, default: true
    add_column :users_roles, :active, :boolean, default: true
  end
end
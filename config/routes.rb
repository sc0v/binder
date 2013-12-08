Boa::Application.routes.draw do

  resources :task_categories
  resources :contact_lists
  resources :charges
  resources :checkouts
  resources :contact_lists
  resources :documents
  resources :faqs
  resources :memberships, :except => [:index, :show, :destroy]
  resources :organizations
  resources :participants
  resources :shift_participants
  resources :shifts
  resources :tasks
  resources :tools

  # organization alias
  match "new_organization_alias/:id" => "organization_aliases#new_alias", :as => :new_organization_alias
  match "create_organization_alias" => "organization_aliases#create_alias", :as => :create_organization_alias
  match "remove_organization_alias/:id" => "organization_aliases#destroy_alias", :as => :remove_organization_alias

  # shifts - all types separated
  match "sec_shifts" => "shifts#sec_shifts", :as => :sec_shifts_index
  match "coord_shifts" => "shifts#coord_shifts", :as => :coord_shifts_index

  # shift clock in / clock out
  match "new_shift_clock_in/:id" => "shift_participants#new_shift_clock_in", :as => :new_shift_clock_in
  match "new_shift_clock_out/:id" => "shift_participants#new_shift_clock_out", :as => :new_shift_clock_out

  match "create_shift_clock_in" => "shift_participants#create_shift_clock_in", :as => :create_shift_clock_in
  match "create_shift_clock_out" => "shift_participants#create_shift_clock_out", :as => :create_shift_clock_out

  # tool check in / check out
  match "new_tool_checkin" => "checkouts#new_tool_checkin", :as => :new_tool_checkin
  match "new_tool_checkout" => "checkouts#new_tool_checkout", :as => :new_tool_checkout

  match "new_tool_checkin/:tool_id" => "checkouts#new_tool_checkin", :as => :new_tool_checkin_given_tool
  match "new_tool_checkout/:tool_id" => "checkouts#new_tool_checkout", :as => :new_tool_checkout_given_tool

  match "create_tool_checkin" => "checkouts#create_tool_checkin", :as => :create_tool_checkin
  match "create_tool_checkout" => "checkouts#create_tool_checkout", :as => :create_tool_checkout
  match "create_tool_checkout_organization_selected" => "checkouts#create_tool_checkout_organization_selected", :as => :create_tool_checkout_organization_selected

  # tools - hardhats and radios taken out
  match "hardhats" => "tools#hardhats_only", :as => :hardhats_index
  match "radios" => "tools#radios_only", :as => :radios_index

  # user creation
  match "new_user_and_participant" => "participants#new_user_and_participant", :as => :new_user_and_participant
  match "create_participant_user" => "checkouts#create_tool_checkin", :as => :create_tool_checkin
  match "add_participant_memberships" => "memberships#add_participant_memberships", :as => :add_participant_memberships
  match "add_participant_memberships/:participant_id_to_add_to" => "memberships#add_participant_memberships", :as => :add_participant_memberships_given_participant
  match "create_participant_memberships" => "memberships#create_participant_memberships", :as => :create_participant_memberships

  match "new_participant_membership" => "memberships#new_participant_membership", :as => :new_participant_membership
  match "create_participant_membership" => "memberships#create_participant_membership", :as => :create_participant_membership

  # static pages
  match "milestones" => "home#milestones", :as => "milestones"
  match "esp" => "home#esp", :as => "esp"

  match "search" => "home#search", :as => "search"
  match "home" => "home#home", :as => "home"

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users
  resources :users
end
Trailerapp::Application.routes.draw do

  resources :contact_lists
  resources :documents
  resources :faqs
  resources :memberships, :except => [:index, :show, :destroy]
  resources :organizations
  resources :charges
  resources :participants
  resources :shifts
  resources :shift_participants, :only => [:destroy]
  resources :task_categories
  resources :tasks
  resources :tools
  resources :checkouts

  # organization alias
  match "new_organization_alias/:id" => "organization_aliases#new_alias", :as => :new_organization_alias, via: [:get, :post]
  match "create_organization_alias" => "organization_aliases#create_alias", :as => :create_organization_alias, via: [:get, :post]
  match "remove_organization_alias/:id" => "organization_aliases#destroy_alias", :as => :remove_organization_alias, via: [:get, :post]

  # shifts - all types separated
  match "sec_shifts" => "shifts#sec_shifts", :as => :sec_shifts_index, via: [:get, :post]
  match "coord_shifts" => "shifts#coord_shifts", :as => :coord_shifts_index, via: [:get, :post]

  # shift clock in / clock out
  match "new_shift_clock_in/:id" => "shift_participants#new_shift_clock_in", :as => :new_shift_clock_in, via: [:get, :post]
  match "new_shift_clock_out/:id" => "shift_participants#new_shift_clock_out", :as => :new_shift_clock_out, via: [:get, :post]

  match "create_shift_clock_in" => "shift_participants#create_shift_clock_in", :as => :create_shift_clock_in, via: [:get, :post]
  match "create_shift_clock_out" => "shift_participants#create_shift_clock_out", :as => :create_shift_clock_out, via: [:get, :post]

  # tool check in / check out
  match "new_tool_checkin" => "checkouts#new_tool_checkin", :as => :new_tool_checkin, via: [:get, :post]
  match "new_tool_checkout" => "checkouts#new_tool_checkout", :as => :new_tool_checkout, via: [:get, :post]

  match "new_tool_checkin/:tool_id" => "checkouts#new_tool_checkin", :as => :new_tool_checkin_given_tool, via: [:get, :post]
  match "new_tool_checkout/:tool_id" => "checkouts#new_tool_checkout", :as => :new_tool_checkout_given_tool, via: [:get, :post]

  match "create_tool_checkin" => "checkouts#create_tool_checkin", :as => :create_tool_checkin, via: [:get, :post]
  match "create_tool_checkout" => "checkouts#create_tool_checkout", :as => :create_tool_checkout, via: [:get, :post]
  match "create_tool_checkout_organization_selected" => "checkouts#create_tool_checkout_organization_selected", :as => :create_tool_checkout_organization_selected, via: [:get, :post]

  # tools - hardhats and radios taken out
  match "hardhats" => "tools#hardhats_only", :as => :hardhats_index, via: [:get, :post]
  match "radios" => "tools#radios_only", :as => :radios_index, via: [:get, :post]

  # user creation
  match "new_user_and_participant" => "participants#new_user_and_participant", :as => :new_user_and_participant, via: [:get, :post]
  # match "create_participant_user" => "checkouts#create_tool_checkin", :as => :create_tool_checkin, via: [:get, :post]
  match "add_participant_memberships" => "memberships#add_participant_memberships", :as => :add_participant_memberships, via: [:get, :post]
  match "add_participant_memberships/:participant_id_to_add_to" => "memberships#add_participant_memberships", :as => :add_participant_memberships_given_participant, via: [:get, :post]
  match "create_participant_memberships" => "memberships#create_participant_memberships", :as => :create_participant_memberships, via: [:get, :post]

  match "new_participant_membership" => "memberships#new_participant_membership", :as => :new_participant_membership, via: [:get, :post]
  match "create_participant_membership" => "memberships#create_participant_membership", :as => :create_participant_membership, via: [:get, :post]

  # static pages
  match "milestones" => "home#milestones", :as => "milestones", via: :get
  match "esp" => "home#esp", :as => "esp", via: :get

  match "search" => "home#search", :as => "search", via: [:get, :post]
  match "home" => "home#home", :as => "home", via: :get

  root :to => "home#index"

  devise_for :users
  resources :users
end


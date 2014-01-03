Trailerapp::Application.routes.draw do

  resources :documents
  resources :faqs
  resources :memberships, :except => [:index, :show, :destroy]
  resources :organizations do
    resources :aliases, :controller => :organization_aliases, :shallow => true, :only => [:create, :new, :destroy]
    resources :statuses, :controller => :organization_statuses, :as => :organization_statuses
    resources :downtime_entries
    resources :participants, :only => [:index]
    resources :shifts, :only => [:index]
    resources :tools, :only => [:index]
    resources :charges, :only => [:index]
  end
  resources :charges
  resources :participants
  resources :shifts do
    resources :participants, :controller => :shift_participants, :only => [:new, :create]
  end
  resources :shift_participants, :only => [:destroy, :update]
  resources :tasks
  resources :tools
  resources :checkouts

  # tool check in / check out
  match "new_tool_checkin" => "checkouts#new_tool_checkin", :as => :new_tool_checkin, via: [:get, :post]
  match "new_tool_checkout" => "checkouts#new_tool_checkout", :as => :new_tool_checkout, via: [:get, :post]

  match "new_tool_checkin/:tool_id" => "checkouts#new_tool_checkin", :as => :new_tool_checkin_given_tool, via: [:get, :post]
  match "new_tool_checkout/:tool_id" => "checkouts#new_tool_checkout", :as => :new_tool_checkout_given_tool, via: [:get, :post]

  match "create_tool_checkin" => "checkouts#create_tool_checkin", :as => :create_tool_checkin, via: [:get, :post]
  match "create_tool_checkout" => "checkouts#create_tool_checkout", :as => :create_tool_checkout, via: [:get, :post]
  match "create_tool_checkout_organization_selected" => "checkouts#create_tool_checkout_organization_selected", :as => :create_tool_checkout_organization_selected, via: [:get, :post]

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


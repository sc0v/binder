Trailerapp::Application.routes.draw do

  resources :documents
  resources :faqs, :except => [:show]
  resources :memberships, :except => [:index, :show, :destroy]
  resources :organizations do
    resources :aliases, :controller => :organization_aliases, :shallow => true, :only => [:create, :new, :destroy]
    resources :statuses, :controller => :organization_statuses, :as => :organization_statuses
    resources :downtime_entries
    resources :participants, :only => [:index]
    resources :shifts, :only => [:index]
    resources :tools, :only => [:index]
    resources :charges, :only => [:index]
    get 'hardhats', on: :member
  end
  resources :charges
  resources :participants
  resources :shifts do
    resources :participants, :controller => :shift_participants, :only => [:new, :create]
  end
  resources :shift_participants, :only => [:destroy, :update]
  resources :tasks
  resources :tools do
    resources :checkouts, :only => [:new, :create, :update, :index]
  end
  resources :checkouts, :only => [:create]

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


  devise_for :users,
  :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users
end


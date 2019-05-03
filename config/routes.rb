Trailerapp::Application.routes.draw do

  get 'create_carnival', to: 'carnival_creation#show_uploader', as: :show_uploader
  get 'create_carnival/show_diff', to: 'carnival_creation#show_diff', as: :show_diff
  get 'create_carnival/show_end_index', to: 'carnival_creation#show_end_index', as: :show_end_index

  post 'create_carnival/upload_csvs', to: 'carnival_creation#upload_csvs', as: :upload_csvs
  post 'create_carnival/commit_changes', to: 'carnival_creation#commit_changes', as: :commit_changes
  post 'create_carnival/upload_optional_csvs', to: 'carnival_creation#upload_optional_csvs', as: :upload_optional_csvs

  resources :event_types
  resources :events do
     member do
      post 'approve'
    end
  end
  
  resources :faqs, :except => [:show]
  resources :organizations do
    resources :aliases, :controller => :organization_aliases, :shallow => true, :only => [:create, :new, :destroy, :index]
    resources :statuses, :controller => :organization_statuses, :as => :organization_statuses
    resources :participants, :only => [:index]
    resources :shifts, :only => [:index]
    resources :tools, :only => [:index]
    resources :charges, :only => [:index]
    get 'hardhats', on: :member
    resources :downtime, :controller => :organization_timeline_entries, :only => [:index]
    resources :memberships, :only => [:new, :create, :destroy]
  end
  resources :organization_timeline_entries, :controller => :organization_timeline_entries, :only => [:show,:edit, :create, :update, :destroy] do
    put 'end', on: :member
  end
  resources :organization_timeline_entries, :path => :downtime, :as => :downtime, :only => [:edit,:create,:update,:destroy]
  get 'downtime', to: "home#downtime"

  resources :charges do
    put 'approve', on: :member
  end

  resources :charge_types
  resources :participants do
    resources :memberships, :except => [:index, :show]
    resource :waiver, :except => [:edit, :destroy, :show, :update]
    resources :certifications, :only => [:new, :create, :destroy]
    post 'lookup', on: :collection
  end

  get 'waiver' => 'waivers#new'
  resource :waiver, :except => [:edit, :destroy, :show, :update]

  resources :shifts do
    resources :participants, :controller => :shift_participants, :only => [:new, :create, :update, :destroy]
  end
  resources :tasks do
    member do
      post 'complete'
    end
  end
  resources :tools do
    resources :checkouts, :only => [:new, :create, :update, :index] do
      post 'choose_organization', on: :collection
    end
  end

  resources :tool_types , :except => [:show]

  resources :checkouts, :only => [:create] do
    post 'checkin', on: :collection
    post 'uncheckin', on: :member
  end

  get "store" => "store/items#index"
  namespace :store do
    resources 'items' do
      post 'add_to_cart',
           on: :member,
           controller: 'purchases'
      post 'remove_from_cart',
           on: :member,
           controller: 'purchases'
    end
    resources 'purchase',
              controller: 'purchases',
              except: [:create, :new, :index] 
    scope 'cart', as: 'cart', controller: 'purchases' do
      get 'review', action: 'new'
      post 'checkout', action: 'create'
      post 'choose_organization'
    end
  
  end

  scope 'tool_cart' do
    post 'add_tool', to: 'tool_cart#add_tool', as: :tool_cart_add_tool
    post 'remove_tool', to: 'tool_cart#remove_tool', as: :tool_cart_remove_tool
    post 'remove_all', to: 'tool_cart#remove_all', as: :tool_cart_remove_all
    post 'checkout', to: 'tool_cart#checkout', as: :tool_cart_checkout
    post 'checkin', to: 'tool_cart#checkin', as: :tool_cart_checkin
    post 'swap', to: 'tool_cart#swap', as: :tool_cart_swap
  end

  # static pages
  get "milestones" => "home#milestones", :as => "milestones"

  match "search" => "home#search", :as => "search", via: [:get, :post]
  get "home" => "home#home", :as => "home"

  root :to => "home#index"

  # Custom one-offs
  get 'hardhats' => "home#hardhats", :as => "hardhats"
  get 'hardhat_return' => "home#hardhat_return", :as => "hardhat_return"
  get 'charge_overview' => "home#charge_overview", :as => "charge_overview"
  get 'structural' => "organization_timeline_entries#structural", :as => "structural"
  get 'electrical' => "organization_timeline_entries#electrical", :as => "electrical"


  devise_for :users,
  :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users

  get 'reports' => "reports#index", :as => :reports
  
  unless Rails.env.staging? or Rails.env.production?
    post 'dev_login' => "home#dev_login", :as => "dev_login"
  end
end


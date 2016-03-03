Trailerapp::Application.routes.draw do

  resources :documents
  resources :faqs, :except => [:show]
  resources :organizations do
    resources :aliases, :controller => :organization_aliases, :shallow => true, :only => [:create, :new, :destroy]
    resources :statuses, :controller => :organization_statuses, :as => :organization_statuses
    resources :participants, :only => [:index]
    resources :shifts, :only => [:index]
    resources :tools, :only => [:index]
    resources :charges, :only => [:index]
    get 'hardhats', on: :member
    resources :downtime, :controller => :organization_timeline_entries, :only => [:index]
  end
  resources :organization_timeline_entries, :controller => :organization_timeline_entries, :only => [:edit, :create, :update, :destroy] do
    put 'end', on: :member
  end
  resources :charges do
    put 'approve', on: :member
  end
  resources :participants do
    resources :memberships, :except => [:index, :show]
    resource :waiver, :except => [:edit, :destroy, :show, :update]
    post 'lookup', on: :collection
  end

  get 'waiver' => 'waivers#new'
  resource :waiver, :except => [:edit, :destroy, :show, :update]
  
  resources :shifts do
    resources :participants, :controller => :shift_participants, :only => [:new, :create, :destroy]
  end
  resources :tasks
  resources :tools do
    resources :checkouts, :only => [:new, :create, :update, :index] do
      post 'choose_organization', on: :collection
    end
  end

  resources :tool_types , :except => [:show] do
    resources :tool_waitlists, :only => [:new, :create, :destroy], :as => :waitlists do
      post 'choose_organization', on: :collection
    end
  end

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
  get 'downtime' => "home#downtime", :as => "downtime"


  devise_for :users,
  :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users

  get 'reports' => "reports#index", :as => :reports
  
  unless Rails.env.production?
    post 'dev_login' => "home#dev_login", :as => "dev_login"
  end
end


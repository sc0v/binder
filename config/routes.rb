# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  # Default route
  root to: 'welcome#index'

  # Session management
  direct :login do
    '/auth/shibboleth'
  end
  scope module: :sessions do
    get 'auth/:provider/callback', action: :create
    get 'logout', as: :logout, action: :destroy
    post 'impersonate/:participant_id', as: :impersonate, action: :impersonate
    get 'unimpersonate'
  end

  # External navigation items
  direct :spring_carnival do
    '//www.springcarnival.org'
  end
  direct :contact_email do |options|
    params = options.map { |k, v| "#{k}=#{v}" }.join('&')
    params.prepend('?') if params.present?
    "mailto:systems@springcarnival.org#{params}"
  end
  direct :gravatar do |email, size = 50|
    hash = Digest::MD5.hexdigest email
    "https://www.gravatar.com/avatar/#{hash}?d=mp&s=#{size}"
  end

  resources :event_types
  resources :events do
    member do
      post 'approve'
    end
  end

  resources :faqs, except: [:show]
  resources :organizations do
    resources :aliases, controller: :organization_aliases, shallow: true,
                        only: %i[create new destroy index]
    resources :statuses, controller: :organization_statuses, as: :organization_statuses

    resources :participants, only: [:index]

    resources :shifts, only: [:index]
    resources :tools, only: [:index]
    resources :charges, only: [:index]
    get 'hardhats', on: :member
    resources :downtime, controller: :organization_timeline_entries, only: [:index]
    resources :memberships, only: %i[new create destroy]
  end
  resources :organization_timeline_entries, controller: :organization_timeline_entries,
                                            only: %i[show edit create update destroy] do
    put 'end', on: :member
  end
  resources :organization_timeline_entries, path: :downtime, as: :downtime,
                                            only: %i[edit create update destroy]
  get 'downtime', to: 'home#downtime'

  resources :charges do
    put 'approve', on: :member
  end

  resources :charge_types
  resources :participants, except: :new do
    get 'search', on: :collection

    resources :memberships, except: %i[index show]
    resource :waiver, except: %i[edit destroy show update]
    resources :certifications, only: %i[new create destroy]
    post 'lookup', on: :collection
  end

  # Direct link to a participant's own resource
  get 'profile', to: 'participants#show', as: :profile

  get 'waiver' => 'waivers#new'
  resource :waiver, except: %i[edit destroy show update]

  resources :shifts do
    resources :participants, controller: :shift_participants, only: %i[new create update destroy]
  end
  resources :tasks do
    member do
      post 'complete'
    end
  end
  resources :tools do
    resources :checkouts, only: %i[new create update index] do
      post 'choose_organization', on: :collection
    end
  end

  resources :tool_types, except: [:show]

  resources :checkouts, only: [:create] do
    post 'checkin', on: :collection
    post 'uncheckin', on: :member
  end

  get 'store' => 'store/items#index'
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
              except: %i[create new index]
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
  get 'milestones' => 'home#milestones', :as => 'milestones'

  match 'search' => 'home#search', :as => 'search', via: %i[get post]
  get 'home' => 'home#home', :as => 'home'

  # Custom one-offs
  get 'hardhats' => 'home#hardhats', :as => 'hardhats'
  get 'hardhat_return' => 'home#hardhat_return', :as => 'hardhat_return'
  get 'charge_overview' => 'home#charge_overview', :as => 'charge_overview'
  get 'structural' => 'organization_timeline_entries#structural', :as => 'structural'
  get 'electrical' => 'organization_timeline_entries#electrical', :as => 'electrical'

  resources :users
end

# frozen_string_literal: true

Rails.application.routes.draw do
  # Default route
  root to: 'welcome#index'

  # Session management
  # Sign In is /login, the developer sign-in page, in development and test,
  # and single sign-on everywhere else (see DevSessionsController)
  direct :login do
    Rails.env.local? ? '/login' : '/auth/saml'
  end
  scope module: :sessions do
    post 'auth/:provider/callback', action: :create
    get 'logout', as: :logout, action: :destroy
    post 'impersonate/:participant_id', as: :impersonate, action: :impersonate
    get 'unimpersonate'
  end
  # Developer sign-in, at the same addresses as the real one: drawn only in
  # development and test (DevSessionsController refuses everywhere else too).
  # GET /logout is the real sign-out everywhere; the developer page's Signed
  # Out posts to /logout.
  if Rails.env.local?
    match 'login', to: 'dev_sessions#new', as: :dev_login, via: %i[get post]
    post 'login/:participant_id', to: 'dev_sessions#create', as: :dev_login_as
    post 'logout', to: 'dev_sessions#destroy', as: :dev_logout
  end
  direct :login_redirect do |origin|
    origin || root_url
  end

  # External navigation items
  direct :spring_carnival do
    '//www.springcarnival.org'
  end
  direct :contact_email do |options|
    params = options.map { |k, v| "#{k}=#{v}" }.join('&')
    params.presence&.prepend('?')
    "mailto:systems@springcarnival.org#{params}"
  end
  direct :waiver_questions_email do |options|
    params = options.map { |k, v| "#{k}=#{v}" }.join('&')
    params.presence&.prepend('?')
    "mailto:slice@andrew.cmu.edu#{params}"
  end

  # Applets/Workflows
  get 'applets', to: 'applets#index', as: :applets
  get 'ppe-distribution', to: 'applets/ppe_distribution#index'
  get 'ppe-collection', to: 'applets/ppe_collection#index'
  get 'wristband-lookup',
      to: 'applets/wristband_lookup#index',
      as: :wristband_lookup
  get 'push-broadcast', to: 'applets/push_broadcast#index', as: :push_broadcast
  post 'push-broadcast', to: 'applets/push_broadcast#create'

  # FAQ
  # n.b.: FAQ is uncountable (like sheep). The Rails convention is to have:
  #   faq_path -> show & faq_index_path -> index
  # So even though we do not have a show, we want to minimize antipatterns.
  resources :faq, except: [:show]

  # Notes
  # resources :notes
  resources :notes, only: %i[index show create new edit update] do
    member do
      patch :archive
      patch :unarchive
    end
    collection { get :archived }
  end

  # Participant Safety Briefing
  get 'safety-briefing',
      to: 'participants/safety_briefings#show',
      as: :safety_briefing
  namespace 'people/:id', module: :participants, as: :participant do
    resource :safety_briefing, only: [], path: 'safety-briefing' do
      member do
        get :show
        patch :update
      end
    end
  end

  # Participant Waivers
  get 'waiver', to: 'participants/waivers#show', as: :waiver
  namespace 'people/:id', module: :participants, as: :participant do
    resource :waiver, only: [] do
      member do
        get :show
        patch :update
      end
    end
  end

  # SCC Help Queues
  # resources :queues

  # Tools
  resources :tools do
    member { get :remove, to: 'tools/checkouts#remove' }
    collection do
      get 'org-summary', to: 'tools/org_summary#show', as: :org_summary
      post 'add-checkin', to: 'tools/checkin#create', as: :add_checkin
      post :checkin, to: 'tools/checkin#update'
      post :add, to: 'tools/checkouts#add'
      post 'checkout-participant', to: 'tools/checkouts#participant', as: :checkout_participant
      get :checkout, to: 'tools/checkouts#new'
      post :checkout, to: 'tools/checkouts#create'
      post :checkin, to: 'tools/checkouts#update'
      get :reset, to: 'tools/checkouts#reset'
    end
    resources :checkouts, controller: 'tools/checkouts'
  end

  # Tool types
  resources :tool_types, path: 'tool-types'

  # Tool Inventory
  resources :tool_inventory, path: 'inventory', only: [:show] do
    resources :tool_inventory_tools, path: 'tools', only: %i[new create index destroy]
    post :complete, to: 'tool_inventory#complete'
  end
  get 'inventory', to: 'tool_inventory#show', as: :inventory

  # Scissor Lifts
  resources :scissor_lifts, path: 'scissor-lifts', only: %i[index show] do
    member { get :remove, to: 'scissor_lift_checkouts#remove' }
    collection do
      post :add, to: 'scissor_lift_checkouts#add'
      get :reset, to: 'scissor_lift_checkouts#reset'
      post :checkout, to: 'scissor_lift_checkouts#checkout'
      post :checkin, to: 'scissor_lift_checkouts#checkin'
      post :renew, to: 'scissor_lift_checkouts#renew'
    end
  end
  resources :scissor_lift_checkouts, path: 'scissor-lift-checkouts', only: [:index]

  # Downtime Index (other methods are organizations/downtime)
  get 'downtime', to: 'downtime#downtime'
  post 'toggle-downtime', to: 'downtime#toggle', as: :toggle_downtime

  # TODO: Confirm everything below
  resources :organization_build_statuses, path: 'build-statuses', only: [:index]

  resources :organizations do
    resources :organization_build_statuses, path: 'build-statuses', only: %i[show edit update] do
      resources :organization_build_steps,
                path: 'steps',
                only: %i[show create edit update destroy]
    end

    resources :participants,
              path: 'people',
              only: %i[new create index],
              controller: 'organization_members'
    patch 'remove-staged', to: 'organization_members#remove_staged', as: :remove_staged

    resources :shifts, only: [:index]
    resources :tools, only: [:index]
    get 'hardhats', on: :member
    resources :downtime, controller: :downtime, only: [:index]
    resources :memberships, only: %i[new create destroy]
    # Membership bulk add operations
    post 'upload-membership-csv', to: 'memberships#upload_csv', as: :upload_membership_csv
    post 'replace-membership', to: 'memberships#replace', as: :replace_membership
    post 'insert-membership', to: 'memberships#insert', as: :insert_membership
    post 'remove-membership', to: 'memberships#remove', as: :remove_membership
    post 'cancel-membership-csv', to: 'memberships#cancel', as: :cancel_membership_csv
    post 'commit-membership-csv', to: 'memberships#commit', as: :commit_membership_csv
  end

  resources :organization_timeline_entries,
            path: 'timeline-entries',
            only: %i[show edit create update destroy] do
    put 'end', on: :member
  end

  resources :event_types, path: 'event-types'
  resources :events do
    member { post 'approve' }
  end

  resources :charges do
    put 'approve', on: :member
    get 'export', on: :collection
  end

  resources :charge_types, path: 'charge-types'

  # Direct link to a participant's own resource
  get 'profile', to: 'participants#show', as: :profile

  resources :participants, path: 'people' do
    get 'search', on: :collection

    resources :memberships, except: %i[index show]

    # resource :waiver, only: %i[show create]
    resources :certifications, only: %i[new create destroy]
    post 'lookup', on: :collection
  end

  resources :shifts do
    resources :participants,
              path: 'people',
              controller: :shift_participants,
              only: %i[new create update destroy]
    collection { post 'upload-shift-csv', to: 'shifts#upload_csv', as: :upload_shift_csv }
  end

  resources :tasks do
    member { post 'complete' }
  end

  resources :tool_types, path: 'tool-types', except: [:show]

  resources :checkouts, only: [:create] do
    post 'checkin', on: :collection
    post 'uncheckin', on: :member
  end

  get 'store' => 'store/items#index'
  namespace :store do
    resources 'items' do
      post 'add-to-cart', on: :member, controller: 'purchases', action: :add_to_cart, as: :add_to_cart
      post 'remove-from-cart', on: :member, controller: 'purchases', action: :remove_from_cart, as: :remove_from_cart
    end
    resources 'purchase', controller: 'purchases', except: %i[create new index]
    scope 'cart', as: 'cart', controller: 'purchases' do
      get 'review', action: 'new'
      post 'checkout', action: 'create'
      post 'choose-organization', action: 'choose_organization', as: 'choose_organization'
      delete 'clear-cart', action: 'clear_cart', as: 'clear_cart'
      get 'reset-participant', action: 'reset_participant', as: 'reset_participant'
    end
  end

  # static pages
  get 'milestones' => 'home#milestones', :as => 'milestones'

  match 'search' => 'home#search', :as => 'search', :via => %i[get post]
  get 'home' => 'home#home', :as => 'home'

  # Custom one-offs
  get 'hardhats' => 'home#hardhats', :as => 'hardhats'
  get 'hardhat-return' => 'home#hardhat_return', :as => 'hardhat_return'
  get 'charge-overview' => 'home#charge_overview', :as => 'charge_overview'
  get 'structural' => 'organization_timeline_entries#structural',
      :as => 'structural'
  get 'electrical' => 'organization_timeline_entries#electrical',
      :as => 'electrical'
  get 'queues' => 'organization_timeline_entries#queues', :as => 'queues'
  get 'queues/history' => 'organization_timeline_entries#history',
      :as => 'queue_history'

  resources :users

  resources :weather, only: %i[index]

  get 'manifest', to: 'pwa#manifest', defaults: { format: :json }
  get 'service-worker', to: 'pwa#service_worker', defaults: { format: :js }

  # Push Notifications
  post 'push-notifications/subscribe', to: 'push_notifications#subscribe'
  delete 'push-notifications/:id', to: 'push_notifications#unsubscribe'
end

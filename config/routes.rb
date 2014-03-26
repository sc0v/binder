Trailerapp::Application.routes.draw do

  resources :documents
  resources :faqs, :except => [:show]
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
  resources :charges do
    put 'approve', on: :member
  end
  resources :participants do
    resources :memberships, :except => [:index, :show, :destroy]
    post 'lookup', on: :collection
  end
  resources :shifts do
    resources :participants, :controller => :shift_participants, :only => [:new, :create, :destroy]
  end
  resources :tasks
  resources :tools do
    resources :checkouts, :only => [:new, :create, :update, :index]
  end
  resources :checkouts, :only => [:create]

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


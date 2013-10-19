require 'sidekiq/web'

Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      post 'search'
    end
    resources :reviews, only: [:create]
  end

  resources :relationships, only: [:create, :destroy]
  get 'people', to: 'relationships#index'

  resources :categories, only: [:show]

  resources :queue_items, only: [:create, :destroy]

  post 'update_queue', to: 'queue_items#update_queue'

  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  get 'register/:token', to: "users#new_with_invitation_token", as: 'register_with_token'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'

  #mod 11.1 namespacing
  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :categories, only: [:new, :create]
  end

  # Forgot passwords is a virtual resource mod8
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'

  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]

  resources :invitations, only: [:new, :create]

  mount Sidekiq::Web, at: "/sidekiq"
end

Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      post 'search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]

  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'

  resources :categories

  resources :users, only: [:create]
  resources :sessions, only: [:create]

end

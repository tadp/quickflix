Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  resources :categories
  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
  end

  resources :users, only: [:create]
  resources :sessions, only: [:create]

end

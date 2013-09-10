Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'
  get '/register', to: 'users#new'
  get '/login', to: 'pages#sign_in'
  resources :categories
  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
  end

  resources :users, only: [:create]

end

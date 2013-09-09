Myflix::Application.routes.draw do
  root to: 'videos#home'
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'
  resources :categories
  resources :videos
end

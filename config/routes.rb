Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
<<<<<<< HEAD
  get '/home', to: 'videos#home'
  resources :categories
  resources :videos
=======
>>>>>>> 65609e9e319ae9d78df44ed7f0e5caa0a322e47f
end

Rails.application.routes.draw do
  resources :events
  get 'auth/new'

  resources :users
  resources :tickets
  root :to => "events#index"

  get    '/profile', to: 'users#profile'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'auth#new'
  post   '/login',   to: 'auth#create'
  delete '/logout',  to: 'auth#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

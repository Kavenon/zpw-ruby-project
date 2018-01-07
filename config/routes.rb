Rails.application.routes.draw do

  resources :tickets

  resources :events do
    resources :tickets
  end

  get 'auth/new'

  resources :users
  root :to => "events#index"

  get    '/profile', to: 'users#profile'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'auth#new'
  post   '/login',   to: 'auth#create'
  post   '/events/filter',   to: 'events#filter'
  post   '/users/balance',   to: 'users#balance'
  delete '/logout',  to: 'auth#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

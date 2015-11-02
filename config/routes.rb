Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, except: :destroy
  resources :categories, only: [:show, :new, :create]
  resources :order_items, only: [:create, :update, :destroy]
  resources :users, only: [:create]
  resources :orders, except: [:edit, :destroy]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end

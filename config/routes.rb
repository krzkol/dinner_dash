Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: :index
  resources :categories, only: :show
  resources :order_items, only: [:create, :update, :destroy]
  resources :users, only: [:create]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end

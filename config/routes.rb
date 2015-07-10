Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: :index
  resources :categories, only: :show
  resources :order_items, only: [:create, :update, :destroy]
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end

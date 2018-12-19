Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'education', to: 'pages#education'
  get 'privacy_policy', to: 'pages#privacy_policy'

  resources :products, only: [:show, :index]
  resources :cart_items, only: [:show, :create, :index, :destroy]
  resources :carts, only: [:show] do
    resources :payments, only: [:new, :create] do
      collection do
        post 'checkout'
        get 'success'
      end
    end
  end
  # resources :reviews, only: :index
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

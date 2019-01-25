Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'education', to: 'pages#education'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_and_conditions', to: 'pages#terms_and_conditions'

  # someone cached the old path, so i redirect for those error analtics
  get 'products/cbd oils', to: redirect('/products/cbd_oils')

  resources :products, only: [:show], param: :name
  resources :cart_items, only: [:show, :create, :destroy, :update]
  resources :carts, only: [:show] do
    collection do
      post 'coupon'
    end
    resources :payments, only: [:new] do
      collection do
        post 'checkout' #this could just be create
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

# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :users do
    namespace :api_v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth'

      # Orders controller for users namespace
      resources :orders, only: [:create]
      resources :movies, only: %i[index show]
      post 'rent/:order_id/return', to: 'rents#return', as: 'rent_return'
    end
  end

  namespace :admins do
    namespace :api_v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'Admin', at: 'auth'
      # Only admins can Add/remove movies and modify their sale or rent prices
      resources :movies, only: %i[index create update destroy]
    end
  end

  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
end

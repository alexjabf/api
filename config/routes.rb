# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post :sign_up, to: 'registrations#create'
        post :sign_in, to: 'sessions#create'
        delete :sign_out, to: 'sessions#destroy'
      end
      post :facebook, to: 'users#facebook'

      resources :books do
        resources :reviews
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

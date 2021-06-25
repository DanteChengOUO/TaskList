# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  # mission
  resources :missions, except: [:show]

  # session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # admin
  namespace 'admin' do
    resources :users
  end
end

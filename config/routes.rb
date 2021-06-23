# frozen_string_literal: true

Rails.application.routes.draw do
  root 'missions#index'

  resources :missions, except: [:show]
end

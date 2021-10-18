# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :session do
    get 'login', to: 'sessions#new' # or => :new
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
  root 'root#index', as: 'root_index'
end

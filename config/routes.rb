# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users

  post "/login", to: "authentication#create"
end

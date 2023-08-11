# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users

  post "/login", to: "authentication#create"

  namespace :api do
    scope module: :v2, constraints: ApiVersion.new(2) do
      resources :users
    end
    scope module: :v1, constraints: ApiVersion.new(1) do
      resources :users
    end
  end
end

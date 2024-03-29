# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations",
    passwords: "accounts/passwords"
  }

  get "/plans/current", to: "plans#current", as: :current_plan

  resources :plans
  resources :pictos do
    get "enable", on: :member
    get "disable", on: :member
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end

# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations",
    passwords: "accounts/passwords"
  }

  get "/plans/current", to: "plans#current", as: :current_plan

  resources :plans do
    put "activate", on: :member

    resources :events, controller: "plans/events"
  end

  resources :pictos do
    get "enable", on: :member
    get "disable", on: :member
  end

  put "/events" => "plans/events#reorder"
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end

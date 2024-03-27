# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations",
    passwords: "accounts/passwords"
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end

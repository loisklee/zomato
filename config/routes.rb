# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :cuisines, only: :index
    resources :reviews, only: :index
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "throw", to: "throws#show"
  get "lazy_load", to: "throws#lazy_load"
end

# frozen_string_literal: true

Rails.application.routes.draw do
  resources :lat_long_from_addresses

  root to: 'lat_long_from_addresses#new'
end

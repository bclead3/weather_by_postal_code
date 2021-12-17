Rails.application.routes.draw do
  resources :postal_code_forecasts
  resources :lat_long_from_addresses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

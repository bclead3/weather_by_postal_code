# frozen_string_literal: true

class AddForecastCacheToPostalCodeForecast < ActiveRecord::Migration[6.1]
  def change
    add_column :postal_code_forecasts, :forecast_cache, :json
  end
end

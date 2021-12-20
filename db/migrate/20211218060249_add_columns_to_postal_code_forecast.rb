# frozen_string_literal: true

class AddColumnsToPostalCodeForecast < ActiveRecord::Migration[6.1]
  def change
    add_column :postal_code_forecasts, :grid_id, :string
    add_column :postal_code_forecasts, :grid_x, :integer
    add_column :postal_code_forecasts, :grid_y, :integer
    add_column :postal_code_forecasts, :station_url, :string
  end
end

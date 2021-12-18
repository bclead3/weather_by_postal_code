class CreateForecastPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :forecast_periods do |t|
      t.string :postal_code, nil: false
      t.datetime :start_time, nil: false
      t.datetime :end_time, nil: false
      t.string :period_name
      t.boolean :is_daytime
      t.float :temperature, nil: false
      t.string :temperature_unit, nil: false, default: 'F'
      t.float :wind_speed
      t.string :wind_direction
      t.string :icon_url
      t.string :short_forecast
      t.string :detailed_forecast

      t.timestamps
    end
  end
end

class AddIndxzToForecastPeriods < ActiveRecord::Migration[6.1]
  def change
    add_index :forecast_periods, [:postal_code, :start_time]
    add_index :forecast_periods, :end_time
  end
end

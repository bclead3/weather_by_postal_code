# frozen_string_literal: true

class AddTimeZone < ActiveRecord::Migration[6.1]
  def change
    add_column :postal_code_forecasts, :time_zone, :string
    add_column :lat_long_from_addresses, :time_zone, :string
  end
end

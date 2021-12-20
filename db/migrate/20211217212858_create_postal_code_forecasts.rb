# frozen_string_literal: true

class CreatePostalCodeForecasts < ActiveRecord::Migration[6.1]
  def change
    create_table :postal_code_forecasts do |t|
      t.string :postal_code, nil: false
      t.datetime :time_of_last_request

      t.timestamps
    end
  end
end

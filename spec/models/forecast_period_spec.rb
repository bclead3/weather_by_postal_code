# frozen_string_literal: true

require 'rails_helper'
require 'assets/web/web_forecast_request'

RSpec.describe ForecastPeriod, type: :model do
  let(:postal_code) { '55426' }
  let(:period_hash) do
    {
      "number"=>14,
      "name"=>"Thursday Night",
      "startTime"=>"2021-12-23T18:00:00-06:00",
      "endTime"=>"2021-12-24T06:00:00-06:00",
      "isDaytime"=>false,
      "temperature"=>11,
      "temperatureUnit"=>"F",
      "temperatureTrend"=>nil,
      "windSpeed"=>"5 mph",
      "windDirection"=>"SSW",
      "icon"=>"https://api.weather.gov/icons/land/night/bkn?size=medium",
      "shortForecast"=>"Mostly Cloudy",
      "detailedForecast"=>"Mostly cloudy, with a low around 11. South southwest wind around 5 mph."
    }
  end
  let(:web_forecast_object) { Assets::Web::WebForecastRequest.new }

  it 'converts a period hash' do
    transformed_hash = web_forecast_object.send(:transform_json_keys, period_hash, postal_code)
    period_obj = ForecastPeriod.create(transformed_hash)
    expect(period_obj.period_name).to eq('Thursday Night')
    expect(period_obj.postal_code).to eq(postal_code)
    expect(period_obj.start_time).to eq("2021-12-23T18:00:00-06:00")
    expect(period_obj.end_time).to eq("2021-12-24T06:00:00-06:00")
    expect(period_obj.is_daytime).to be_falsey
    expect(period_obj.temperature).to eq(11)
    expect(period_obj.temperature_unit).to eq('F')
    expect(period_obj.wind_speed).to eq(5.0)
    expect(period_obj.wind_direction).to eq('SSW')
    expect(period_obj.icon_url).to eq("https://api.weather.gov/icons/land/night/bkn?size=medium")
    expect(period_obj.short_forecast).to eq('Mostly Cloudy')
    expect(period_obj.detailed_forecast).to eq('Mostly cloudy, with a low around 11. South southwest wind around 5 mph.')
  end
end

# {"period_name"=>"Thursday Night",
#  "start_time"=>"2021-12-23T18:00:00-06:00",
#  "end_time"=>"2021-12-24T06:00:00-06:00",
#  "is_daytime"=>false,
#  "temperature"=>11,
#  "temperature_unit"=>"F",
#  "wind_speed"=>"5 mph",
#  "wind_direction"=>"SSW",
#  "icon_url"=>"https://api.weather.gov/icons/land/night/bkn?size=medium",
#  "short_forecast"=>"Mostly Cloudy",
#  "detailed_forecast"=>
#   "Mostly cloudy, with a low around 11. South southwest wind around 5 mph.",
#  "postal_code"=>"55426"}

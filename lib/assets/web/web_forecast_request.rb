require 'httparty'

module Assets
  module Web
    class WebForecastRequest
      def parse_nuggets_from_json_resp(json_resp)
        return {err: 'invalid JSON'} if json_resp.empty?

        grid_id = json_resp['properties']['gridId']
        grid_y = json_resp['properties']['gridY']
        grid_x = json_resp['properties']['gridX']
        forecast_url = json_resp['properties']['forecast']
        uri_forecast_hourly = json_resp['properties']['forecastHourly']

        out_hash = HashWithIndifferentAccess.new
        out_hash[:grid_id] = grid_id
        out_hash[:grid_x] = grid_x
        out_hash[:grid_y] =  grid_y
        out_hash[:forecast_url] = forecast_url
        out_hash[:hourly_url] = uri_forecast_hourly
        out_hash
      end

      def update_postal_code_forecast(mini_json, postal_code_forecast)
        grid_id = mini_json['grid_id']
        grid_x  = mini_json['grid_x']
        grid_y  = mini_json['grid_y']
        forecast_url = mini_json['forecast_url']
        postal_code_forecast.update(grid_id: grid_id, grid_x: grid_x, grid_y: grid_y, station_url: forecast_url, time_of_last_request: DateTime.now)
      end

      def create_forecast_periods(forecast_url, postal_code)
        page = HTTParty.get(forecast_url)
        json_forecast_resp = JSON.parse(page.body)
        json_forecast_resp['properties']['periods'].each_with_index do |period_json, period_index|
          puts period_index+1
          period_json = transform_json_keys(period_json, postal_code)
          forecast_period = ForecastPeriod.find_or_create_by(postal_code: postal_code, start_time: period_json['start_time'], end_time: period_json['end_time'])
          forecast_period.update(period_json)
          # pp forecast_period.inspect
        end
      end

      def create_cache(postal_code)
        cache_hash = HashWithIndifferentAccess.new
        cache_hash[:postal_code] = postal_code
        cache_hash[:periods] = []
        ForecastPeriod.where(postal_code: postal_code).order(:start_time).each do |record|
          cache_hash[:periods] << JSON.parse(record.to_json)
        end
        # pp cache_hash
        cache_hash
      end

      def update_postal_code_forecast_two(postal_code_forecast, cache_hash)
        postal_code_forecast.update(forecast_cache: cache_hash, time_of_last_request: DateTime.now)
      end

      private

      def transform_json_keys(period_json, postal_code)
        period_json['postal_code'] = postal_code
        period_json.delete('number')
        period_json.delete('temperatureTrend')
        period_json = period_json.transform_keys { |key| key.underscore }
        period_json = period_json.transform_keys { |key| key == 'name' ? key = 'period_name' : key }
        period_json = period_json.transform_keys { |key| key == 'icon' ? key = 'icon_url' : key }
      end
    end
  end
end

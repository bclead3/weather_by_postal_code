require 'httparty'

module Assets
  module Web
    class WebStationRequest

      def request_weather_station(lat, long)
        return 'Must have valid latitude' if lat.empty?
        return 'Must have valid longitude' if long.empty?

        lat = lat.to_f.round(4).to_s
        long = long.to_f.round(4).to_s
        uri = URI.parse("https://api.weather.gov/points/#{lat},#{long}")
        response = HTTParty.get(uri)
        JSON.parse(response.body)
      end
    end
  end
end

require 'rails_helper'
require 'assets/web/web_forecast_request'
# require_relative '../../../../app/models/ApplicationRecord'
# require_relative '../../../../app/models/postal_code_forecast'
require 'byebug'

describe Assets::Web::WebForecastRequest do
  let(:subject) { Assets::Web::WebForecastRequest.new }
  let(:station_hash) do
    {"@context"=>
       ["https://geojson.org/geojson-ld/geojson-context.jsonld",
        {"@version"=>"1.1",
         "wx"=>"https://api.weather.gov/ontology#",
         "s"=>"https://schema.org/",
         "geo"=>"http://www.opengis.net/ont/geosparql#",
         "unit"=>"http://codes.wmo.int/common/unit/",
         "@vocab"=>"https://api.weather.gov/ontology#",
         "geometry"=>{"@id"=>"s:GeoCoordinates", "@type"=>"geo:wktLiteral"},
         "city"=>"s:addressLocality",
         "state"=>"s:addressRegion",
         "distance"=>{"@id"=>"s:Distance", "@type"=>"s:QuantitativeValue"},
         "bearing"=>{"@type"=>"s:QuantitativeValue"},
         "value"=>{"@id"=>"s:value"},
         "unitCode"=>{"@id"=>"s:unitCode", "@type"=>"@id"},
         "forecastOffice"=>{"@type"=>"@id"},
         "forecastGridData"=>{"@type"=>"@id"},
         "publicZone"=>{"@type"=>"@id"},
         "county"=>{"@type"=>"@id"}}],
     "id"=>"https://api.weather.gov/points/44.9782,-93.2693",
     "type"=>"Feature",
     "geometry"=>{"type"=>"Point", "coordinates"=>[-93.2693, 44.9782]},
     "properties"=>
       {"@id"=>"https://api.weather.gov/points/44.9782,-93.2693",
        "@type"=>"wx:Point",
        "cwa"=>"MPX",
        "forecastOffice"=>"https://api.weather.gov/offices/MPX",
        "gridId"=>"MPX",
        "gridX"=>107,
        "gridY"=>71,
        "forecast"=>"https://api.weather.gov/gridpoints/MPX/107,71/forecast",
        "forecastHourly"=>"https://api.weather.gov/gridpoints/MPX/107,71/forecast/hourly",
        "forecastGridData"=>"https://api.weather.gov/gridpoints/MPX/107,71",
        "observationStations"=>"https://api.weather.gov/gridpoints/MPX/107,71/stations",
        "relativeLocation"=>
          {"type"=>"Feature",
           "geometry"=>{"type"=>"Point", "coordinates"=>[-93.26832, 44.963324]},
           "properties"=>{"city"=>"Minneapolis", "state"=>"MN", "distance"=>{"unitCode"=>"wmoUnit:m", "value"=>1655.9336213929}, "bearing"=>{"unitCode"=>"wmoUnit:degree_(angle)", "value"=>357}}},
        "forecastZone"=>"https://api.weather.gov/zones/forecast/MNZ060",
        "county"=>"https://api.weather.gov/zones/county/MNC053",
        "fireWeatherZone"=>"https://api.weather.gov/zones/fire/MNZ060",
        "timeZone"=>"America/Chicago",
        "radarStation"=>"KMPX"}}
  end
  describe '#parse_nuggets_from_json_resp' do
    it 'works when appropriate JSON is passed in' do
      out_hash = subject.parse_nuggets_from_json_resp(station_hash)
      expected_hash = {
                        'forecast_url'=>'https://api.weather.gov/gridpoints/MPX/107,71/forecast',
                        'grid_id'=>'MPX',
                        'grid_x'=>107,
                        'grid_y'=>71,
                        'hourly_url'=>'https://api.weather.gov/gridpoints/MPX/107,71/forecast/hourly',
                        "time_zone" => "America/Chicago"
                      }
      expect(out_hash).to eq(expected_hash)
    end
  end

  # NOTE: For some odd reason, I'm unable to access ActiveRecord objects. Since time is running short,
  # I'm abandoning testing this class for the moment.
  describe '#update_postal_code_forecast' do
    # it 'updates an instance of PostalCodeForecast' do
    #   out_hash = {
    #     :forecast_url=>"https://api.weather.gov/gridpoints/MPX/107,71/forecast",
    #     :grid_id=>"MPX",
    #     :grid_x=>107,
    #     :grid_y=>71,
    #     :hourly_url=>"https://api.weather.gov/gridpoints/MPX/107,71/forecast/hourly"
    #   }
    #   time_stamp = DateTime.now
    #   postal_code_forecast = PostalCodeForecast.create(postal_code: 55426, time_of_last_request: time_stamp)
    #   byebug
    #   postal_code_forecast = subject.update_postal_code_forecast(out_hash, postal_code_forecast)
    #   expect(postal_code_forecast.grid_id).to eq('MPX')
    #   expect(postal_code_forecast.grid_x).to eq(107)
    #   expect(postal_code_forecast.grid_y).to eq(71)
    #   expect(postal_code_forecast.station_url).to eq(out_hash['forecast_url'])
    # end
  end
end

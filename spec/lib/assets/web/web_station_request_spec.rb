# frozen_string_literal: true

require 'spec_helper'
require 'assets/web/web_station_request'
# require 'byebug'

describe Assets::Web::WebStationRequest do
  let(:subject) { Assets::Web::WebStationRequest.new }
  let(:output_json) do
    { '@context' =>
       ['https://geojson.org/geojson-ld/geojson-context.jsonld',
        { '@version' => '1.1',
          'wx' => 'https://api.weather.gov/ontology#',
          's' => 'https://schema.org/',
          'geo' => 'http://www.opengis.net/ont/geosparql#',
          'unit' => 'http://codes.wmo.int/common/unit/',
          '@vocab' => 'https://api.weather.gov/ontology#',
          'geometry' => { '@id' => 's:GeoCoordinates', '@type' => 'geo:wktLiteral' },
          'city' => 's:addressLocality',
          'state' => 's:addressRegion',
          'distance' => { '@id' => 's:Distance', '@type' => 's:QuantitativeValue' },
          'bearing' => { '@type' => 's:QuantitativeValue' },
          'value' => { '@id' => 's:value' },
          'unitCode' => { '@id' => 's:unitCode', '@type' => '@id' },
          'forecastOffice' => { '@type' => '@id' },
          'forecastGridData' => { '@type' => '@id' },
          'publicZone' => { '@type' => '@id' },
          'county' => { '@type' => '@id' } }],
      'id' => 'https://api.weather.gov/points/44.9782,-93.2693',
      'type' => 'Feature',
      'geometry' => { 'type' => 'Point', 'coordinates' => [-93.2693, 44.9782] },
      'properties' =>
       { '@id' => 'https://api.weather.gov/points/44.9782,-93.2693',
         '@type' => 'wx:Point',
         'cwa' => 'MPX',
         'forecastOffice' => 'https://api.weather.gov/offices/MPX',
         'gridId' => 'MPX',
         'gridX' => 107,
         'gridY' => 71,
         'forecast' => 'https://api.weather.gov/gridpoints/MPX/107,71/forecast',
         'forecastHourly' => 'https://api.weather.gov/gridpoints/MPX/107,71/forecast/hourly',
         'forecastGridData' => 'https://api.weather.gov/gridpoints/MPX/107,71',
         'observationStations' => 'https://api.weather.gov/gridpoints/MPX/107,71/stations',
         'relativeLocation' =>
          { 'type' => 'Feature',
            'geometry' => { 'type' => 'Point', 'coordinates' => [-93.26832, 44.963324] },
            'properties' => { 'city' => 'Minneapolis', 'state' => 'MN',
                              'distance' => { 'unitCode' => 'wmoUnit:m', 'value' => 1655.9336213929 }, 'bearing' => { 'unitCode' => 'wmoUnit:degree_(angle)', 'value' => 357 } } },
         'forecastZone' => 'https://api.weather.gov/zones/forecast/MNZ060',
         'county' => 'https://api.weather.gov/zones/county/MNC053',
         'fireWeatherZone' => 'https://api.weather.gov/zones/fire/MNZ060',
         'timeZone' => 'America/Chicago',
         'radarStation' => 'KMPX' } }
  end
  describe '#request_weather_station' do
    it 'returns valid JSON if appropriate latitude and logitude coordinates are passed in' do
      stub_request(:get, 'https://api.weather.gov/points/44.9782,-93.2693')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: output_json.to_json, headers: {})

      lat = '44.9782466'
      long = '-93.2692576'
      output_json = subject.request_weather_station(lat, long)
      expect(output_json.keys).to eq(['@context', 'id', 'type', 'geometry', 'properties'])
      expect(output_json['properties']['gridId']).to eq('MPX')
      expect(output_json['properties']['gridX']).to eq(107)
      expect(output_json['properties']['gridY']).to eq(71)
      expect(output_json['properties']['forecast']).to eq('https://api.weather.gov/gridpoints/MPX/107,71/forecast')
      expect(output_json['properties']['forecastHourly']).to eq('https://api.weather.gov/gridpoints/MPX/107,71/forecast/hourly')
    end

    it 'returns a warning if a blank latitude is passed in' do
      lat = ''
      long = '-93.2692576'
      expect(subject.request_weather_station(lat, long)).to eq('Must have valid latitude')
    end

    it 'returns a warning if a blank longitude is passed in' do
      lat = '44.9782466'
      long = ''
      expect(subject.request_weather_station(lat, long)).to eq('Must have valid longitude')
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'
require 'assets/web/web_address_request'
require 'byebug'

describe Assets::Web::WebAddressRequest do
  let(:subject) { Assets::Web::WebAddressRequest.new }
  let(:hash) do
    [
      { 'place_id' => 324_648_326,
        'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'way',
        'osm_id' => 6_027_555,
        'boundingbox' => ['44.9772805', '44.979212', '-93.2700841', '-93.26845'],
        'lat' => '44.9782466',
        'lon' => '-93.2692576',
        'display_name' => 'Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55401, United States',
        'class' => 'highway',
        'type' => 'tertiary',
        'importance' => 0.41000000000000003,
        'address' => {
          'road' => 'Marquette Avenue South',
          'city' => 'Minneapolis',
          'county' => 'Hennepin County',
          'state' => 'Minnesota',
          'postcode' => '55401',
          'country' => 'United States',
          'country_code' => 'us'
        } },
      {
        'place_id' => 324_648_390,
        'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'way',
        'osm_id' => 183_245_941,
        'boundingbox' => ['44.9723851', '44.9733984', '-93.274123', '-93.2733107'],
        'lat' => '44.9729038',
        'lon' => '-93.2736849',
        'display_name' => 'Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55401:55403, United States',
        'class' => 'highway',
        'type' => 'tertiary',
        'importance' => 0.41000000000000003,
        'address' => {
          'road' => 'Marquette Avenue South',
          'city' => 'Minneapolis',
          'county' => 'Hennepin County',
          'state' => 'Minnesota',
          'postcode' => '55401:55403',
          'country' => 'United States',
          'country_code' => 'us'
        }
      },
      { 'place_id' => 324_416_631, 'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'way', 'osm_id' => 638_053_937, 'boundingbox' => ['44.971443', '44.9721444', '-93.274928', '-93.2743287'], 'lat' => '44.9715225', 'lon' => '-93.2748601', 'display_name' => 'Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55403, United States', 'class' => 'highway', 'type' => 'tertiary', 'importance' => 0.41000000000000003, 'address' => { 'road' => 'Marquette Avenue South', 'city' => 'Minneapolis', 'county' => 'Hennepin County', 'state' => 'Minnesota', 'postcode' => '55403', 'country' => 'United States', 'country_code' => 'us' } },
      { 'place_id' => 324_416_641, 'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'way', 'osm_id' => 863_687_223, 'boundingbox' => ['44.9705308', '44.971443', '-93.2756928', '-93.274928'], 'lat' => '44.9708475', 'lon' => '-93.2754272', 'display_name' => 'Marquette Avenue South, Loring Park, Minneapolis, Hennepin County, Minnesota, 55403, United States', 'class' => 'highway', 'type' => 'tertiary', 'importance' => 0.41000000000000003, 'address' => { 'road' => 'Marquette Avenue South', 'neighbourhood' => 'Loring Park', 'city' => 'Minneapolis', 'county' => 'Hennepin County', 'state' => 'Minnesota', 'postcode' => '55403', 'country' => 'United States', 'country_code' => 'us' } },
      { 'place_id' => 96_081_867, 'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'way', 'osm_id' => 6_003_538, 'boundingbox' => ['44.9820972', '44.9831362', '-93.2660171', '-93.2651282'], 'lat' => '44.9827261', 'lon' => '-93.2654776', 'display_name' => 'Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55402, United States', 'class' => 'highway', 'type' => 'tertiary', 'importance' => 0.41000000000000003, 'address' => { 'road' => 'Marquette Avenue South', 'city' => 'Minneapolis', 'county' => 'Hennepin County', 'state' => 'Minnesota', 'postcode' => '55402', 'country' => 'United States', 'country_code' => 'us' } },
      { 'place_id' => 67_938_119, 'licence' => 'Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright',
        'osm_type' => 'node', 'osm_id' => 6_178_628_386, 'boundingbox' => ['44.9745048', '44.9746048', '-93.2721888', '-93.2720888'], 'lat' => '44.9745548', 'lon' => '-93.2721388', 'display_name' => "Manny's Steakhouse, 825 S Marquette Ave, Minneapolis, MN 55402, 825, Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55402, United States", 'class' => 'amenity', 'type' => 'restaurant', 'importance' => 0.31100000000000005, 'icon' => 'https://nominatim.openstreetmap.org/ui/mapicons//food_restaurant.p.20.png', 'address' => { 'amenity' => "Manny's Steakhouse, 825 S Marquette Ave, Minneapolis, MN 55402", 'house_number' => '825', 'road' => 'Marquette Avenue South', 'city' => 'Minneapolis', 'county' => 'Hennepin County', 'state' => 'Minnesota', 'postcode' => '55402', 'country' => 'United States', 'country_code' => 'us' } }
    ]
  end
  describe '#request_address' do
    it 'Gets the Minneapolis Foshay tower zip' do
      stub_request(:get, 'https://nominatim.openstreetmap.org/search?addressdetails=1&format=json&polygon=1&q=821%2BMarquette%2BAvenue,%2BMinneapolis')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: hash.to_json, headers: {})
      hash = subject.request_address('821 Marquette Avenue', 'Minneapolis')
      first_hash_element = hash.first
      expect(first_hash_element['lat']).to eq('44.9782466')
      expect(first_hash_element['lon']).to eq('-93.2692576')
      expect(first_hash_element['address']['postcode']).to eq('55401')
    end
  end
end

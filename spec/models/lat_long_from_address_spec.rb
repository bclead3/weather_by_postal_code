require 'rails_helper'

RSpec.describe LatLongFromAddress, type: :model do
  let(:valid_attributes) { { address: '821 Marquette Avenue', city: 'Minneapolis', state: 'MN', zip: '55401'} } # Foshay Tower
  let(:min_attributes) { { address: '821 Marquette Avenue', city: 'Minneapolis' } }
  let(:invalid_attributes) { { address: '821 Marquette Avenue' } } # Foshay address only
  let(:foshay_response_hash) do
    [
      {
        "place_id": 324648326,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 6027555,
        "boundingbox": [
          "44.9772805",
          "44.979212",
          "-93.2700841",
          "-93.26845"
        ],
        "lat": "44.9782466",
        "lon": "-93.2692576",
        "display_name": "Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55401, United States",
        "class": "highway",
        "type": "tertiary",
        "importance": 0.41000000000000003,
        "address": {
          "road": "Marquette Avenue South",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55401",
          "country": "United States",
          "country_code": "us"
        }
      },
      {
        "place_id": 324648390,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 183245941,
        "boundingbox": [
          "44.9723851",
          "44.9733984",
          "-93.274123",
          "-93.2733107"
        ],
        "lat": "44.9729038",
        "lon": "-93.2736849",
        "display_name": "Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55401:55403, United States",
        "class": "highway",
        "type": "tertiary",
        "importance": 0.41000000000000003,
        "address": {
          "road": "Marquette Avenue South",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55401:55403",
          "country": "United States",
          "country_code": "us"
        }
      },
      {
        "place_id": 324416631,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 638053937,
        "boundingbox": [
          "44.971443",
          "44.9721444",
          "-93.274928",
          "-93.2743287"
        ],
        "lat": "44.9715225",
        "lon": "-93.2748601",
        "display_name": "Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55403, United States",
        "class": "highway",
        "type": "tertiary",
        "importance": 0.41000000000000003,
        "address": {
          "road": "Marquette Avenue South",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55403",
          "country": "United States",
          "country_code": "us"
        }
      },
      {
        "place_id": 324416641,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 863687223,
        "boundingbox": [
          "44.9705308",
          "44.971443",
          "-93.2756928",
          "-93.274928"
        ],
        "lat": "44.9708475",
        "lon": "-93.2754272",
        "display_name": "Marquette Avenue South, Loring Park, Minneapolis, Hennepin County, Minnesota, 55403, United States",
        "class": "highway",
        "type": "tertiary",
        "importance": 0.41000000000000003,
        "address": {
          "road": "Marquette Avenue South",
          "neighbourhood": "Loring Park",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55403",
          "country": "United States",
          "country_code": "us"
        }
      },
      {
        "place_id": 96081867,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 6003538,
        "boundingbox": [
          "44.9820972",
          "44.9831362",
          "-93.2660171",
          "-93.2651282"
        ],
        "lat": "44.9827261",
        "lon": "-93.2654776",
        "display_name": "Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55402, United States",
        "class": "highway",
        "type": "tertiary",
        "importance": 0.41000000000000003,
        "address": {
          "road": "Marquette Avenue South",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55402",
          "country": "United States",
          "country_code": "us"
        }
      },
      {
        "place_id": 67938119,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "node",
        "osm_id": 6178628386,
        "boundingbox": [
          "44.9745048",
          "44.9746048",
          "-93.2721888",
          "-93.2720888"
        ],
        "lat": "44.9745548",
        "lon": "-93.2721388",
        "display_name": "Manny's Steakhouse, 825, Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55402, United States",
        "class": "amenity",
        "type": "restaurant",
        "importance": 0.31100000000000005,
        "icon": "https://nominatim.openstreetmap.org/ui/mapicons//food_restaurant.p.20.png",
        "address": {
          "amenity": "Manny's Steakhouse",
          "house_number": "825",
          "road": "Marquette Avenue South",
          "city": "Minneapolis",
          "county": "Hennepin County",
          "state": "Minnesota",
          "postcode": "55402",
          "country": "United States",
          "country_code": "us"
        }
      }
    ]
  end

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

  describe 'instantiation' do
    it 'works with valid attributes' do
      stub_request(:get, "https://api.weather.gov/points/44.9782,-93.2693").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: station_hash.to_json, headers: {})

      lat_long_from_address = LatLongFromAddress.create valid_attributes
      puts lat_long_from_address.errors.errors.inspect
      expect(lat_long_from_address.address).to eq('821 Marquette Avenue')
      expect(lat_long_from_address.city).to eq('Minneapolis')
      expect(lat_long_from_address.state).to eq('MN')
      expect(lat_long_from_address.zip).to eq(55401)
    end

    it 'works with minimum addtributes' do
      lat_long_from_address = LatLongFromAddress.create! min_attributes
      expect(lat_long_from_address.address).to eq('821 Marquette Avenue')
      expect(lat_long_from_address.city).to eq('Minneapolis')
    end

    it 'fails when there aren\'t enough attributes passed along' do
      expect { LatLongFromAddress.create! invalid_attributes }.to raise_exception(ActiveRecord::RecordInvalid)
      lat_long_addr = LatLongFromAddress.create invalid_attributes
      expect(lat_long_addr.errors).to be_a(ActiveModel::Errors)
      expect(lat_long_addr.errors.errors.first).to be_a(ActiveModel::Error)
      expect(lat_long_addr.errors.errors.first.message).to eq("can't be blank")
      expect(lat_long_addr.errors.errors.first.full_message).to eq("City can't be blank")
      expect(lat_long_addr.errors.errors.first.details).to eq( { :error=>:blank } )
    end
  end

  describe '#full_address' do

    it 'prints address and city' do
      stub_request(:get, "https://nominatim.openstreetmap.org/search?addressdetails=1&format=json&polygon=1&q=821+Marquette+Avenue,Minneapolis").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: foshay_response_hash.to_json, headers: {})

      lat_long_from_address = LatLongFromAddress.create! min_attributes
      expect(lat_long_from_address.full_address).to eq('821 Marquette Avenue, Minneapolis')
    end

    it 'prints valid attributes' do
      lat_long_from_address = LatLongFromAddress.create! valid_attributes
      expected_full_address = '821 Marquette Avenue, Minneapolis, MN  55401'
      expect(lat_long_from_address.full_address).to eq(expected_full_address)
    end
  end

  describe '#populate' do
    let(:hash) do
        [
          {"place_id"=>324648326,
           "licence"=>"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
           "osm_type"=>"way",
           "osm_id"=>6027555,
           "boundingbox"=>["44.9772805", "44.979212", "-93.2700841", "-93.26845"],
           "lat"=>"44.9782466",
           "lon"=>"-93.2692576",
           "display_name"=>"Marquette Avenue South, Minneapolis, Hennepin County, Minnesota, 55401, United States",
           "class"=>"highway",
           "type"=>"tertiary",
           "importance"=>0.41000000000000003,
           "address"=>{
             "road"=>"Marquette Avenue South",
             "city"=>"Minneapolis",
             "county"=>"Hennepin County",
             "state"=>"Minnesota",
             "postcode"=>"55401",
             "country"=>"United States",
             "country_code"=>"us"}
          }
        ]
        end
    it 'works on minimal attributes' do
      stub_request(:get, "https://nominatim.openstreetmap.org/search?addressdetails=1&format=json&polygon=1&q=821%2BMarquette%2BAvenue,%2BMinneapolis").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: hash.to_json, headers: {})
      lat_long_from_address = LatLongFromAddress.create(min_attributes)
      lat_long_from_address.populate
      expect(lat_long_from_address.address).to eq('821 Marquette Avenue')
      expect(lat_long_from_address.city).to eq('Minneapolis')
      expect(lat_long_from_address.state).to eq('Minnesota')
      expect(lat_long_from_address.county).to eq('Hennepin County')
      expect(lat_long_from_address.country).to eq('United States')
      expect(lat_long_from_address.lat).to eq('44.9782466')
      expect(lat_long_from_address.long).to eq('-93.2692576')
      expect(lat_long_from_address.source_place_id).to eq(324648326)
      expect(lat_long_from_address.zip).to eq(55401)
      expect(lat_long_from_address.postal_code).to eq('55401')
      expect(lat_long_from_address.previously_looked_up).to be_truthy
      expect(lat_long_from_address.json_resp.keys).to eq(%w[place_id licence osm_type osm_id boundingbox lat lon display_name class type importance address])
    end
  end

  describe '#zip_code' do
    let(:attributes) { { address: 'One Guest Street', city: 'Boston', state: 'MA', zip: '02135' } } # WGBH Boston
    let(:bogus_attrs) { { address: 'The Bogus Addr', city: 'Bangor', zip: '01034-1234', country: 'United States'} }
    let(:bogus_attrs_two) { { address: 'The Bogus Addr', city: 'Bangor', zip: '010341234', country: 'United States'} }

    it 'displays 2135 for zip, 02135 for zip_code' do
      lat_long_from_address = LatLongFromAddress.create(attributes)
      expect(lat_long_from_address.address).to eq('One Guest Street')
      expect(lat_long_from_address.city).to eq('Boston')
      expect(lat_long_from_address.state).to eq('MA')
      expect(lat_long_from_address.zip).to eq(2135)
      expect(lat_long_from_address.zip_code).to eq('02135')
    end

    it 'displays a zip+4 with only five digits' do
      lat_long_from_address = LatLongFromAddress.new(bogus_attrs)
      expect(lat_long_from_address.zip).to eq(1034)
      expect(lat_long_from_address.zip_code).to eq('01034')

      lat_long_from_address = LatLongFromAddress.new(bogus_attrs_two)
      #expect(lat_long_from_address.zip).to eq(1034)
      expect(lat_long_from_address.zip_code).to eq('01034')
    end
  end

end

# city: "Minneapolis",
#  state: "Minnesota",
#  zip: 55401,
#  postal_code: "55401",
#  county: "Hennepin County",
#  country: "United States",
#  lat: "44.9782466",
#  long: "-93.2692576",
#  source_place_id: 324648326,
#  previously_looked_up: true,

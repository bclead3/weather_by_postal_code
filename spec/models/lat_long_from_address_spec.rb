require 'rails_helper'

RSpec.describe LatLongFromAddress, type: :model do
  let(:valid_attributes) { { address: '821 Marquette Avenue', city: 'Minneapolis', state: 'MN', zip: '55401'} } # Foshay Tower
  let(:min_attributes) { { address: '821 Marquette Avenue', city: 'Minneapolis' } }
  let(:invalid_attributes) { { address: '821 Marquette Avenue' } } # Foshay address only

  describe 'instantiation' do
    it 'works with valid attributes' do
      lat_long_from_address = LatLongFromAddress.create! valid_attributes
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
    it 'works on minimal attributes' do
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

    it 'generates an associated PostalCodeForecast association' do

    end
  end

  describe '#zip_code' do
    let(:attributes) { { address: 'One Guest Street', city: 'Boston', state: 'MA', zip: '02135' } } # WGBH Boston

    it 'displays 2135 for zip, 02135 for zip_code' do
      lat_long_from_address = LatLongFromAddress.create(attributes)
      expect(lat_long_from_address.address).to eq('One Guest Street')
      expect(lat_long_from_address.city).to eq('Boston')
      expect(lat_long_from_address.state).to eq('MA')
      expect(lat_long_from_address.zip).to eq(2135)
      expect(lat_long_from_address.zip_code).to eq('02135')
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

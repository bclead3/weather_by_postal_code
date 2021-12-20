# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'lat_long_from_addresses/index', type: :view do
  before(:each) do
    assign(:lat_long_from_addresses, [
             LatLongFromAddress.create!(
               address: 'Address',
               city: 'City',
               state: 'State',
               zip: 2,
               lat: 3.5,
               long: 4.5,
               previously_looked_up: false,
               json_resp: 'MyText',
               display_address: 'Display Address'
             ),
             LatLongFromAddress.create!(
               address: 'Address',
               city: 'City',
               state: 'State',
               zip: 2,
               lat: 3.5,
               long: 4.5,
               previously_looked_up: false,
               json_resp: 'MyText',
               display_address: 'Display Address'
             )
           ])
  end

  it 'renders a list of lat_long_from_addresses' do
    render
    assert_select 'tr>td', text: 'Address'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'State'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.5.to_s, count: 2
    assert_select 'tr>td', text: 4.5.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Display Address'.to_s, count: 2
  end
end

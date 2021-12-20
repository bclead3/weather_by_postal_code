# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'lat_long_from_addresses/new', type: :view do
  before(:each) do
    assign(:lat_long_from_address, LatLongFromAddress.new(
                                     address: 'MyString',
                                     city: 'MyString',
                                     state: 'MyString',
                                     zip: 1,
                                     lat: 1.5,
                                     long: 1.5,
                                     previously_looked_up: false,
                                     json_resp: 'MyText',
                                     display_address: 'MyString'
                                   ))
  end

  it 'renders new lat_long_from_address form' do
    render

    assert_select 'form[action=?][method=?]', lat_long_from_addresses_path, 'post' do
      assert_select 'input[name=?]', 'lat_long_from_address[address]'

      assert_select 'input[name=?]', 'lat_long_from_address[city]'

      assert_select 'input[name=?]', 'lat_long_from_address[state]'
    end
  end
end

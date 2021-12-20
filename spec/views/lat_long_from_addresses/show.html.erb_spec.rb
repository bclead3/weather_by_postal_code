# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'lat_long_from_addresses/show', type: :view do
  before(:each) do
    @lat_long_from_address = assign(:lat_long_from_address, LatLongFromAddress.create!(
                                                              address: '75 Martin Luther King Jr, Blvd.',
                                                              city: 'St. Paul',
                                                              state: 'Minnesota',
                                                              postal_code: 55_200,
                                                              lat: 3.5,
                                                              long: 4.5,
                                                              previously_looked_up: false,
                                                              json_resp: 'MyText',
                                                              display_address: '75 Martin Luther King Jr, Blvd., St. Paul, Minnesota  55200'
                                                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Display address/)
    expect(rendered).to match(/Latitude/)
    expect(rendered).to match(/Longitude/)
    expect(rendered).to match(/Previously looked up:/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/75 Martin Luther King Jr, Blvd., St. Paul, Minnesota  55200/)
  end
end

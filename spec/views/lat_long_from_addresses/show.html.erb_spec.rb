require 'rails_helper'

RSpec.describe "lat_long_from_addresses/show", type: :view do
  before(:each) do
    @lat_long_from_address = assign(:lat_long_from_address, LatLongFromAddress.create!(
      address: "Address",
      city: "City",
      state: "State",
      zip: 2,
      lat: 3.5,
      long: 4.5,
      previously_looked_up: false,
      json_resp: "MyText",
      display_address: "Display Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Display Address/)
  end
end

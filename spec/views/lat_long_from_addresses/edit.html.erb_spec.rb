require 'rails_helper'

RSpec.describe "lat_long_from_addresses/edit", type: :view do
  before(:each) do
    @lat_long_from_address = assign(:lat_long_from_address, LatLongFromAddress.create!(
      address: "MyString",
      city: "MyString",
      state: "MyString",
      zip: 1,
      lat: 1.5,
      long: 1.5,
      previously_looked_up: false,
      json_resp: "MyText",
      display_address: "MyString"
    ))
  end

  it "renders the edit lat_long_from_address form" do
    render

    assert_select "form[action=?][method=?]", lat_long_from_address_path(@lat_long_from_address), "post" do

      assert_select "input[name=?]", "lat_long_from_address[address]"

      assert_select "input[name=?]", "lat_long_from_address[city]"

      assert_select "input[name=?]", "lat_long_from_address[state]"

    end
  end
end

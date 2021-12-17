require 'rails_helper'

RSpec.describe "postal_code_forecasts/index", type: :view do
  before(:each) do
    assign(:postal_code_forecasts, [
      PostalCodeForecast.create!(
        postal_code: "Postal Code"
      ),
      PostalCodeForecast.create!(
        postal_code: "Postal Code"
      )
    ])
  end

  it "renders a list of postal_code_forecasts" do
    render
    assert_select "tr>td", text: "Postal Code".to_s, count: 2
  end
end

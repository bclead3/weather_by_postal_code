require 'rails_helper'

RSpec.describe "postal_code_forecasts/show", type: :view do
  before(:each) do
    @postal_code_forecast = assign(:postal_code_forecast, PostalCodeForecast.create!(
      postal_code: "Postal Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Postal Code/)
  end
end

require 'rails_helper'

RSpec.describe "postal_code_forecasts/edit", type: :view do
  before(:each) do
    @postal_code_forecast = assign(:postal_code_forecast, PostalCodeForecast.create!(
      postal_code: "MyString"
    ))
  end

  it "renders the edit postal_code_forecast form" do
    render

    assert_select "form[action=?][method=?]", postal_code_forecast_path(@postal_code_forecast), "post" do

      assert_select "input[name=?]", "postal_code_forecast[postal_code]"
    end
  end
end

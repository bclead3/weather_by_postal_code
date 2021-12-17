require 'rails_helper'

RSpec.describe "postal_code_forecasts/new", type: :view do
  before(:each) do
    assign(:postal_code_forecast, PostalCodeForecast.new(
      postal_code: "MyString"
    ))
  end

  it "renders new postal_code_forecast form" do
    render

    assert_select "form[action=?][method=?]", postal_code_forecasts_path, "post" do

      assert_select "input[name=?]", "postal_code_forecast[postal_code]"
    end
  end
end

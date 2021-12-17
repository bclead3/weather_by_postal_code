require "rails_helper"

RSpec.describe PostalCodeForecastsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/postal_code_forecasts").to route_to("postal_code_forecasts#index")
    end

    it "routes to #new" do
      expect(get: "/postal_code_forecasts/new").to route_to("postal_code_forecasts#new")
    end

    it "routes to #show" do
      expect(get: "/postal_code_forecasts/1").to route_to("postal_code_forecasts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/postal_code_forecasts/1/edit").to route_to("postal_code_forecasts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/postal_code_forecasts").to route_to("postal_code_forecasts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/postal_code_forecasts/1").to route_to("postal_code_forecasts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/postal_code_forecasts/1").to route_to("postal_code_forecasts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/postal_code_forecasts/1").to route_to("postal_code_forecasts#destroy", id: "1")
    end
  end
end

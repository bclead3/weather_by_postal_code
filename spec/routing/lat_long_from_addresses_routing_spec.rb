require "rails_helper"

RSpec.describe LatLongFromAddressesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/lat_long_from_addresses").to route_to("lat_long_from_addresses#index")
    end

    it "routes to #new" do
      expect(get: "/lat_long_from_addresses/new").to route_to("lat_long_from_addresses#new")
    end

    it "routes to #show" do
      expect(get: "/lat_long_from_addresses/1").to route_to("lat_long_from_addresses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/lat_long_from_addresses/1/edit").to route_to("lat_long_from_addresses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/lat_long_from_addresses").to route_to("lat_long_from_addresses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/lat_long_from_addresses/1").to route_to("lat_long_from_addresses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lat_long_from_addresses/1").to route_to("lat_long_from_addresses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/lat_long_from_addresses/1").to route_to("lat_long_from_addresses#destroy", id: "1")
    end
  end
end

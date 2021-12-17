json.extract! lat_long_from_address, :id, :address, :city, :state, :zip, :lat, :long, :previously_looked_up, :json_resp, :display_address, :created_at, :updated_at
json.url lat_long_from_address_url(lat_long_from_address, format: :json)

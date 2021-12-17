class CreateLatLongFromAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :lat_long_from_addresses do |t|
      t.string :address, nil: false
      t.string :city, nil: false
      t.string :state
      t.integer :zip
      t.string :postal_code
      t.string :county
      t.string :country
      t.string :lat
      t.string :long
      t.integer :source_place_id
      t.boolean :previously_looked_up
      t.json :json_resp
      t.string :display_address

      t.timestamps
    end
  end
end

# [{"place_id"=>304096443,
#   "licence"=>
#    "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
#   "osm_type"=>"way",
#   "osm_id"=>380591047,
#   "boundingbox"=>
#    ["44.90913409221",
#     "44.90923409221",
#     "-93.295764623441",
#     "-93.295664623441"],
#   "lat"=>"44.90918409220979",
#   "lon"=>"-93.29571462344069",
#   "display_name"=>
#    "1246, West Minnehaha Parkway, Lynnhurst, Southwest, Minneapolis, Hennepin County, Minnesota, 55419, United States",
#   "class"=>"place",
#   "type"=>"house",
#   "importance"=>0.5209999999999999,
#   "address"=>
#    {"house_number"=>"1246",
#     "road"=>"West Minnehaha Parkway",
#     "neighbourhood"=>"Lynnhurst",
#     "suburb"=>"Southwest",
#     "city"=>"Minneapolis",
#     "county"=>"Hennepin County",
#     "state"=>"Minnesota",
#     "postcode"=>"55419",
#     "country"=>"United States",
#     "country_code"=>"us"}}]

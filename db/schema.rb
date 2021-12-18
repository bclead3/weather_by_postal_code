# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_18_060249) do

  create_table "forecast_periods", force: :cascade do |t|
    t.string "postal_code"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "period_name"
    t.boolean "is_daytime"
    t.float "temperature"
    t.string "temperature_unit", default: "F"
    t.float "wind_speed"
    t.string "wind_direction"
    t.string "icon_url"
    t.string "short_forecast"
    t.string "detailed_forecast"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lat_long_from_addresses", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "postal_code"
    t.string "county"
    t.string "country"
    t.string "lat"
    t.string "long"
    t.integer "source_place_id"
    t.boolean "previously_looked_up"
    t.json "json_resp"
    t.string "display_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "postal_code_forecasts", force: :cascade do |t|
    t.string "postal_code"
    t.datetime "time_of_last_request"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "forecast_cache"
    t.string "grid_id"
    t.integer "grid_x"
    t.integer "grid_y"
    t.string "station_url"
  end

end

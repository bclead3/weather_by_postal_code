# frozen_string_literal: true

require 'httparty'

class LatLongFromAddress < ApplicationRecord
  include WebAddressRequest

  scope :postal_code_forecast, lambda {
                                 PostalCodeForecast.find_by(postal_code)
                               } # belongs_to :postal_code_forecast, foreign_key: :postal_code

  validates :address, presence: true
  validates :city, presence: true

  def full_address
    full_addr = "#{address}, #{city}"
    full_addr += ", #{state}" if state.present?
    full_addr += "  #{zip}" if zip.present?
    full_addr += "  #{postal_code}" if postal_code.present?
    full_addr
  end

  def zip_code
    working_zip = zip.to_s.gsub('-', '').gsub(' ', '').gsub('_', '')
    if working_zip.length > 5 &&
       working_zip.length < 10 &&
       country == 'United States'
      final_four_digits = working_zip[-4..] # remove the last four
      working_zip = working_zip.gsub(final_four_digits, '')
      '%05d' % working_zip.to_i
    elsif zip.to_s.length == 5
      postal_code[0..4]
    else
      '%05d' % zip.to_i
    end
  end

  def populate
    unless previously_looked_up
      resp = issue_request(full_address)
      json_resp = JSON.parse(resp)
      json_resp = json_resp.first if json_resp.is_a?(Array)
      if json_resp
        self.json_resp = json_resp
        self.source_place_id = json_resp['place_id']
        self.lat = json_resp['lat']
        self.long = json_resp['lon']
        self.previously_looked_up = true
        self.display_address = json_resp['display_name']
        if json_resp['address']
          self.city = json_resp['address']['city'] || json_resp['address']['town']
          self.county = json_resp['address']['county']
          self.state = json_resp['address']['state']
          self.postal_code = json_resp['address']['postcode']
          self.country = json_resp['address']['country']
          self.zip = json_resp['address']['postcode'] if country == 'United States'
        end
        save
      end
    end

    postal_code_forecast = nil
    postal_code_forecast = PostalCodeForecast.find_or_create_by(postal_code: postal_code) if postal_code
    if postal_code_forecast&.time_of_last_request.blank?
      postal_code_forecast&.update(time_of_last_request: DateTime.now)
      Rails.logger.info("Updated PostalCodeForecast #{postal_code} time_of_last_request:#{postal_code_forecast.time_of_last_request}")
    end
    postal_code_forecast
  rescue StandardError => e
    Rails.logger.warn("Standard Error msg:#{e.message}")
  end
end

# state: nil,
#  zip: nil,
#  postal_code: nil,
#  county: nil,
#  country: nil,
#  lat: nil,
#  long: nil,
#  source_place_id: nil,
#  previously_looked_up: nil,
#  json_resp: nil,
#  display_address: nil,

# [{"place_id"=>304085596,
#   "licence"=>"Data ?? OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
#   "osm_type"=>"way",
#   "osm_id"=>6011740,
#   "boundingbox"=>["44.960952388524", "44.961052388524", "-93.37858629794", "-93.37848629794"],
#   "lat"=>"44.96100238852435",
#   "lon"=>"-93.37853629793962",
#   "display_name"=>"2235, Quebec Avenue South, Willow Park, Saint Louis Park, Hennepin County, Minnesota, 55426, United States",
#   "class"=>"place",
#   "type"=>"house",
#   "importance"=>0.711,
#   "address"=>
#    {"house_number"=>"2235",
#     "road"=>"Quebec Avenue South",
#     "neighbourhood"=>"Willow Park",
#     "city"=>"Saint Louis Park",
#     "county"=>"Hennepin County",
#     "state"=>"Minnesota",
#     "postcode"=>"55426",
#     "country"=>"United States",
#     "country_code"=>"us"}}]

# frozen_string_literal: true

require 'httparty'

module WebAddressRequest
  def issue_request(full_address)
    encoded_address = full_address.gsub(' ', '+')
    uri = URI.parse('https://nominatim.openstreetmap.org/search')
    params = {
      q: encoded_address,
      format: 'json',
      polygon: 1,
      addressdetails: 1
    }

    uri.query = URI.encode_www_form(params)
    response = HTTParty.get(uri)

    response.body
  rescue StandardError => e
    e.message
  end
end

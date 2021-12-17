module WebAddressRequest

  def request_address(address_string, city = nil, state = nil, zip = nil)
    build_address = "#{address_string}, #{city}"
    build_address += ", #{state}" if state
    build_address += "  #{zip}" if zip

    issue_request(build_address)
  end

  def request_w_full_address(full_address)
    issue_request(full_address)
  end

  def issue_request(full_address)
    encoded_address = full_address.gsub(' ', '+')
    uri = URI.parse('https://nominatim.openstreetmap.org/search')
    params = {
      q: encoded_address,
      format: 'json',
      polygon: 1,
      addressdetails: 1
    }

    uri.query = URI.encode_www_form( params )
    response = Net::HTTP.get(uri)
  rescue StandardError => std_err
    std_err.message
  end
end

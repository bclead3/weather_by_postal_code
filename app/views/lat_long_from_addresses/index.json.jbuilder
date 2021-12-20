# frozen_string_literal: true

json.array! @lat_long_from_addresses, partial: 'lat_long_from_addresses/lat_long_from_address',
                                      as: :lat_long_from_address

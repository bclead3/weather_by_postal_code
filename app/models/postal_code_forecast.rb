
class PostalCodeForecast < ApplicationRecord
  has_many :lat_long_from_address

  CACHE_MINUTE_LIMIT = 30

  validates :postal_code, presence: true

  def is_below_cache_expiration
    present_ts = DateTime.now
    last_ts = self.time_of_last_request
    diff = present_ts.utc.to_i - last_ts.to_i
    diff < CACHE_MINUTE_LIMIT * 60
  end
end

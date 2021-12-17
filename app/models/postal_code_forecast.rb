class PostalCodeForecast < ApplicationRecord
  has_many :lat_long_from_address

  validates :postal_code, presence: true

end

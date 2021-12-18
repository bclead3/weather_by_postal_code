class ForecastPeriod < ApplicationRecord
  #belongs_to :postal_code_forecast, foreign_key: :postal_code

  scope :postal_code_forecast, -> { PostalCodeForecast.find_by(self.postal_code) }

  validates :postal_code, presence: true
  validates :start_time,  presence: true
  validates :end_time,    presence: true
  validates :temperature, presence: true
  validates :temperature_unit, presence: true
end
